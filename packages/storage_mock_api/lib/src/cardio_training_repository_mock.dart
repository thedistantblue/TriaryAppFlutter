import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';

class CardioTrainingRepositoryMock implements BaseCardioTrainingRepository {
  final UuidGenerator _uuidGenerator;
  final Map<String, CardioTraining> _idToTrainingMap = {};

  CardioTrainingRepositoryMock(this._uuidGenerator);

  @override
  CardioTraining create(CardioTraining powerTraining) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<CardioTraining?> findById(String id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

  @override
  Future<Iterable<CardioTraining>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<Iterable<CardioTraining>> findAllById(Iterable<String> ids) {
    // TODO: implement findAllById
    throw UnimplementedError();
  }

  @override
  Future<CardioTraining?> deleteById(String id) {
    // TODO: implement deleteById
    throw UnimplementedError();
  }

}