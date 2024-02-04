abstract class BaseRepository<T> {
  T create(T training);
  Future<T?> findById(String id);
  Future<Iterable<T>> findAllById(Iterable<String> ids);
  Future<T?> deleteById(String id);
}