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

class PowerTrainingTable extends Table {
  TextColumn get id => text().withLength(min: 0, max: 90)();
  TextColumn get data => text().map(converter)();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [PowerTrainingTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            // id становится primary key; SQLite не умеет менять PK через ALTER,
            // поэтому пересоздаём таблицу, сохраняя данные.
            await customStatement(
                'ALTER TABLE power_training_table RENAME TO power_training_table_old');
            await m.createTable(powerTrainingTable);
            await customStatement(
                'INSERT INTO power_training_table (id, data) '
                'SELECT id, data FROM power_training_table_old');
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
