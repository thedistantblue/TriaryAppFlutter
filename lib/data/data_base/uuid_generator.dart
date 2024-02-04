import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UuidGenerator {

  final BuildContext _context;

  const UuidGenerator(this._context);

  String generateUuid() {
    return Provider.of<Uuid>(_context).v4();
  }
}