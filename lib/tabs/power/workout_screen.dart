import 'package:entity/entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:storage_api/storage_api.dart';
import 'package:triary_app/bloc/workout_bloc.dart';
import 'package:triary_app/l10n/app_localizations.dart';
import 'package:triary_app/widgets/change_set_card.dart';
import 'package:triary_app/widgets/exercise_row.dart';
import 'package:triary_app/widgets/set_card.dart';
import 'package:triary_app/widgets/set_summary.dart';
import 'package:triary_app/widgets/workout_style.dart';

/// Экран предстоящей тренировки (борды 09–13 макета).
class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final training =
        ModalRoute.of(context)!.settings.arguments as PowerTraining;

    return BlocProvider(
      create: (context) => WorkoutBloc(
        Provider.of<BaseExerciseSetRepository>(context, listen: false),
        Provider.of<BaseExerciseRepository>(context, listen: false),
      )..add(WorkoutStarted(training)),
      child: _WorkoutView(training: training),
    );
  }
}

class _WorkoutView extends StatelessWidget {
  const _WorkoutView({required this.training});

  final PowerTraining training;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _WorkoutAppBar(training: training),
          Expanded(
            child: BlocBuilder<WorkoutBloc, WorkoutState>(
              builder: (context, state) {
                final exerciseSet = state.exerciseSet;
                final totalSets = state.exercises.fold<int>(
                  0,
                  (sum, exercise) => sum + exercise.sets,
                );

                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: WorkoutStyle.cardGap),
                            _CardWrapper(
                              child: ChangeSetCard(
                                hasSet: exerciseSet != null,
                                onTap: () {},
                              ),
                            ),
                            if (exerciseSet != null) ...[
                              const SizedBox(height: WorkoutStyle.cardGap),
                              _CardWrapper(
                                child: SetCard(
                                  exerciseSet: exerciseSet,
                                  exercises: state.exercises,
                                  isExpanded: state.isExpanded,
                                  onToggle: () => context
                                      .read<WorkoutBloc>()
                                      .add(const SetExpansionToggled()),
                                  onShowFullSet: () => _showFullSetSheet(
                                    context,
                                    exerciseSet,
                                    state.exercises,
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(height: WorkoutStyle.cardGap),
                            _CardWrapper(
                              child: SetSummary(
                                exerciseCount: state.exercises.length,
                                setCount: totalSets,
                                estimatedMinutes:
                                    estimateWorkoutMinutes(totalSets),
                                isActive: exerciseSet != null,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _WorkoutButtons(canStart: exerciseSet != null),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFullSetSheet(
    BuildContext context,
    ExerciseSet exerciseSet,
    List<Exercise> exercises,
  ) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      barrierColor: Colors.black.withValues(alpha: WorkoutStyle.scrimOpacity),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(WorkoutStyle.sheetRadius),
        ),
      ),
      isScrollControlled: true,
      builder: (context) => _FullSetSheet(
        exerciseSet: exerciseSet,
        exercises: exercises,
      ),
    );
  }
}

class _CardWrapper extends StatelessWidget {
  const _CardWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: WorkoutStyle.horizontalMargin,
      ),
      child: child,
    );
  }
}

class _WorkoutAppBar extends StatelessWidget {
  const _WorkoutAppBar({required this.training});

  final PowerTraining training;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.surface,
      padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
      child: SizedBox(
        height: WorkoutStyle.appBarHeight,
        child: Stack(
          children: [
            Positioned(
              left: 4,
              top: 4,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                iconSize: 24,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints.tightFor(
                  width: 48,
                  height: 48,
                ),
                icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              top: 50,
              child: Text(
                training.name,
                style: WorkoutStyle.title.copyWith(
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              top: 92,
              child: Text(
                training.description,
                style: WorkoutStyle.description.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(height: 1, color: colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkoutButtons extends StatelessWidget {
  const _WorkoutButtons({required this.canStart});

  final bool canStart;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: 36),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: WorkoutStyle.horizontalMargin,
        ),
        child: Column(
          children: [
            _ActionButton(
              label: l10n.previousTrainings,
              backgroundColor: colorScheme.secondary,
              foregroundColor: colorScheme.onSecondary,
              onPressed: () {},
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: _ActionButton(
                    label: l10n.edit,
                    backgroundColor: colorScheme.tertiary,
                    foregroundColor: colorScheme.onTertiary,
                    onPressed: canStart ? () {} : null,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ActionButton(
                    label: l10n.start,
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    onPressed: canStart ? () {} : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Кнопка 48/r24 из макета. Действий в этой итерации нет: `null` — недоступна
/// (борд 13), пустой колбэк — доступна, но ничего не делает.
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: WorkoutStyle.actionButtonHeight,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: WorkoutStyle.disabledBackground,
          disabledForegroundColor: WorkoutStyle.disabledForeground,
          textStyle: WorkoutStyle.buttonLabel,
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WorkoutStyle.actionButtonRadius),
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

class _FullSetSheet extends StatelessWidget {
  const _FullSetSheet({required this.exerciseSet, required this.exercises});

  final ExerciseSet exerciseSet;
  final List<Exercise> exercises;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final totalSets = exercises.fold<int>(
      0,
      (sum, exercise) => sum + exercise.sets,
    );

    return SizedBox(
      height: WorkoutStyle.sheetHeight,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
              left: WorkoutStyle.horizontalMargin,
              right: WorkoutStyle.horizontalMargin,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exerciseSet.name,
                  style: WorkoutStyle.sheetTitle.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  '${exercises.length} ${l10n.exercisesCount(exercises.length)}'
                  ' · $totalSets ${l10n.setsCount(totalSets)}',
                  style: WorkoutStyle.sheetSubtitle.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          Container(height: 1, color: colorScheme.outline),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(
                bottom: MediaQuery.paddingOf(context).bottom,
              ),
              itemCount: exercises.length,
              itemBuilder: (context, index) => ExerciseRow(
                exercise: exercises[index],
                withDivider: index > 0,
                dividerInset: WorkoutStyle.horizontalMargin,
                padding: const EdgeInsets.symmetric(
                  horizontal: WorkoutStyle.horizontalMargin,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
