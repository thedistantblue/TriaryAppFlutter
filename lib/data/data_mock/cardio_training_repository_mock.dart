import 'package:flutter/material.dart';
import 'package:triary_app/data/data_base/base_cardio_training_repository.dart';
import 'package:triary_app/entity/training/cardio_training.dart';

class CardioTrainingRepositoryMock implements BaseCardioTrainingRepository {
  final BuildContext _buildContext;
  final Map<String, CardioTraining> _idToTrainingMap = {};

  CardioTrainingRepositoryMock(this._buildContext);

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