import 'dart:convert';

import 'package:entity/entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:storage_api/storage_api.dart';

class PowerTrainingRepository extends BasePowerTrainingRepository {
  final UuidGenerator _uuidGenerator;
  final Database _database;

  PowerTrainingRepository(this._uuidGenerator, this._database);

  @override
  PowerTraining create(PowerTraining training) {
    training.id = _uuidGenerator.generateUuid();
    _database.insert(
      powerTrainingRepositoryTable,
      {
        'id': training.id,
        'data': jsonEncode(training.toJson()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return training;
  }

  @override
  Future<PowerTraining?> findById(String id) async {
    final result = await _database.query(
      powerTrainingRepositoryTable,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.length > 1) {
      throw Exception('More than one element found with id $id');
    }
    return PowerTraining.fromJson(result.first);
  }

  @override
  Future<Iterable<PowerTraining>> findAll() async {
    final result = await _database.query(powerTrainingRepositoryTable);
    final allData = result.map((e) {
      return jsonDecode(e['data']! as String) as Map<String, dynamic>;
    }).toList();
    return allData.map(PowerTraining.fromJson);
  }

  @override
  Future<Iterable<PowerTraining>> findAllById(Iterable<String> ids) async {
    final result = await _database.query(
      powerTrainingRepositoryTable,
      where: 'id = ?',
      whereArgs: ids.toList(),
    );
    return result.map(PowerTraining.fromJson);
  }

  @override
  void deleteById(String id) {
    _database.delete(
      powerTrainingRepositoryTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}