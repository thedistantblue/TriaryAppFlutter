import 'package:sqflite/sqflite.dart';
import 'package:triary_app/data/data_base/base_cardio_training_repository.dart';
import 'package:triary_app/data/data_base/uuid_generator.dart';
import 'package:triary_app/entity/training/cardio_training.dart';

class CardioTrainingRepository extends BaseCardioTrainingRepository {
  final UuidGenerator _uuidGenerator;
  final Database _database;

  CardioTrainingRepository(this._uuidGenerator, this._database);

  @override
  CardioTraining create(CardioTraining training) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<CardioTraining?> findById(String id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<Iterable<CardioTraining>> findAll() async {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<Iterable<CardioTraining>> findAllById(Iterable<String> ids) {
    // TODO: implement findAllById
    throw UnimplementedError();
  }

  @override
  void deleteById(String id) {
    // TODO: implement deleteById
    throw UnimplementedError();
  }

}