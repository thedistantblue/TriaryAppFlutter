import 'package:entity/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:storage_api/storage_api.dart';
import 'package:triary_app/bloc/exercise_catalog_bloc.dart';
import 'package:triary_app/l10n/app_localizations.dart';
import 'package:triary_app/widgets/dialogs.dart';

class ExerciseCatalogScreen extends StatelessWidget {
  const ExerciseCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseCatalogBloc(
        context.read<BaseCategoryRepository>(),
        context.read<BaseExerciseRepository>(),
      )..add(ExerciseCatalogLoaded()),
      child: const _CatalogView(),
    );
  }
}

class _CatalogView extends StatelessWidget {
  const _CatalogView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.exercises)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addCategory(context),
        label: Text(l10n.addCategory),
        icon: const Icon(Icons.add),
      ),
      body: BlocConsumer<ExerciseCatalogBloc, ExerciseCatalogState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage(state.error!, l10n))),
            );
          }
        },
        builder: (context, state) {
          if (state.status == ExerciseCatalogStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          final topLevel = state.categories
              .where((c) => c.parentId == null)
              .toList()
            ..sort((a, b) => a.name.compareTo(b.name));
          if (topLevel.isEmpty) {
            return Center(child: Text(l10n.addCategory));
          }
          return ListView.builder(
            itemCount: topLevel.length,
            itemBuilder: (context, index) {
              final category = topLevel[index];
              final count = _exerciseCount(
                  category.id, state.categories, state.exercises);
              return ListTile(
                title: Text(category.name),
                subtitle: Text('$count ${l10n.exercisesCount}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _deleteCategory(context, category),
                ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ExerciseCategoryScreen(
                      category: category,
                      bloc: context.read<ExerciseCatalogBloc>(),
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

  Future<void> _addCategory(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final name = await showNameDialog(context, title: l10n.addCategory);
    if (name == null) return;
    context
        .read<ExerciseCatalogBloc>()
        .add(ExerciseCategoryAdded(Category(name: name)));
  }

  Future<void> _deleteCategory(BuildContext context, Category category) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.categoryDeletion,
      message: '${l10n.categoryDeletionText} ${category.name}?',
    );
    if (confirmed) {
      context
          .read<ExerciseCatalogBloc>()
          .add(ExerciseCategoryDeleted(category.id));
    }
  }
}

class ExerciseCategoryScreen extends StatelessWidget {
  final Category category;
  final ExerciseCatalogBloc bloc;

  const ExerciseCategoryScreen({
    super.key,
    required this.category,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddMenu(context),
        label: Text(l10n.addExercise),
        icon: const Icon(Icons.add),
      ),
      body: BlocConsumer<ExerciseCatalogBloc, ExerciseCatalogState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage(state.error!, l10n))),
            );
          }
        },
        builder: (context, state) {
          final subcategories = state.categories
              .where((c) => c.parentId == category.id)
              .toList()
            ..sort((a, b) => a.name.compareTo(b.name));
          final exercises = state.exercises
              .where((e) => e.categoryId == category.id)
              .toList()
            ..sort((a, b) => a.name.compareTo(b.name));

          return ListView(
            children: [
              for (final sub in subcategories)
                ListTile(
                  leading: const Icon(Icons.folder_outlined),
                  title: Text(sub.name),
                  subtitle: Text(
                    '${_exerciseCount(sub.id, state.categories, state.exercises)} '
                    '${l10n.exercisesCount}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _deleteCategory(context, sub),
                  ),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ExerciseCategoryScreen(
                        category: sub,
                        bloc: bloc,
                      ),
                    ),
                  ),
                ),
              if (subcategories.isNotEmpty && exercises.isNotEmpty)
                const Divider(),
              for (final exercise in exercises)
                ListTile(
                  leading: const Icon(Icons.fitness_center),
                  title: Text(exercise.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => _deleteExercise(context, exercise),
                  ),
                ),
              if (subcategories.isEmpty && exercises.isEmpty)
                Center(child: Text(l10n.addExercise)),
            ],
          );
        },
      ),
    );
  }

  void _showAddMenu(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.folder_outlined),
            title: Text(l10n.addSubcategory),
            onTap: () {
              Navigator.of(context).pop();
              _addSubcategory(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.fitness_center),
            title: Text(l10n.addExercise),
            onTap: () {
              Navigator.of(context).pop();
              _addExercise(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _addSubcategory(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final name = await showNameDialog(context, title: l10n.addSubcategory);
    if (name == null) return;
    bloc.add(ExerciseCategoryAdded(Category(name: name, parentId: category.id)));
  }

  Future<void> _addExercise(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final name = await showNameDialog(context, title: l10n.addExercise);
    if (name == null) return;
    bloc.add(ExerciseAdded(
      Exercise(name: name, categoryId: category.id),
    ));
  }

  Future<void> _deleteCategory(BuildContext context, Category target) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.categoryDeletion,
      message: '${l10n.categoryDeletionText} ${target.name}?',
    );
    if (confirmed) {
      bloc.add(ExerciseCategoryDeleted(target.id));
    }
  }

  Future<void> _deleteExercise(BuildContext context, Exercise exercise) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showConfirmDialog(
      context,
      title: l10n.exerciseDeletion,
      message: '${l10n.exerciseDeletionText} ${exercise.name}?',
    );
    if (confirmed) {
      bloc.add(ExerciseDeleted(exercise.id));
    }
  }
}

int _exerciseCount(
  String categoryId,
  List<Category> categories,
  List<Exercise> exercises,
) {
  var count = exercises.where((e) => e.categoryId == categoryId).length;
  for (final sub in categories.where((c) => c.parentId == categoryId)) {
    count += _exerciseCount(sub.id, categories, exercises);
  }
  return count;
}
