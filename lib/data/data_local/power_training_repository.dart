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
    training.id = Provider.of<UuidGenerator>(_buildContext).generateUuid();
    //  _database.insert(
    //     powerTrainingRepositoryTable,
    //     values,
    //     conflictAlgorithm: ConflictAlgorithm.replace
    // );
     return training;
  }

  @override
  Future<PowerTraining?> deleteById(String id) {
    // TODO: implement deleteById
    throw UnimplementedError();
  }

  @override
  Future<Iterable<PowerTraining>> findAllById(Iterable<String> ids) {
    // TODO: implement findAllById
    throw UnimplementedError();
  }

  @override
  Future<PowerTraining?> findById(String id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

}