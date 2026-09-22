import 'package:drift/drift.dart';
import 'package:entity/entity.dart';
import 'package:storage_api/storage_api.dart';
import 'package:storage_local_api/local_storage_api.dart';

class CategoryRepository extends BaseCategoryRepository {
  final UuidGenerator _uuidGenerator;
  final AppDatabase _database;

  CategoryRepository(this._uuidGenerator, this._database);

  @override
  Future<Category> create(Category category) async {
    final name = category.name.trim();
    if (name.isEmpty) {
      throw const EmptyNameException();
    }
    final existing = await (_database.select(_database.categoryTable)
          ..where((t) => t.name.equals(name)))
        .getSingleOrNull();
    if (existing != null) {
      throw NameAlreadyExistsException(name);
    }
    final persisted = category.copyWith(
      id: _uuidGenerator.generateUuid(),
      name: name,
    );
    await _database.into(_database.categoryTable).insert(
          CategoryTableCompanion.insert(
            id: persisted.id,
            name: persisted.name,
            parentId: Value(persisted.parentId),
          ),
        );
    return persisted;
  }

  @override
  Future<Iterable<Category>> findAll() async {
    final rows = await _database.select(_database.categoryTable).get();
    return rows
        .map((e) => Category(id: e.id, name: e.name, parentId: e.parentId))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  Future<void> deleteById(String id) async {
    final child = await (_database.select(_database.categoryTable)
          ..where((t) => t.parentId.equals(id)))
        .getSingleOrNull();
    if (child != null) {
      throw const EntityInUseException();
    }
    final exercise = await (_database.select(_database.exerciseTable)
          ..where((t) => t.categoryId.equals(id)))
        .getSingleOrNull();
    if (exercise != null) {
      throw const EntityInUseException();
    }
    await (_database.delete(_database.categoryTable)
          ..where((t) => t.id.equals(id)))
        .go();
  }
}
