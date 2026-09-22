import 'package:entity/entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_api/storage_api.dart';

part 'exercise_set_event.dart';

part 'exercise_set_state.dart';

class ExerciseSetBloc extends Bloc<ExerciseSetEvent, ExerciseSetState> {
  final BaseExerciseSetRepository _repository;

  ExerciseSetBloc(this._repository) : super(const ExerciseSetState()) {
    on<ExerciseSetsLoaded>(_onLoaded);
    on<ExerciseSetCreated>(_onCreated);
    on<ExerciseSetCurrentChanged>(_onCurrentChanged);
    on<ExerciseSetItemAdded>(_onItemAdded);
    on<ExerciseSetItemRemoved>(_onItemRemoved);
    on<ExerciseSetItemsReordered>(_onItemsReordered);
    on<ExerciseSetDeleted>(_onDeleted);
  }

  Future<void> _onLoaded(
    ExerciseSetsLoaded event,
    Emitter<ExerciseSetState> emit,
  ) async {
    await _reload(emit);
  }

  Future<void> _onCreated(
    ExerciseSetCreated event,
    Emitter<ExerciseSetState> emit,
  ) async {
    try {
      await _repository.create(event.set);
      await _reload(emit);
    } catch (e) {
      emit(state.copyWith(status: ExerciseSetStatus.failure, error: e));
    }
  }

  Future<void> _onCurrentChanged(
    ExerciseSetCurrentChanged event,
    Emitter<ExerciseSetState> emit,
  ) async {
    try {
      await _repository.setCurrent(event.id);
      await _reload(emit);
    } catch (e) {
      emit(state.copyWith(status: ExerciseSetStatus.failure, error: e));
    }
  }

  Future<void> _onItemAdded(
    ExerciseSetItemAdded event,
    Emitter<ExerciseSetState> emit,
  ) async {
    try {
      await _repository.addItem(event.setId, event.exerciseId);
      await _reload(emit);
    } catch (e) {
      emit(state.copyWith(status: ExerciseSetStatus.failure, error: e));
    }
  }

  Future<void> _onItemRemoved(
    ExerciseSetItemRemoved event,
    Emitter<ExerciseSetState> emit,
  ) async {
    try {
      await _repository.softDeleteItem(event.setId, event.exerciseId);
      await _reload(emit);
    } catch (e) {
      emit(state.copyWith(status: ExerciseSetStatus.failure, error: e));
    }
  }

  Future<void> _onItemsReordered(
    ExerciseSetItemsReordered event,
    Emitter<ExerciseSetState> emit,
  ) async {
    try {
      await _repository.reorder(event.setId, event.exerciseIds);
      await _reload(emit);
    } catch (e) {
      emit(state.copyWith(status: ExerciseSetStatus.failure, error: e));
    }
  }

  Future<void> _onDeleted(
    ExerciseSetDeleted event,
    Emitter<ExerciseSetState> emit,
  ) async {
    try {
      await _repository.deleteById(event.id);
      await _reload(emit);
    } catch (e) {
      emit(state.copyWith(status: ExerciseSetStatus.failure, error: e));
    }
  }

  Future<void> _reload(Emitter<ExerciseSetState> emit) async {
    try {
      final sets = (await _repository.findAll()).toList();
      final itemsBySet = <String, List<ExerciseSetItem>>{};
      for (final set in sets) {
        itemsBySet[set.id] =
            (await _repository.findAllItems(set.id)).toList();
      }
      emit(
        state.copyWith(
          status: ExerciseSetStatus.success,
          sets: sets,
          itemsBySet: itemsBySet,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ExerciseSetStatus.failure, error: e));
    }
  }
}
