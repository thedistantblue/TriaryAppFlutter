import 'package:flutter/material.dart';
import 'package:triary_app/l10n/app_localizations.dart';
import 'package:triary_app/widgets/workout_style.dart';

/// Строка над карточкой набора: «Сменить набор упражнений», а если набор не
/// выбран — выделенное приглашение «Выбрать набор упражнений».
class ChangeSetCard extends StatelessWidget {
  const ChangeSetCard({
    super.key,
    required this.hasSet,
    required this.onTap,
  });

  final bool hasSet;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final foreground = hasSet ? colorScheme.onSurface : colorScheme.primary;
    final textStyle =
        (hasSet ? WorkoutStyle.changeSet : WorkoutStyle.changeSetActive)
            .copyWith(color: foreground);

    return Material(
      color: hasSet ? colorScheme.surface : WorkoutStyle.inviteBackground,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(WorkoutStyle.setCardRadius),
        side: hasSet
            ? BorderSide.none
            : BorderSide(color: colorScheme.primary, width: 1),
      ),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: WorkoutStyle.changeSetCardHeight,
          child: Row(
            children: [
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  hasSet ? l10n.changeSet : l10n.chooseSet,
                  style: textStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 24,
                color: hasSet
                    ? colorScheme.onSurfaceVariant
                    : colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
