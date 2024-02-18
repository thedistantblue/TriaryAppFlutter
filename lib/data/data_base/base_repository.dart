abstract class BaseRepository<T> {
  T create(T training);
  Future<T?> findById(String id);
  Future<Iterable<T>> findAll();
  Future<Iterable<T>> findAllById(Iterable<String> ids);
  void deleteById(String id);
}