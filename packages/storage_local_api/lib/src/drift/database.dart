import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:entity/entity.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

final TypeConverter<PowerTraining, String> converter =
  TypeConverter.json(
    fromJson: (json) => PowerTraining.fromJson(json as Map<String, dynamic>),
    toJson: (powerTraining) => powerTraining.toJson(),
  );

class PowerTrainingTable extends Table {
  TextColumn get id => text().withLength(min: 0, max: 90)();
  TextColumn get data => text().map(converter)();
}

@DriftDatabase(tables: [PowerTrainingTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'triary_app.db'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;

    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
