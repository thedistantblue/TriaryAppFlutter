import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:entity/entity.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

part 'database.g.dart';

final TypeConverter<PowerTraining, String> converter =
  TypeConverter.json(
    fromJson: (json) => PowerTraining.fromJson(json as Map<String, dynamic>),
    toJson: (powerTraining) => powerTraining.toJson(),
  );

final TypeConverter<Exercise, String> exerciseConverter =
  TypeConverter.json(
    fromJson: (json) => Exercise.fromJson(json as Map<String, dynamic>),
    toJson: (exercise) => exercise.toJson(),
  );

final TypeConverter<ExerciseSet, String> exerciseSetConverter =
  TypeConverter.json(
    fromJson: (json) => ExerciseSet.fromJson(json as Map<String, dynamic>),
    toJson: (exerciseSet) => exerciseSet.toJson(),
  );

class PowerTrainingTable extends Table {
  TextColumn get id => text().withLength(min: 0, max: 90)();
  TextColumn get data => text().map(converter)();

  /// Ссылка на выбранный набор упражнений; null — набор не выбран.
  TextColumn get setId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class ExerciseTable extends Table {
  TextColumn get id => text().withLength(min: 0, max: 90)();
  TextColumn get data => text().map(exerciseConverter)();

  @override
  Set<Column> get primaryKey => {id};
}

class ExerciseSetTable extends Table {
  TextColumn get id => text().withLength(min: 0, max: 90)();
  TextColumn get data => text().map(exerciseSetConverter)();

  @override
  Set<Column> get primaryKey => {id};
}

/// Связка многие-ко-многим между наборами и упражнениями. Порядок упражнений
/// внутри набора хранится в колонке position (0..n-1).
class ExerciseSetLinkTable extends Table {
  TextColumn get setId => text()();
  TextColumn get exerciseId => text()();
  IntColumn get position => integer()();

  @override
  Set<Column> get primaryKey => {setId, exerciseId};
}

@DriftDatabase(
  tables: [
    PowerTrainingTable,
    ExerciseTable,
    ExerciseSetTable,
    ExerciseSetLinkTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// Схема пересобирается с нуля: миграций нет, onCreate создаёт все таблицы
  /// сразу в актуальном виде. База прежних сборок не поддерживается.
  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'triary_app.db'));

    final cachebase = (await getTemporaryDirectory()).path;

    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
