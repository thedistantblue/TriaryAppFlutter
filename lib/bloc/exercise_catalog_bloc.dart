import 'package:entity/entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_api/storage_api.dart';

part 'exercise_catalog_event.dart';

part 'exercise_catalog_state.dart';

class ExerciseCatalogBloc
    extends Bloc<ExerciseCatalogEvent, ExerciseCatalogState> {
  final BaseCategoryRepository _categoryRepository;
  final BaseExerciseRepository _exerciseRepository;

  ExerciseCatalogBloc(this._categoryRepository, this._exerciseRepository)
      : super(const ExerciseCatalogState()) {
    on<ExerciseCatalogLoaded>(_onLoaded);
    on<ExerciseCategoryAdded>(_onCategoryAdded);
    on<ExerciseAdded>(_onExerciseAdded);
    on<ExerciseCategoryDeleted>(_onCategoryDeleted);
    on<ExerciseDeleted>(_onExerciseDeleted);
  }

  Future<void> _onLoaded(
    ExerciseCatalogLoaded event,
    Emitter<ExerciseCatalogState> emit,
  ) async {
    await _reload(emit);
  }

  Future<void> _onCategoryAdded(
    ExerciseCategoryAdded event,
    Emitter<ExerciseCatalogState> emit,
  ) async {
    try {
      await _categoryRepository.create(event.category);
      await _reload(emit);
    } catch (e) {
      emit(state.copyWith(status: ExerciseCatalogStatus.failure, error: e));
    }
  }

  Future<void> _onExerciseAdded(
    ExerciseAdded event,
    Emitter<ExerciseCatalogState> emit,
  ) async {
    try {
      await _exerciseRepository.create(event.exercise);
      await _reload(emit);
    } catch (e) {
      emit(state.copyWith(status: ExerciseCatalogStatus.failure, error: e));
    }
  }

  Future<void> _onCategoryDeleted(
    ExerciseCategoryDeleted event,
    Emitter<ExerciseCatalogState> emit,
  ) async {
    try {
      await _categoryRepository.deleteById(event.id);
      await _reload(emit);
    } catch (e) {
      emit(state.copyWith(status: ExerciseCatalogStatus.failure, error: e));
    }
  }

  Future<void> _onExerciseDeleted(
    ExerciseDeleted event,
    Emitter<ExerciseCatalogState> emit,
  ) async {
    try {
      await _exerciseRepository.deleteById(event.id);
      await _reload(emit);
    } catch (e) {
      emit(state.copyWith(status: ExerciseCatalogStatus.failure, error: e));
    }
  }

  Future<void> _reload(Emitter<ExerciseCatalogState> emit) async {
    try {
      final categories = (await _categoryRepository.findAll()).toList();
      final exercises = (await _exerciseRepository.findAll()).toList();
      emit(
        state.copyWith(
          status: ExerciseCatalogStatus.success,
          categories: categories,
          exercises: exercises,
          error: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ExerciseCatalogStatus.failure, error: e));
    }
  }
}
