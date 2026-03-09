// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get offlineUsage => 'Оффлайн использование';

  @override
  String get onlineUsage => 'Онлайн использование';

  @override
  String get powerTrainingDetails => 'Детали силовой тренировки';

  @override
  String get addTraining => 'Добавить тренировку';

  @override
  String get trainingDeletion => 'Удаление тренировки';

  @override
  String get trainingDeletionText =>
      'Вы уверены, что хотите удалить тренировку';

  @override
  String get delete => 'Удалить';

  @override
  String get cancel => 'Отмена';

  @override
  String get exercises => 'Упражнения';

  @override
  String get exercisesSets => 'Наборы упражнений';

  @override
  String get dates => 'Даты';

  @override
  String get powerTraining => 'Силовые тренировки';

  @override
  String get cardioTraining => 'Кардио тренировки';

  @override
  String get name => 'Имя';

  @override
  String get description => 'Описание';

  @override
  String get create => 'Создать';
}
