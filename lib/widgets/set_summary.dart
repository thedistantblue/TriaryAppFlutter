import 'package:flutter/material.dart';
import 'package:triary_app/l10n/app_localizations.dart';
import 'package:triary_app/widgets/workout_style.dart';

/// Сводка под карточкой набора: число упражнений, суммарные подходы и
/// оценка длительности. Числа — акцентные, когда набор выбран.
class SetSummary extends StatelessWidget {
  const SetSummary({
    super.key,
    required this.exerciseCount,
    required this.setCount,
    required this.estimatedMinutes,
    required this.isActive,
  });

  final int exerciseCount;
  final int setCount;
  final int estimatedMinutes;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final numberColor =
        isActive ? colorScheme.primary : colorScheme.onSurfaceVariant;
    final labelStyle = WorkoutStyle.summaryLabel.copyWith(
      color: colorScheme.onSurfaceVariant,
    );
    final numberStyle = WorkoutStyle.summaryNumber.copyWith(
      color: numberColor,
    );
    final separatorStyle = WorkoutStyle.summaryLabel.copyWith(
      color: colorScheme.outline,
    );

    return Container(
      height: WorkoutStyle.summaryHeight,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(WorkoutStyle.summaryRadius),
      ),
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '$exerciseCount ', style: numberStyle),
            TextSpan(text: l10n.exercisesCount(exerciseCount), style: labelStyle),
            const TextSpan(text: ' '),
            TextSpan(text: '·', style: separatorStyle),
            const TextSpan(text: ' '),
            TextSpan(text: '$setCount ', style: numberStyle),
            TextSpan(text: l10n.setsCount(setCount), style: labelStyle),
            const TextSpan(text: ' '),
            TextSpan(text: '·', style: separatorStyle),
            const TextSpan(text: ' '),
            TextSpan(
              text: isActive ? '~$estimatedMinutes ' : '$estimatedMinutes ',
              style: numberStyle,
            ),
            TextSpan(text: l10n.minutesShort, style: labelStyle),
          ],
        ),
        maxLines: 1,
        textAlign: TextAlign.center,
      ),
    );
  }
}
