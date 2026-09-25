// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get offlineUsage => 'Offline usage';

  @override
  String get onlineUsage => 'Online usage';

  @override
  String get powerTrainingDetails => 'Power training details';

  @override
  String get addTraining => 'Add training';

  @override
  String get trainingDeletion => 'Training deletion';

  @override
  String get trainingDeletionText => 'Are you sure you want to delete training';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get exercises => 'Exercises';

  @override
  String get exercisesSets => 'Sets of exercises';

  @override
  String get dates => 'Dates';

  @override
  String get powerTraining => 'Power training';

  @override
  String get cardioTraining => 'Cardio training';

  @override
  String get name => 'Name';

  @override
  String get description => 'Description';

  @override
  String get create => 'Create';

  @override
  String get noTrainings => 'No trainings yet';

  @override
  String get noTrainingsHint =>
      'Tap the add button to create your first training';

  @override
  String get nameRequired => 'Name is required';

  @override
  String trainingDeleted(String name) {
    return '$name deleted';
  }

  @override
  String get startTraining => 'Start training';

  @override
  String get changeSet => 'Change exercise set';

  @override
  String get chooseSet => 'Choose exercise set';

  @override
  String get previousTrainings => 'Previous workouts';

  @override
  String get edit => 'Edit';

  @override
  String get start => 'Start';

  @override
  String exercisesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'exercises',
      one: 'exercise',
    );
    return '$_temp0';
  }

  @override
  String setsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sets',
      one: 'set',
    );
    return '$_temp0';
  }

  @override
  String get minutesShort => 'min';

  @override
  String moreExercises(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '# more exercises',
      one: '# more exercise',
    );
    return 'and $_temp0';
  }
}
