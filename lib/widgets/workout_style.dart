import 'package:flutter/material.dart';

/// Значения сняты с макета Penpot (борды 09–13). Меняются только вместе
/// с макетом: это не «примерные», а точные размеры и цвета бордов.
class WorkoutStyle {
  const WorkoutStyle._();

  /// Сколько строк упражнений показывать в развёрнутом наборе.
  static const int setPreviewLimit = 3;

  /// Оценка длительности: 4 минуты на подход, округление до 10 минут.
  static const int minutesPerSet = 4;
  static const int roundMinutesTo = 10;

  static const double appBarHeight = 136;
  static const double horizontalMargin = 24;
  static const double cardGap = 16;
  static const double changeSetCardHeight = 56;
  static const double setCardRadius = 16;
  static const double setHeaderHeight = 64;
  static const double exerciseRowHeight = 48;
  static const double summaryHeight = 40;
  static const double summaryRadius = 12;
  static const double actionButtonHeight = 48;
  static const double actionButtonRadius = 24;
  static const double sheetHeight = 380;
  static const double sheetRadius = 24;
  static const double scrimOpacity = 0.55;

  /// Цвета, которых нет в ColorScheme приложения.
  static const Color disabledBackground = Color(0xFF2C3039);
  static const Color disabledForeground = Color(0xFF72767E);
  static const Color inviteBackground = Color(0xFF1C3436);

  static const TextStyle title = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle description = TextStyle(fontSize: 14);
  static const TextStyle changeSet = TextStyle(fontSize: 15);
  static const TextStyle changeSetActive = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle setName = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle exerciseName = TextStyle(fontSize: 15);
  static const TextStyle exerciseReps = TextStyle(fontSize: 14);
  static const TextStyle summaryNumber = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle summaryLabel = TextStyle(fontSize: 13);
  static const TextStyle buttonLabel = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle sheetTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle sheetSubtitle = TextStyle(fontSize: 13);
}

/// Оценка длительности тренировки по числу подходов. Ноль подходов — ноль
/// минут; иначе минимум 10 минут (в макете других значений нет).
int estimateWorkoutMinutes(int totalSets) {
  if (totalSets <= 0) {
    return 0;
  }
  final raw = totalSets * WorkoutStyle.minutesPerSet;
  final rounded = (raw / WorkoutStyle.roundMinutesTo).round() *
      WorkoutStyle.roundMinutesTo;
  return rounded < WorkoutStyle.roundMinutesTo
      ? WorkoutStyle.roundMinutesTo
      : rounded;
}
