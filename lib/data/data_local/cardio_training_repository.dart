import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:triary_app/data/data_base/base_cardio_training_repository.dart';
import 'package:triary_app/entity/training/cardio_training.dart';

class CardioTrainingRepository extends BaseCardioTrainingRepository {
  final BuildContext _buildContext;
  final Database _database;

  CardioTrainingRepository(this._buildContext, this._database);

  @override
  CardioTraining create(CardioTraining training) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<CardioTraining?> deleteById(String id) {
    // TODO: implement deleteById
    throw UnimplementedError();
  }

  @override
  Future<Iterable<CardioTraining>> findAllById(Iterable<String> ids) {
    // TODO: implement findAllById
    throw UnimplementedError();
  }

  @override
  Future<CardioTraining?> findById(String id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

}