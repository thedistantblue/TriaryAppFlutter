class EmptyNameException implements Exception {
  const EmptyNameException();

  @override
  String toString() => 'EmptyNameException: name must not be empty';
}

class NameAlreadyExistsException implements Exception {
  const NameAlreadyExistsException(this.name);

  final String name;

  @override
  String toString() => 'NameAlreadyExistsException: $name';
}

class EntityInUseException implements Exception {
  const EntityInUseException();

  @override
  String toString() => 'EntityInUseException: entity is in use';
}
