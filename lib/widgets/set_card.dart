import 'dart:math' as math;

import 'package:entity/entity.dart';
import 'package:flutter/material.dart';
import 'package:triary_app/l10n/app_localizations.dart';
import 'package:triary_app/widgets/exercise_row.dart';
import 'package:triary_app/widgets/workout_style.dart';

/// Карточка набора упражнений: шапка с именем и переключателем, строки
/// упражнений с лимитом показа и футер «и ещё N упражнений».
class SetCard extends StatelessWidget {
  const SetCard({
    super.key,
    required this.exerciseSet,
    required this.exercises,
    required this.isExpanded,
    required this.onToggle,
    required this.onShowFullSet,
    this.previewLimit = WorkoutStyle.setPreviewLimit,
  });

  final ExerciseSet exerciseSet;
  final List<Exercise> exercises;
  final bool isExpanded;
  final VoidCallback onToggle;
  final VoidCallback onShowFullSet;
  final int previewLimit;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final visibleExercises =
        isExpanded ? exercises.take(previewLimit).toList() : const <Exercise>[];
    final hiddenCount = exercises.length - visibleExercises.length;

    return Material(
      color: colorScheme.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(WorkoutStyle.setCardRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: onToggle,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: WorkoutStyle.setHeaderHeight,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      exerciseSet.name,
                      style: WorkoutStyle.setName.copyWith(
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Transform.rotate(
                    angle: isExpanded ? math.pi / 2 : 0,
                    child: Icon(
                      Icons.chevron_right,
                      size: 24,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          for (final exercise in visibleExercises)
            ExerciseRow(exercise: exercise, withDivider: true),
          if (isExpanded && hiddenCount > 0)
            _SetFooterRow(hiddenCount: hiddenCount, onTap: onShowFullSet),
        ],
      ),
    );
  }
}

class _SetFooterRow extends StatelessWidget {
  const _SetFooterRow({required this.hiddenCount, required this.onTap});

  final int hiddenCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(height: 1, color: colorScheme.outline),
          ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: WorkoutStyle.exerciseRowHeight - 1,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.moreExercises(hiddenCount),
                      style: WorkoutStyle.exerciseReps.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: 24,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
