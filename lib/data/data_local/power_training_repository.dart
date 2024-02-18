import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:triary_app/data/data_base/base_power_training_repository.dart';
import 'package:triary_app/data/data_base/repository_constants.dart';
import 'package:triary_app/data/data_base/uuid_generator.dart';
import 'package:triary_app/entity/training/power_training.dart';

class PowerTrainingRepository extends BasePowerTrainingRepository {
  final BuildContext _buildContext;
  final Database _database;

  PowerTrainingRepository(this._buildContext, this._database);

  @override
  PowerTraining create(PowerTraining training) {
    training.id = Provider.of<UuidGenerator>(_buildContext, listen: false).generateUuid();
     _database.insert(
        powerTrainingRepositoryTable,
        {'data': training.toJson()},
        conflictAlgorithm: ConflictAlgorithm.replace
    );
     return training;
  }

  @override
  Future<PowerTraining?> findById(String id) async {
    var result = await _database.query(
        powerTrainingRepositoryTable,
        where: 'id = ?',
        whereArgs: [id]
    );
    if (result.length > 1) {
      throw Exception("More than one element found with id $id");
    }
    return PowerTraining.fromJson(result.first);
  }

  @override
  Future<Iterable<PowerTraining>> findAll() async {
    var result = await _database.query(powerTrainingRepositoryTable);
    return result.map((map) => PowerTraining.fromJson(map));
  }

  @override
  Future<Iterable<PowerTraining>> findAllById(Iterable<String> ids) async {
    var result = await _database.query(
        powerTrainingRepositoryTable,
        where: 'id = ?',
        whereArgs: ids.toList()
    );
    return result.map((map) => PowerTraining.fromJson(map));
  }

  @override
  void deleteById(String id) {
    _database.delete(
      powerTrainingRepositoryTable,
      where: 'id = ?',
      whereArgs: [id]
    );
  }

}