import 'dart:async';

import 'package:entity/entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_api/storage_api.dart';

part 'power_training_execution_event.dart';

part 'power_training_execution_state.dart';

class PowerTrainingExecutionBloc
    extends Bloc<PowerTrainingExecutionEvent, PowerTrainingExecutionState> {
  final BasePowerTrainingRepository _trainingRepository;
  final BaseExerciseSetRepository _setRepository;
  final BaseExerciseRepository _exerciseRepository;
  final BasePowerTrainingApproachRepository _approachRepository;

  Timer? _restTimer;

  PowerTrainingExecutionBloc(
    this._trainingRepository,
    this._setRepository,
    this._exerciseRepository,
    this._approachRepository,
  ) : super(const PowerTrainingExecutionState()) {
    on<PowerTrainingExecutionStarted>(_onStarted);
    on<PowerTrainingApproachAdded>(_onApproachAdded);
    on<PowerTrainingApproachRemoved>(_onApproachRemoved);
    on<PowerTrainingNextExercise>(_onNextExercise);
    on<PowerTrainingPreviousRequested>(_onPreviousRequested);
    on<PowerTrainingPreviousApplied>(_onPreviousApplied);
    on<PowerTrainingExecutionFinished>(_onFinished);
    on<RestTimerStarted>(_onRestTimerStarted);
    on<RestTimerCancelled>(_onRestTimerCancelled);
  }

  @override
  Future<void> close() {
    _restTimer?.cancel();
    return super.close();
  }

  Future<void> _onStarted(
    PowerTrainingExecutionStarted event,
    Emitter<PowerTrainingExecutionState> emit,
  ) async {
    try {
      final training = await _trainingRepository.findById(event.trainingId);
      if (training == null) {
        emit(
          state.copyWith(
            status: PowerTrainingExecutionStatus.failure,
            error: StateError('training not found'),
          ),
        );
        return;
      }
      final exercises = await _loadExercises(training.exerciseSetId);
      final approaches = await _approachRepository.findByTraining(training.id);
      emit(
        state.copyWith(
          status: PowerTrainingExecutionStatus.success,
          training: training,
          exercises: exercises,
          approachesByExercise: _group(approaches),
          currentExerciseIndex: 0,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PowerTrainingExecutionStatus.failure,
          error: e,
        ),
      );
    }
  }

  Future<List<Exercise>> _loadExercises(String? setId) async {
    if (setId == null) return const <Exercise>[];
    final items = await _setRepository.findAllItems(setId);
    final all = await _exerciseRepository.findAll();
    final byId = {for (final e in all) e.id: e};
    return items
        .map((item) => byId[item.exerciseId])
        .whereType<Exercise>()
        .toList();
  }

  Map<String, List<PowerTrainingApproach>> _group(
    Iterable<PowerTrainingApproach> approaches,
  ) {
    final map = <String, List<PowerTrainingApproach>>{};
    for (final a in approaches) {
      map.putIfAbsent(a.exerciseId, () => <PowerTrainingApproach>[]).add(a);
    }
    for (final list in map.values) {
      list.sort((a, b) => a.position.compareTo(b.position));
    }
    return map;
  }

  int _nextPosition(String exerciseId) {
    final existing =
        state.approachesByExercise[exerciseId] ?? const <PowerTrainingApproach>[];
    if (existing.isEmpty) return 0;
    var max = existing.first.position;
    for (final a in existing) {
      if (a.position > max) max = a.position;
    }
    return max + 1;
  }

  Future<void> _onApproachAdded(
    PowerTrainingApproachAdded event,
    Emitter<PowerTrainingExecutionState> emit,
  ) async {
    try {
      final trainingId = state.training?.id;
      if (trainingId == null) return;
      await _approachRepository.create(
        PowerTrainingApproach(
          powerTrainingId: trainingId,
          exerciseId: event.exerciseId,
          position: _nextPosition(event.exerciseId),
          reps: event.reps,
          weight: event.weight,
          source: ApproachSource.manual,
        ),
      );
      await _reloadApproaches(emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: PowerTrainingExecutionStatus.failure,
          error: e,
        ),
      );
    }
  }

  Future<void> _onApproachRemoved(
    PowerTrainingApproachRemoved event,
    Emitter<PowerTrainingExecutionState> emit,
  ) async {
    try {
      await _approachRepository.deleteById(event.approachId);
      await _reloadApproaches(emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: PowerTrainingExecutionStatus.failure,
          error: e,
        ),
      );
    }
  }

  Future<void> _onNextExercise(
    PowerTrainingNextExercise event,
    Emitter<PowerTrainingExecutionState> emit,
  ) async {
    if (state.currentExerciseIndex < state.exercises.length - 1) {
      emit(
        state.copyWith(currentExerciseIndex: state.currentExerciseIndex + 1),
      );
    }
  }

  Future<void> _onPreviousRequested(
    PowerTrainingPreviousRequested event,
    Emitter<PowerTrainingExecutionState> emit,
  ) async {
    try {
      final records =
          (await _approachRepository.findByExercise(event.exerciseId)).toList();
      emit(
        state.copyWith(
          previousRecords: records,
          previousExerciseId: event.exerciseId,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PowerTrainingExecutionStatus.failure,
          error: e,
        ),
      );
    }
  }

  Future<void> _onPreviousApplied(
    PowerTrainingPreviousApplied event,
    Emitter<PowerTrainingExecutionState> emit,
  ) async {
    try {
      final trainingId = state.training?.id;
      if (trainingId == null) return;
      var position = _nextPosition(event.exerciseId);
      for (final source in event.source) {
        await _approachRepository.create(
          PowerTrainingApproach(
            powerTrainingId: trainingId,
            exerciseId: event.exerciseId,
            position: position,
            reps: source.reps,
            weight: source.weight,
            source: ApproachSource.applied,
          ),
        );
        position++;
      }
      await _reloadApproaches(emit);
    } catch (e) {
      emit(
        state.copyWith(
          status: PowerTrainingExecutionStatus.failure,
          error: e,
        ),
      );
    }
  }

  Future<void> _onFinished(
    PowerTrainingExecutionFinished event,
    Emitter<PowerTrainingExecutionState> emit,
  ) async {
    try {
      final trainingId = state.training?.id;
      if (trainingId == null) return;
      await _trainingRepository.setDate(trainingId, DateTime.now());
      emit(state.copyWith(finished: true));
    } catch (e) {
      emit(
        state.copyWith(
          status: PowerTrainingExecutionStatus.failure,
          error: e,
        ),
      );
    }
  }

  Future<void> _onRestTimerStarted(
    RestTimerStarted event,
    Emitter<PowerTrainingExecutionState> emit,
  ) async {
    _restTimer?.cancel();
    var remaining = event.seconds;
    emit(
      state.copyWith(
        restRemaining: remaining,
        restDuration: event.seconds,
      ),
    );
    _restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remaining--;
      if (remaining <= 0) {
        timer.cancel();
        _restTimer = null;
        if (!isClosed) {
          emit(state.copyWith(restRemaining: null, restDuration: 0));
        }
      } else if (!isClosed) {
        emit(state.copyWith(restRemaining: remaining));
      }
    });
  }

  Future<void> _onRestTimerCancelled(
    RestTimerCancelled event,
    Emitter<PowerTrainingExecutionState> emit,
  ) async {
    _restTimer?.cancel();
    _restTimer = null;
    emit(state.copyWith(restRemaining: null, restDuration: 0));
  }

  Future<void> _reloadApproaches(
    Emitter<PowerTrainingExecutionState> emit,
  ) async {
    final trainingId = state.training?.id;
    if (trainingId == null) return;
    final approaches = await _approachRepository.findByTraining(trainingId);
    emit(
      state.copyWith(
        status: PowerTrainingExecutionStatus.success,
        error: null,
        approachesByExercise: _group(approaches),
      ),
    );
  }
}
