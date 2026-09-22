abstract class BaseRepository<T> {
  Future<T> create(T training);
  Future<T?> findById(String id);
  Stream<Iterable<T>> findAll();
  Future<Iterable<T>> findAllById(Iterable<String> ids);
  Future<void> deleteById(String id);
}