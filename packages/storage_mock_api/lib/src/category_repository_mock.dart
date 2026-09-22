import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';
import 'package:storage_mock_api/src/in_memory_store.dart';

class CategoryRepositoryMock implements BaseCategoryRepository {
  final UuidGenerator _uuidGenerator;
  final InMemoryStore _store;

  CategoryRepositoryMock(this._uuidGenerator, this._store);

  @override
  Future<Category> create(Category category) async {
    await Future.delayed(const Duration(milliseconds: 2));
    final name = category.name.trim();
    if (name.isEmpty) {
      throw const EmptyNameException();
    }
    final exists = _store.categories.values.any((c) => c.name == name);
    if (exists) {
      throw NameAlreadyExistsException(name);
    }
    final persisted = category.copyWith(
      id: _uuidGenerator.generateUuid(),
      name: name,
    );
    _store.categories[persisted.id] = persisted;
    return persisted;
  }

  @override
  Future<Iterable<Category>> findAll() async {
    await Future.delayed(const Duration(milliseconds: 2));
    final categories = _store.categories.values.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    return categories;
  }

  @override
  Future<void> deleteById(String id) async {
    await Future.delayed(const Duration(milliseconds: 2));
    final hasChild = _store.categories.values.any((c) => c.parentId == id);
    if (hasChild) {
      throw const EntityInUseException();
    }
    final hasExercise = _store.exercises.values.any((e) => e.categoryId == id);
    if (hasExercise) {
      throw const EntityInUseException();
    }
    _store.categories.remove(id);
  }
}
