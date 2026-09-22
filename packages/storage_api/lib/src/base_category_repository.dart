import 'package:entity/entity.dart';

abstract class BaseCategoryRepository {
  Future<Category> create(Category category);

  Future<Iterable<Category>> findAll();

  Future<void> deleteById(String id);
}
