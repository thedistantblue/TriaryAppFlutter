import 'package:entity/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:storage_api/storage_api.dart';
import 'package:triary_app/bloc/exercise_set_bloc.dart';
import 'package:triary_app/l10n/app_localizations.dart';
import 'package:triary_app/widgets/dialogs.dart';

class ExerciseSetScreen extends StatelessWidget {
  const ExerciseSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseSetBloc(
        context.read<BaseExerciseSetRepository>(),
      )..add(ExerciseSetsLoaded()),
      child: const _SetListView(),
    );
  }
}

class _SetListView extends StatelessWidget {
  const _SetListView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.exercisesSets)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addSet(context),
        label: Text(l10n.addSet),
        icon: const Icon(Icons.add),
      ),
      body: BlocConsumer<ExerciseSetBloc, ExerciseSetState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage(state.error!, l10n))),
            );
          }
        },
        builder: (context, state) {
          if (state.status == ExerciseSetStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.sets.isEmpty) {
            return Center(child: Text(l10n.addSet));
          }
          return ListView.builder(
            itemCount: state.sets.length,
            itemBuilder: (context, index) {
              final set = state.sets[index];
              final count = state.itemsBySet[set.id]?.length ?? 0;
              return ListTile(
                title: Text(set.name),
                subtitle: Text(
                  set.isCurrent
                      ? '${l10n.currentSet} · $count ${l10n.exercisesCount}'
                      : '$count ${l10n.exercisesCount}',
                ),
                leading: set.isCurrent
                    ? const Icon(Icons.check_circle)
                    : const Icon(Icons.radio_button_unchecked),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!set.isCurrent)
                      IconButton(
                        icon: const Icon(Icons.check),
                        tooltip: l10n.currentSet,
                        onPressed: () => context
                            .read<ExerciseSetBloc>()
                            .add(ExerciseSetCurrentChanged(set.id)),
                      ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _deleteSet(context, set),
                    ),
                  ],
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ExerciseSetEditScreen(
                      setId: set.id,
                      bloc: context.read<ExerciseSetBloc>(),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _addSet(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final name = await showNameDialog(context, title: l10n.addSet);
    if (name == null) return;
    context
        .read<ExerciseSetBloc>()
        .add(ExerciseSetCreated(ExerciseSet(name: name)));
  }

  Future<void> _deleteSet(BuildContext context, ExerciseSet set) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.setDeletion,
      message: '${l10n.setDeletionText} ${set.name}?',
    );
    if (confirmed) {
      context.read<ExerciseSetBloc>().add(ExerciseSetDeleted(set.id));
    }
  }
}

class ExerciseSetEditScreen extends StatefulWidget {
  final String setId;
  final ExerciseSetBloc bloc;

  const ExerciseSetEditScreen({
    super.key,
    required this.setId,
    required this.bloc,
  });

  @override
  State<ExerciseSetEditScreen> createState() => _ExerciseSetEditScreenState();
}

class _ExerciseSetEditScreenState extends State<ExerciseSetEditScreen> {
  List<Exercise> _allExercises = const [];

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    final repo = context.read<BaseExerciseRepository>();
    final exercises = await repo.findAll();
    if (mounted) {
      setState(() => _allExercises = exercises.toList());
    }
  }

  Map<String, String> get _nameById => {for (final e in _allExercises) e.id: e.name};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.exercisesSets)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showExercisePicker(context),
        label: Text(l10n.addExercise),
        icon: const Icon(Icons.add),
      ),
      body: BlocBuilder<ExerciseSetBloc, ExerciseSetState>(
        bloc: widget.bloc,
        builder: (context, state) {
          final items =
              state.itemsBySet[widget.setId] ?? const <ExerciseSetItem>[];
          if (items.isEmpty) {
            return Center(child: Text(l10n.addExercise));
          }
          return ReorderableListView.builder(
            itemCount: items.length,
            onReorder: (oldIndex, newIndex) {
              if (newIndex > oldIndex) newIndex--;
              final ids = items.map((i) => i.exerciseId).toList();
              final moved = ids.removeAt(oldIndex);
              ids.insert(newIndex, moved);
              widget.bloc
                  .add(ExerciseSetItemsReordered(widget.setId, ids));
            },
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                key: Key(item.id),
                title: Text(_nameById[item.exerciseId] ?? '?'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => widget.bloc.add(
                    ExerciseSetItemRemoved(widget.setId, item.exerciseId),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showExercisePicker(BuildContext context) {
    final items =
        widget.bloc.state.itemsBySet[widget.setId] ?? const <ExerciseSetItem>[];
    final existingIds = items.map((i) => i.exerciseId).toSet();
    final available = _allExercises
        .where((e) => !existingIds.contains(e.id))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    showModalBottomSheet<void>(
      context: context,
      builder: (context) => ListView(
        children: available
            .map(
              (e) => ListTile(
                title: Text(e.name),
                onTap: () {
                  widget.bloc.add(ExerciseSetItemAdded(widget.setId, e.id));
                  Navigator.of(context).pop();
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
