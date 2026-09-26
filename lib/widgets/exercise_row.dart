import 'package:entity/entity.dart';
import 'package:flutter/material.dart';
import 'package:triary_app/widgets/workout_style.dart';

/// Строка упражнения: имя слева, подходы и повторы справа. Одна и та же
/// строка используется в карточке набора и в шторке полного списка,
/// отличаются только отступы и врезка разделителя.
///
/// Высота строки — минимальная: с обычным системным шрифтом она совпадает
/// с макетом (48), а при увеличенном масштабе шрифта строка растёт вместе
/// с текстом вместо того, чтобы его обрезать.
class ExerciseRow extends StatelessWidget {
  const ExerciseRow({
    super.key,
    required this.exercise,
    this.withDivider = false,
    this.dividerInset = 0,
    this.padding = const EdgeInsets.only(left: 16, right: 24),
  });

  final Exercise exercise;
  final bool withDivider;

  /// Отступ разделителя от краёв карточки (в шторке — 24).
  final double dividerInset;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (withDivider)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: dividerInset),
            child: Container(height: 1, color: colorScheme.outline),
          ),
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: withDivider
                ? WorkoutStyle.exerciseRowHeight - 1
                : WorkoutStyle.exerciseRowHeight,
          ),
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    exercise.name,
                    style: WorkoutStyle.exerciseName.copyWith(
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${exercise.sets} × ${exercise.reps}',
                  style: WorkoutStyle.exerciseReps.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
