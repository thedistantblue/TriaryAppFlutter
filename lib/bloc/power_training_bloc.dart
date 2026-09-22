import 'package:entity/entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    await _reload(emit);
  }

  Future<void> _onTrainingCreated(
    PowerTrainingCreated event,
    Emitter<PowerTrainingState> emit,
  ) async {
    try {
      await _repository.create(event.training);
      await _reload(emit);
    } catch (_) {
      emit(state.copyWith(status: PowerTrainingStatus.failure));
    }
  }

  Future<void> _onTrainingDeleted(
    PowerTrainingDeleted event,
    Emitter<PowerTrainingState> emit,
  ) async {
    try {
      await _repository.deleteById(event.training.id);
      await _reload(emit);
    } catch (_) {
      emit(state.copyWith(status: PowerTrainingStatus.failure));
    }
  }

  Future<void> _onTrainingChanged(
    PowerTrainingChanged event,
    Emitter<PowerTrainingState> emit,
  ) async {
    await _reload(emit);
  }

  Future<void> _reload(Emitter<PowerTrainingState> emit) async {
    try {
      final trainings = (await _repository.findAllSortedByDate()).toList();
      emit(
        state.copyWith(
          status: PowerTrainingStatus.success,
          powerTrainings: trainings,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: PowerTrainingStatus.failure));
    }
  }
}
