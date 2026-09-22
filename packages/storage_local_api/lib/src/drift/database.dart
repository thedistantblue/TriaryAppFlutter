import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:entity/entity.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

part 'database.g.dart';

class CategoryTable extends Table {
  TextColumn get id => text().withLength(min: 0, max: 90)();
  TextColumn get name => text().unique()();
  TextColumn get parentId => text().nullable().references(CategoryTable, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

class ExerciseTable extends Table {
  TextColumn get id => text().withLength(min: 0, max: 90)();
  TextColumn get name => text().unique()();
  TextColumn get categoryId => text().references(CategoryTable, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

class ExerciseSetTable extends Table {
  TextColumn get id => text().withLength(min: 0, max: 90)();
  TextColumn get name => text().unique()();
  TextColumn get description => text().nullable()();
  BoolColumn get isCurrent => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

class ExerciseSetItemTable extends Table {
  TextColumn get id => text().withLength(min: 0, max: 90)();
  TextColumn get exerciseSetId => text().references(ExerciseSetTable, #id)();
  TextColumn get exerciseId => text().references(ExerciseTable, #id)();
  IntColumn get position => integer()();
  BoolColumn get isDeleted => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

class PowerTrainingTable extends Table {
  TextColumn get id => text().withLength(min: 0, max: 90)();
  TextColumn get name => text()();
  TextColumn get description => text()();
  DateTimeColumn get date => dateTime().nullable()();
  TextColumn get exerciseSetId =>
      text().nullable().references(ExerciseSetTable, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

class PowerTrainingApproachTable extends Table {
  TextColumn get id => text().withLength(min: 0, max: 90)();
  TextColumn get powerTrainingId =>
      text().references(PowerTrainingTable, #id)();
  TextColumn get exerciseId => text().references(ExerciseTable, #id)();
  IntColumn get position => integer()();
  IntColumn get reps => integer()();
  RealColumn get weight => real()();
  TextColumn get source => textEnum<ApproachSource>()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [
  CategoryTable,
  ExerciseTable,
  ExerciseSetTable,
  ExerciseSetItemTable,
  PowerTrainingTable,
  PowerTrainingApproachTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 3) {
            // Любая версия < 3: power_training_table хранила сущность целиком
            // в JSON-колонке data (id, data). Перестраиваем таблицу на явные
            // колонки (id, name, description, date, exercise_set_id), извлекая
            // name/description из JSON. Остальные таблицы создаются заново.
            await customStatement(
                'ALTER TABLE power_training_table RENAME TO power_training_table_old');
            await m.createAll();
            final rows = await customSelect(
              'SELECT id, data FROM power_training_table_old',
            ).get();
            for (final row in rows) {
              final training = PowerTraining.fromJson(
                jsonDecode(row.read<String>('data')) as Map<String, dynamic>,
              );
              await into(powerTrainingTable).insert(
                PowerTrainingTableCompanion.insert(
                  id: training.id,
                  name: training.name,
                  description: training.description,
                ),
              );
            }
            await customStatement('DROP TABLE power_training_table_old');
          }
        },
      );
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
