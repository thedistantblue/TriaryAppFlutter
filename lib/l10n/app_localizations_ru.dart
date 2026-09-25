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

  @override
  String get noTrainings => 'Пока нет тренировок';

  @override
  String get noTrainingsHint =>
      'Нажмите «Добавить тренировку», чтобы создать первую';

  @override
  String get nameRequired => 'Укажите название';

  @override
  String trainingDeleted(String name) {
    return 'Удалено: $name';
  }

  @override
  String get startTraining => 'Начать тренировку';

  @override
  String get changeSet => 'Сменить набор упражнений';

  @override
  String get chooseSet => 'Выбрать набор упражнений';

  @override
  String get previousTrainings => 'Предыдущие тренировки';

  @override
  String get edit => 'Редактировать';

  @override
  String get start => 'Начать';

  @override
  String exercisesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'упражнения',
      many: 'упражнений',
      few: 'упражнения',
      one: 'упражнение',
    );
    return '$_temp0';
  }

  @override
  String setsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'подхода',
      many: 'подходов',
      few: 'подхода',
      one: 'подход',
    );
    return '$_temp0';
  }

  @override
  String get minutesShort => 'мин';

  @override
  String moreExercises(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# упражнения',
      many: '# упражнений',
      few: '# упражнения',
      one: '# упражнение',
    );
    return 'и ещё $_temp0';
  }
}
