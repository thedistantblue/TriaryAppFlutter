import 'package:entity/entity.dart';

/// Shared in-memory storage for mock repositories.
///
/// Mirrors the drift database (single shared state), so cross-entity
/// integrity checks behave like the real repositories.
class InMemoryStore {
  final Map<String, Category> categories = {};
  final Map<String, Exercise> exercises = {};
  final Map<String, ExerciseSet> sets = {};
  final Map<String, ExerciseSetItem> setItems = {};
  final Map<String, PowerTraining> trainings = {};
  final Map<String, PowerTrainingApproach> approaches = {};
}
