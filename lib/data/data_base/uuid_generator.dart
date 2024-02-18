import 'package:uuid/uuid.dart';

class UuidGenerator {

  final Uuid _uuid;

  const UuidGenerator(this._uuid);

  String generateUuid() {
    return _uuid.v4();
  }
}