import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:entity/entity.dart';
import 'package:equatable/equatable.dart';
import 'package:storage_api/storage_api.dart';

part 'power_training_event.dart';

part 'power_training_state.dart';

class PowerTrainingBloc extends Bloc<PowerTrainingEvent, PowerTrainingState> {
  final BasePowerTrainingRepository _repository;

  PowerTrainingBloc(this._repository) : super(const PowerTrainingState()) {
    on<PowerTrainingFetched>(_onTrainingFetched);
    on<PowerTrainingCreated>(_onTrainingCreated);
    on<PowerTrainingDeleted>(_onTrainingDeleted);
    on<PowerTrainingChanged>(_onTrainingChanged);
  }

  Future<void> _onTrainingFetched(
    PowerTrainingFetched event,
    Emitter<PowerTrainingState> emit,
  ) async {
    try {
      if (state.status == PowerTrainingStatus.initial) {
        await emit.forEach(
          _repository.findAll(),
          onData: (trainings) => state.copyWith(
            status: PowerTrainingStatus.success,
            powerTrainings: trainings.toList(),
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: PowerTrainingStatus.failure));
    }
  }

  Future<void> _onTrainingCreated(
    PowerTrainingCreated event,
    Emitter<PowerTrainingState> emit,
  ) async {
    try {
      _repository.create(event.training);
      // final trainings = await _repository.findAll();
      // return emit(state.copyWith(
      //   status: PowerTrainingStatus.success,
      //   powerTrainings: trainings.toList(),
      // ));
    } catch (_) {
      emit(state.copyWith(status: PowerTrainingStatus.failure));
    }
  }

  Future<void> _onTrainingDeleted(
    PowerTrainingDeleted event,
    Emitter<PowerTrainingState> emit,
  ) async {
    try {
      _repository.deleteById(event.training.id);
      // final trainings = await _repository.findAll();
      // return emit(state.copyWith(
      //   status: PowerTrainingStatus.success,
      //   powerTrainings: trainings.toList(),
      // ));
    } catch (_) {
      emit(state.copyWith(status: PowerTrainingStatus.failure));
    }
  }

  Future<void> _onTrainingChanged(
    PowerTrainingChanged event,
    Emitter<PowerTrainingState> emit,
  ) async {
    try {
      // final trainings = await _repository.findAll();
      // return emit(state.copyWith(
      //   status: PowerTrainingStatus.success,
      //   powerTrainings: trainings.toList(),
      // ));
    } catch (_) {
      emit(state.copyWith(status: PowerTrainingStatus.failure));
    }
  }
}
