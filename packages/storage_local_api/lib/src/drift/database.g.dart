// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CategoryTableTable extends CategoryTable
    with TableInfo<$CategoryTableTable, CategoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 90,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES category_table (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, parentId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
    );
  }

  @override
  $CategoryTableTable createAlias(String alias) {
    return $CategoryTableTable(attachedDatabase, alias);
  }
}

class CategoryTableData extends DataClass
    implements Insertable<CategoryTableData> {
  final String id;
  final String name;
  final String? parentId;
  const CategoryTableData({
    required this.id,
    required this.name,
    this.parentId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    return map;
  }

  CategoryTableCompanion toCompanion(bool nullToAbsent) {
    return CategoryTableCompanion(
      id: Value(id),
      name: Value(name),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
    );
  }

  factory CategoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      parentId: serializer.fromJson<String?>(json['parentId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'parentId': serializer.toJson<String?>(parentId),
    };
  }

  CategoryTableData copyWith({
    String? id,
    String? name,
    Value<String?> parentId = const Value.absent(),
  }) => CategoryTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    parentId: parentId.present ? parentId.value : this.parentId,
  );
  CategoryTableData copyWithCompanion(CategoryTableCompanion data) {
    return CategoryTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentId: $parentId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, parentId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.parentId == this.parentId);
}

class CategoryTableCompanion extends UpdateCompanion<CategoryTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> parentId;
  final Value<int> rowid;
  const CategoryTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.parentId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoryTableCompanion.insert({
    required String id,
    required String name,
    this.parentId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<CategoryTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? parentId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (parentId != null) 'parent_id': parentId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoryTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? parentId,
    Value<int>? rowid,
  }) {
    return CategoryTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('parentId: $parentId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseTableTable extends ExerciseTable
    with TableInfo<$ExerciseTableTable, ExerciseTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 90,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES category_table (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, categoryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
    );
  }

  @override
  $ExerciseTableTable createAlias(String alias) {
    return $ExerciseTableTable(attachedDatabase, alias);
  }
}

class ExerciseTableData extends DataClass
    implements Insertable<ExerciseTableData> {
  final String id;
  final String name;
  final String categoryId;
  const ExerciseTableData({
    required this.id,
    required this.name,
    required this.categoryId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['category_id'] = Variable<String>(categoryId);
    return map;
  }

  ExerciseTableCompanion toCompanion(bool nullToAbsent) {
    return ExerciseTableCompanion(
      id: Value(id),
      name: Value(name),
      categoryId: Value(categoryId),
    );
  }

  factory ExerciseTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'categoryId': serializer.toJson<String>(categoryId),
    };
  }

  ExerciseTableData copyWith({String? id, String? name, String? categoryId}) =>
      ExerciseTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        categoryId: categoryId ?? this.categoryId,
      );
  ExerciseTableData copyWithCompanion(ExerciseTableCompanion data) {
    return ExerciseTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, categoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.categoryId == this.categoryId);
}

class ExerciseTableCompanion extends UpdateCompanion<ExerciseTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> categoryId;
  final Value<int> rowid;
  const ExerciseTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseTableCompanion.insert({
    required String id,
    required String name,
    required String categoryId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       categoryId = Value(categoryId);
  static Insertable<ExerciseTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? categoryId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (categoryId != null) 'category_id': categoryId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? categoryId,
    Value<int>? rowid,
  }) {
    return ExerciseTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('categoryId: $categoryId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseSetTableTable extends ExerciseSetTable
    with TableInfo<$ExerciseSetTableTable, ExerciseSetTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseSetTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 90,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCurrentMeta = const VerificationMeta(
    'isCurrent',
  );
  @override
  late final GeneratedColumn<bool> isCurrent = GeneratedColumn<bool>(
    'is_current',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_current" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, description, isCurrent];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_set_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseSetTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_current')) {
      context.handle(
        _isCurrentMeta,
        isCurrent.isAcceptableOrUnknown(data['is_current']!, _isCurrentMeta),
      );
    } else if (isInserting) {
      context.missing(_isCurrentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseSetTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseSetTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isCurrent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_current'],
      )!,
    );
  }

  @override
  $ExerciseSetTableTable createAlias(String alias) {
    return $ExerciseSetTableTable(attachedDatabase, alias);
  }
}

class ExerciseSetTableData extends DataClass
    implements Insertable<ExerciseSetTableData> {
  final String id;
  final String name;
  final String? description;
  final bool isCurrent;
  const ExerciseSetTableData({
    required this.id,
    required this.name,
    this.description,
    required this.isCurrent,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_current'] = Variable<bool>(isCurrent);
    return map;
  }

  ExerciseSetTableCompanion toCompanion(bool nullToAbsent) {
    return ExerciseSetTableCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isCurrent: Value(isCurrent),
    );
  }

  factory ExerciseSetTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseSetTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      isCurrent: serializer.fromJson<bool>(json['isCurrent']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'isCurrent': serializer.toJson<bool>(isCurrent),
    };
  }

  ExerciseSetTableData copyWith({
    String? id,
    String? name,
    Value<String?> description = const Value.absent(),
    bool? isCurrent,
  }) => ExerciseSetTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    isCurrent: isCurrent ?? this.isCurrent,
  );
  ExerciseSetTableData copyWithCompanion(ExerciseSetTableCompanion data) {
    return ExerciseSetTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      isCurrent: data.isCurrent.present ? data.isCurrent.value : this.isCurrent,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isCurrent: $isCurrent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, isCurrent);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseSetTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.isCurrent == this.isCurrent);
}

class ExerciseSetTableCompanion extends UpdateCompanion<ExerciseSetTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> isCurrent;
  final Value<int> rowid;
  const ExerciseSetTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isCurrent = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseSetTableCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    required bool isCurrent,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       isCurrent = Value(isCurrent);
  static Insertable<ExerciseSetTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isCurrent,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isCurrent != null) 'is_current': isCurrent,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseSetTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<bool>? isCurrent,
    Value<int>? rowid,
  }) {
    return ExerciseSetTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      isCurrent: isCurrent ?? this.isCurrent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isCurrent.present) {
      map['is_current'] = Variable<bool>(isCurrent.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isCurrent: $isCurrent, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseSetItemTableTable extends ExerciseSetItemTable
    with TableInfo<$ExerciseSetItemTableTable, ExerciseSetItemTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseSetItemTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 90,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseSetIdMeta = const VerificationMeta(
    'exerciseSetId',
  );
  @override
  late final GeneratedColumn<String> exerciseSetId = GeneratedColumn<String>(
    'exercise_set_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercise_set_table (id)',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercise_table (id)',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDeletedMeta = const VerificationMeta(
    'isDeleted',
  );
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
    'is_deleted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_deleted" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseSetId,
    exerciseId,
    position,
    isDeleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_set_item_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseSetItemTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exercise_set_id')) {
      context.handle(
        _exerciseSetIdMeta,
        exerciseSetId.isAcceptableOrUnknown(
          data['exercise_set_id']!,
          _exerciseSetIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseSetIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(
        _isDeletedMeta,
        isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta),
      );
    } else if (isInserting) {
      context.missing(_isDeletedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseSetItemTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseSetItemTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      exerciseSetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_set_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      isDeleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_deleted'],
      )!,
    );
  }

  @override
  $ExerciseSetItemTableTable createAlias(String alias) {
    return $ExerciseSetItemTableTable(attachedDatabase, alias);
  }
}

class ExerciseSetItemTableData extends DataClass
    implements Insertable<ExerciseSetItemTableData> {
  final String id;
  final String exerciseSetId;
  final String exerciseId;
  final int position;
  final bool isDeleted;
  const ExerciseSetItemTableData({
    required this.id,
    required this.exerciseSetId,
    required this.exerciseId,
    required this.position,
    required this.isDeleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['exercise_set_id'] = Variable<String>(exerciseSetId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['position'] = Variable<int>(position);
    map['is_deleted'] = Variable<bool>(isDeleted);
    return map;
  }

  ExerciseSetItemTableCompanion toCompanion(bool nullToAbsent) {
    return ExerciseSetItemTableCompanion(
      id: Value(id),
      exerciseSetId: Value(exerciseSetId),
      exerciseId: Value(exerciseId),
      position: Value(position),
      isDeleted: Value(isDeleted),
    );
  }

  factory ExerciseSetItemTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseSetItemTableData(
      id: serializer.fromJson<String>(json['id']),
      exerciseSetId: serializer.fromJson<String>(json['exerciseSetId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      position: serializer.fromJson<int>(json['position']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'exerciseSetId': serializer.toJson<String>(exerciseSetId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'position': serializer.toJson<int>(position),
      'isDeleted': serializer.toJson<bool>(isDeleted),
    };
  }

  ExerciseSetItemTableData copyWith({
    String? id,
    String? exerciseSetId,
    String? exerciseId,
    int? position,
    bool? isDeleted,
  }) => ExerciseSetItemTableData(
    id: id ?? this.id,
    exerciseSetId: exerciseSetId ?? this.exerciseSetId,
    exerciseId: exerciseId ?? this.exerciseId,
    position: position ?? this.position,
    isDeleted: isDeleted ?? this.isDeleted,
  );
  ExerciseSetItemTableData copyWithCompanion(
    ExerciseSetItemTableCompanion data,
  ) {
    return ExerciseSetItemTableData(
      id: data.id.present ? data.id.value : this.id,
      exerciseSetId: data.exerciseSetId.present
          ? data.exerciseSetId.value
          : this.exerciseSetId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      position: data.position.present ? data.position.value : this.position,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetItemTableData(')
          ..write('id: $id, ')
          ..write('exerciseSetId: $exerciseSetId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position, ')
          ..write('isDeleted: $isDeleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, exerciseSetId, exerciseId, position, isDeleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseSetItemTableData &&
          other.id == this.id &&
          other.exerciseSetId == this.exerciseSetId &&
          other.exerciseId == this.exerciseId &&
          other.position == this.position &&
          other.isDeleted == this.isDeleted);
}

class ExerciseSetItemTableCompanion
    extends UpdateCompanion<ExerciseSetItemTableData> {
  final Value<String> id;
  final Value<String> exerciseSetId;
  final Value<String> exerciseId;
  final Value<int> position;
  final Value<bool> isDeleted;
  final Value<int> rowid;
  const ExerciseSetItemTableCompanion({
    this.id = const Value.absent(),
    this.exerciseSetId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.position = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseSetItemTableCompanion.insert({
    required String id,
    required String exerciseSetId,
    required String exerciseId,
    required int position,
    required bool isDeleted,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       exerciseSetId = Value(exerciseSetId),
       exerciseId = Value(exerciseId),
       position = Value(position),
       isDeleted = Value(isDeleted);
  static Insertable<ExerciseSetItemTableData> custom({
    Expression<String>? id,
    Expression<String>? exerciseSetId,
    Expression<String>? exerciseId,
    Expression<int>? position,
    Expression<bool>? isDeleted,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseSetId != null) 'exercise_set_id': exerciseSetId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (position != null) 'position': position,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseSetItemTableCompanion copyWith({
    Value<String>? id,
    Value<String>? exerciseSetId,
    Value<String>? exerciseId,
    Value<int>? position,
    Value<bool>? isDeleted,
    Value<int>? rowid,
  }) {
    return ExerciseSetItemTableCompanion(
      id: id ?? this.id,
      exerciseSetId: exerciseSetId ?? this.exerciseSetId,
      exerciseId: exerciseId ?? this.exerciseId,
      position: position ?? this.position,
      isDeleted: isDeleted ?? this.isDeleted,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (exerciseSetId.present) {
      map['exercise_set_id'] = Variable<String>(exerciseSetId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetItemTableCompanion(')
          ..write('id: $id, ')
          ..write('exerciseSetId: $exerciseSetId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PowerTrainingTableTable extends PowerTrainingTable
    with TableInfo<$PowerTrainingTableTable, PowerTrainingTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PowerTrainingTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 90,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exerciseSetIdMeta = const VerificationMeta(
    'exerciseSetId',
  );
  @override
  late final GeneratedColumn<String> exerciseSetId = GeneratedColumn<String>(
    'exercise_set_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercise_set_table (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    date,
    exerciseSetId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'power_training_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PowerTrainingTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('exercise_set_id')) {
      context.handle(
        _exerciseSetIdMeta,
        exerciseSetId.isAcceptableOrUnknown(
          data['exercise_set_id']!,
          _exerciseSetIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PowerTrainingTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PowerTrainingTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      ),
      exerciseSetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_set_id'],
      ),
    );
  }

  @override
  $PowerTrainingTableTable createAlias(String alias) {
    return $PowerTrainingTableTable(attachedDatabase, alias);
  }
}

class PowerTrainingTableData extends DataClass
    implements Insertable<PowerTrainingTableData> {
  final String id;
  final String name;
  final String description;
  final DateTime? date;
  final String? exerciseSetId;
  const PowerTrainingTableData({
    required this.id,
    required this.name,
    required this.description,
    this.date,
    this.exerciseSetId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    if (!nullToAbsent || exerciseSetId != null) {
      map['exercise_set_id'] = Variable<String>(exerciseSetId);
    }
    return map;
  }

  PowerTrainingTableCompanion toCompanion(bool nullToAbsent) {
    return PowerTrainingTableCompanion(
      id: Value(id),
      name: Value(name),
      description: Value(description),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      exerciseSetId: exerciseSetId == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseSetId),
    );
  }

  factory PowerTrainingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PowerTrainingTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      date: serializer.fromJson<DateTime?>(json['date']),
      exerciseSetId: serializer.fromJson<String?>(json['exerciseSetId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'date': serializer.toJson<DateTime?>(date),
      'exerciseSetId': serializer.toJson<String?>(exerciseSetId),
    };
  }

  PowerTrainingTableData copyWith({
    String? id,
    String? name,
    String? description,
    Value<DateTime?> date = const Value.absent(),
    Value<String?> exerciseSetId = const Value.absent(),
  }) => PowerTrainingTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description ?? this.description,
    date: date.present ? date.value : this.date,
    exerciseSetId: exerciseSetId.present
        ? exerciseSetId.value
        : this.exerciseSetId,
  );
  PowerTrainingTableData copyWithCompanion(PowerTrainingTableCompanion data) {
    return PowerTrainingTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      date: data.date.present ? data.date.value : this.date,
      exerciseSetId: data.exerciseSetId.present
          ? data.exerciseSetId.value
          : this.exerciseSetId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PowerTrainingTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('exerciseSetId: $exerciseSetId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, date, exerciseSetId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PowerTrainingTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.date == this.date &&
          other.exerciseSetId == this.exerciseSetId);
}

class PowerTrainingTableCompanion
    extends UpdateCompanion<PowerTrainingTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> description;
  final Value<DateTime?> date;
  final Value<String?> exerciseSetId;
  final Value<int> rowid;
  const PowerTrainingTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.date = const Value.absent(),
    this.exerciseSetId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PowerTrainingTableCompanion.insert({
    required String id,
    required String name,
    required String description,
    this.date = const Value.absent(),
    this.exerciseSetId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       description = Value(description);
  static Insertable<PowerTrainingTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? date,
    Expression<String>? exerciseSetId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (date != null) 'date': date,
      if (exerciseSetId != null) 'exercise_set_id': exerciseSetId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PowerTrainingTableCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? description,
    Value<DateTime?>? date,
    Value<String?>? exerciseSetId,
    Value<int>? rowid,
  }) {
    return PowerTrainingTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      date: date ?? this.date,
      exerciseSetId: exerciseSetId ?? this.exerciseSetId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (exerciseSetId.present) {
      map['exercise_set_id'] = Variable<String>(exerciseSetId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PowerTrainingTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('exerciseSetId: $exerciseSetId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PowerTrainingApproachTableTable extends PowerTrainingApproachTable
    with
        TableInfo<
          $PowerTrainingApproachTableTable,
          PowerTrainingApproachTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PowerTrainingApproachTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 0,
      maxTextLength: 90,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _powerTrainingIdMeta = const VerificationMeta(
    'powerTrainingId',
  );
  @override
  late final GeneratedColumn<String> powerTrainingId = GeneratedColumn<String>(
    'power_training_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES power_training_table (id)',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercise_table (id)',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ApproachSource, String> source =
      GeneratedColumn<String>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ApproachSource>(
        $PowerTrainingApproachTableTable.$convertersource,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    powerTrainingId,
    exerciseId,
    position,
    reps,
    weight,
    source,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'power_training_approach_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PowerTrainingApproachTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('power_training_id')) {
      context.handle(
        _powerTrainingIdMeta,
        powerTrainingId.isAcceptableOrUnknown(
          data['power_training_id']!,
          _powerTrainingIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_powerTrainingIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PowerTrainingApproachTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PowerTrainingApproachTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      powerTrainingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}power_training_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      source: $PowerTrainingApproachTableTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
    );
  }

  @override
  $PowerTrainingApproachTableTable createAlias(String alias) {
    return $PowerTrainingApproachTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ApproachSource, String, String> $convertersource =
      const EnumNameConverter<ApproachSource>(ApproachSource.values);
}

class PowerTrainingApproachTableData extends DataClass
    implements Insertable<PowerTrainingApproachTableData> {
  final String id;
  final String powerTrainingId;
  final String exerciseId;
  final int position;
  final int reps;
  final double weight;
  final ApproachSource source;
  const PowerTrainingApproachTableData({
    required this.id,
    required this.powerTrainingId,
    required this.exerciseId,
    required this.position,
    required this.reps,
    required this.weight,
    required this.source,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['power_training_id'] = Variable<String>(powerTrainingId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['position'] = Variable<int>(position);
    map['reps'] = Variable<int>(reps);
    map['weight'] = Variable<double>(weight);
    {
      map['source'] = Variable<String>(
        $PowerTrainingApproachTableTable.$convertersource.toSql(source),
      );
    }
    return map;
  }

  PowerTrainingApproachTableCompanion toCompanion(bool nullToAbsent) {
    return PowerTrainingApproachTableCompanion(
      id: Value(id),
      powerTrainingId: Value(powerTrainingId),
      exerciseId: Value(exerciseId),
      position: Value(position),
      reps: Value(reps),
      weight: Value(weight),
      source: Value(source),
    );
  }

  factory PowerTrainingApproachTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PowerTrainingApproachTableData(
      id: serializer.fromJson<String>(json['id']),
      powerTrainingId: serializer.fromJson<String>(json['powerTrainingId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      position: serializer.fromJson<int>(json['position']),
      reps: serializer.fromJson<int>(json['reps']),
      weight: serializer.fromJson<double>(json['weight']),
      source: $PowerTrainingApproachTableTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'powerTrainingId': serializer.toJson<String>(powerTrainingId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'position': serializer.toJson<int>(position),
      'reps': serializer.toJson<int>(reps),
      'weight': serializer.toJson<double>(weight),
      'source': serializer.toJson<String>(
        $PowerTrainingApproachTableTable.$convertersource.toJson(source),
      ),
    };
  }

  PowerTrainingApproachTableData copyWith({
    String? id,
    String? powerTrainingId,
    String? exerciseId,
    int? position,
    int? reps,
    double? weight,
    ApproachSource? source,
  }) => PowerTrainingApproachTableData(
    id: id ?? this.id,
    powerTrainingId: powerTrainingId ?? this.powerTrainingId,
    exerciseId: exerciseId ?? this.exerciseId,
    position: position ?? this.position,
    reps: reps ?? this.reps,
    weight: weight ?? this.weight,
    source: source ?? this.source,
  );
  PowerTrainingApproachTableData copyWithCompanion(
    PowerTrainingApproachTableCompanion data,
  ) {
    return PowerTrainingApproachTableData(
      id: data.id.present ? data.id.value : this.id,
      powerTrainingId: data.powerTrainingId.present
          ? data.powerTrainingId.value
          : this.powerTrainingId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      position: data.position.present ? data.position.value : this.position,
      reps: data.reps.present ? data.reps.value : this.reps,
      weight: data.weight.present ? data.weight.value : this.weight,
      source: data.source.present ? data.source.value : this.source,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PowerTrainingApproachTableData(')
          ..write('id: $id, ')
          ..write('powerTrainingId: $powerTrainingId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position, ')
          ..write('reps: $reps, ')
          ..write('weight: $weight, ')
          ..write('source: $source')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    powerTrainingId,
    exerciseId,
    position,
    reps,
    weight,
    source,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PowerTrainingApproachTableData &&
          other.id == this.id &&
          other.powerTrainingId == this.powerTrainingId &&
          other.exerciseId == this.exerciseId &&
          other.position == this.position &&
          other.reps == this.reps &&
          other.weight == this.weight &&
          other.source == this.source);
}

class PowerTrainingApproachTableCompanion
    extends UpdateCompanion<PowerTrainingApproachTableData> {
  final Value<String> id;
  final Value<String> powerTrainingId;
  final Value<String> exerciseId;
  final Value<int> position;
  final Value<int> reps;
  final Value<double> weight;
  final Value<ApproachSource> source;
  final Value<int> rowid;
  const PowerTrainingApproachTableCompanion({
    this.id = const Value.absent(),
    this.powerTrainingId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.position = const Value.absent(),
    this.reps = const Value.absent(),
    this.weight = const Value.absent(),
    this.source = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PowerTrainingApproachTableCompanion.insert({
    required String id,
    required String powerTrainingId,
    required String exerciseId,
    required int position,
    required int reps,
    required double weight,
    required ApproachSource source,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       powerTrainingId = Value(powerTrainingId),
       exerciseId = Value(exerciseId),
       position = Value(position),
       reps = Value(reps),
       weight = Value(weight),
       source = Value(source);
  static Insertable<PowerTrainingApproachTableData> custom({
    Expression<String>? id,
    Expression<String>? powerTrainingId,
    Expression<String>? exerciseId,
    Expression<int>? position,
    Expression<int>? reps,
    Expression<double>? weight,
    Expression<String>? source,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (powerTrainingId != null) 'power_training_id': powerTrainingId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (position != null) 'position': position,
      if (reps != null) 'reps': reps,
      if (weight != null) 'weight': weight,
      if (source != null) 'source': source,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PowerTrainingApproachTableCompanion copyWith({
    Value<String>? id,
    Value<String>? powerTrainingId,
    Value<String>? exerciseId,
    Value<int>? position,
    Value<int>? reps,
    Value<double>? weight,
    Value<ApproachSource>? source,
    Value<int>? rowid,
  }) {
    return PowerTrainingApproachTableCompanion(
      id: id ?? this.id,
      powerTrainingId: powerTrainingId ?? this.powerTrainingId,
      exerciseId: exerciseId ?? this.exerciseId,
      position: position ?? this.position,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      source: source ?? this.source,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (powerTrainingId.present) {
      map['power_training_id'] = Variable<String>(powerTrainingId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $PowerTrainingApproachTableTable.$convertersource.toSql(source.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PowerTrainingApproachTableCompanion(')
          ..write('id: $id, ')
          ..write('powerTrainingId: $powerTrainingId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position, ')
          ..write('reps: $reps, ')
          ..write('weight: $weight, ')
          ..write('source: $source, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoryTableTable categoryTable = $CategoryTableTable(this);
  late final $ExerciseTableTable exerciseTable = $ExerciseTableTable(this);
  late final $ExerciseSetTableTable exerciseSetTable = $ExerciseSetTableTable(
    this,
  );
  late final $ExerciseSetItemTableTable exerciseSetItemTable =
      $ExerciseSetItemTableTable(this);
  late final $PowerTrainingTableTable powerTrainingTable =
      $PowerTrainingTableTable(this);
  late final $PowerTrainingApproachTableTable powerTrainingApproachTable =
      $PowerTrainingApproachTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    categoryTable,
    exerciseTable,
    exerciseSetTable,
    exerciseSetItemTable,
    powerTrainingTable,
    powerTrainingApproachTable,
  ];
}

typedef $$CategoryTableTableCreateCompanionBuilder =
    CategoryTableCompanion Function({
      required String id,
      required String name,
      Value<String?> parentId,
      Value<int> rowid,
    });
typedef $$CategoryTableTableUpdateCompanionBuilder =
    CategoryTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> parentId,
      Value<int> rowid,
    });

final class $$CategoryTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $CategoryTableTable, CategoryTableData> {
  $$CategoryTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoryTableTable _parentIdTable(_$AppDatabase db) => db
      .categoryTable
      .createAlias('category_table__parent_id__category_table__id');

  $$CategoryTableTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<String>('parent_id');
    if ($_column == null) return null;
    final manager = $$CategoryTableTableTableManager(
      $_db,
      $_db.categoryTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ExerciseTableTable, List<ExerciseTableData>>
  _exerciseTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.exerciseTable,
    aliasName: 'category_table__id__exercise_table__category_id',
  );

  $$ExerciseTableTableProcessedTableManager get exerciseTableRefs {
    final manager = $$ExerciseTableTableTableManager(
      $_db,
      $_db.exerciseTable,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_exerciseTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryTableTable> {
  $$CategoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoryTableTableFilterComposer get parentId {
    final $$CategoryTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.categoryTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryTableTableFilterComposer(
            $db: $db,
            $table: $db.categoryTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> exerciseTableRefs(
    Expression<bool> Function($$ExerciseTableTableFilterComposer f) f,
  ) {
    final $$ExerciseTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseTableTableFilterComposer(
            $db: $db,
            $table: $db.exerciseTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryTableTable> {
  $$CategoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoryTableTableOrderingComposer get parentId {
    final $$CategoryTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.categoryTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryTableTableOrderingComposer(
            $db: $db,
            $table: $db.categoryTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CategoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryTableTable> {
  $$CategoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$CategoryTableTableAnnotationComposer get parentId {
    final $$CategoryTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentId,
      referencedTable: $db.categoryTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryTableTableAnnotationComposer(
            $db: $db,
            $table: $db.categoryTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> exerciseTableRefs<T extends Object>(
    Expression<T> Function($$ExerciseTableTableAnnotationComposer a) f,
  ) {
    final $$ExerciseTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseTable,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseTableTableAnnotationComposer(
            $db: $db,
            $table: $db.exerciseTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoryTableTable,
          CategoryTableData,
          $$CategoryTableTableFilterComposer,
          $$CategoryTableTableOrderingComposer,
          $$CategoryTableTableAnnotationComposer,
          $$CategoryTableTableCreateCompanionBuilder,
          $$CategoryTableTableUpdateCompanionBuilder,
          (CategoryTableData, $$CategoryTableTableReferences),
          CategoryTableData,
          PrefetchHooks Function({bool parentId, bool exerciseTableRefs})
        > {
  $$CategoryTableTableTableManager(_$AppDatabase db, $CategoryTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoryTableCompanion(
                id: id,
                name: name,
                parentId: parentId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> parentId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoryTableCompanion.insert(
                id: id,
                name: name,
                parentId: parentId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoryTableTable, CategoryTableData>(table),
                  $$CategoryTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({parentId = false, exerciseTableRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (exerciseTableRefs) db.exerciseTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (parentId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.parentId,
                            referencedTable: $$CategoryTableTableReferences
                                ._parentIdTable(db),
                            referencedColumn: $$CategoryTableTableReferences
                                ._parentIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (exerciseTableRefs)
                        await $_getPrefetchedData<
                          CategoryTableData,
                          $CategoryTableTable,
                          ExerciseTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CategoryTableTableReferences
                              ._exerciseTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CategoryTableTableReferences(
                                db,
                                table,
                                p0,
                              ).exerciseTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.categoryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CategoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoryTableTable,
      CategoryTableData,
      $$CategoryTableTableFilterComposer,
      $$CategoryTableTableOrderingComposer,
      $$CategoryTableTableAnnotationComposer,
      $$CategoryTableTableCreateCompanionBuilder,
      $$CategoryTableTableUpdateCompanionBuilder,
      (CategoryTableData, $$CategoryTableTableReferences),
      CategoryTableData,
      PrefetchHooks Function({bool parentId, bool exerciseTableRefs})
    >;
typedef $$ExerciseTableTableCreateCompanionBuilder =
    ExerciseTableCompanion Function({
      required String id,
      required String name,
      required String categoryId,
      Value<int> rowid,
    });
typedef $$ExerciseTableTableUpdateCompanionBuilder =
    ExerciseTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> categoryId,
      Value<int> rowid,
    });

final class $$ExerciseTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $ExerciseTableTable, ExerciseTableData> {
  $$ExerciseTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CategoryTableTable _categoryIdTable(_$AppDatabase db) => db
      .categoryTable
      .createAlias('exercise_table__category_id__category_table__id');

  $$CategoryTableTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<String>('category_id')!;

    final manager = $$CategoryTableTableTableManager(
      $_db,
      $_db.categoryTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $ExerciseSetItemTableTable,
    List<ExerciseSetItemTableData>
  >
  _exerciseSetItemTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.exerciseSetItemTable,
        aliasName: 'exercise_table__id__exercise_set_item_table__exercise_id',
      );

  $$ExerciseSetItemTableTableProcessedTableManager
  get exerciseSetItemTableRefs {
    final manager = $$ExerciseSetItemTableTableTableManager(
      $_db,
      $_db.exerciseSetItemTable,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _exerciseSetItemTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PowerTrainingApproachTableTable,
    List<PowerTrainingApproachTableData>
  >
  _powerTrainingApproachTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.powerTrainingApproachTable,
        aliasName:
            'exercise_table__id__power_training_approach_table__exercise_id',
      );

  $$PowerTrainingApproachTableTableProcessedTableManager
  get powerTrainingApproachTableRefs {
    final manager = $$PowerTrainingApproachTableTableTableManager(
      $_db,
      $_db.powerTrainingApproachTable,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _powerTrainingApproachTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExerciseTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseTableTable> {
  $$ExerciseTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoryTableTableFilterComposer get categoryId {
    final $$CategoryTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoryTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryTableTableFilterComposer(
            $db: $db,
            $table: $db.categoryTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> exerciseSetItemTableRefs(
    Expression<bool> Function($$ExerciseSetItemTableTableFilterComposer f) f,
  ) {
    final $$ExerciseSetItemTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseSetItemTable,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseSetItemTableTableFilterComposer(
            $db: $db,
            $table: $db.exerciseSetItemTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> powerTrainingApproachTableRefs(
    Expression<bool> Function($$PowerTrainingApproachTableTableFilterComposer f)
    f,
  ) {
    final $$PowerTrainingApproachTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.powerTrainingApproachTable,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PowerTrainingApproachTableTableFilterComposer(
                $db: $db,
                $table: $db.powerTrainingApproachTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ExerciseTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseTableTable> {
  $$ExerciseTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoryTableTableOrderingComposer get categoryId {
    final $$CategoryTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoryTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryTableTableOrderingComposer(
            $db: $db,
            $table: $db.categoryTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseTableTable> {
  $$ExerciseTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  $$CategoryTableTableAnnotationComposer get categoryId {
    final $$CategoryTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.categoryTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryTableTableAnnotationComposer(
            $db: $db,
            $table: $db.categoryTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> exerciseSetItemTableRefs<T extends Object>(
    Expression<T> Function($$ExerciseSetItemTableTableAnnotationComposer a) f,
  ) {
    final $$ExerciseSetItemTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.exerciseSetItemTable,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExerciseSetItemTableTableAnnotationComposer(
                $db: $db,
                $table: $db.exerciseSetItemTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> powerTrainingApproachTableRefs<T extends Object>(
    Expression<T> Function(
      $$PowerTrainingApproachTableTableAnnotationComposer a,
    )
    f,
  ) {
    final $$PowerTrainingApproachTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.powerTrainingApproachTable,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PowerTrainingApproachTableTableAnnotationComposer(
                $db: $db,
                $table: $db.powerTrainingApproachTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ExerciseTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseTableTable,
          ExerciseTableData,
          $$ExerciseTableTableFilterComposer,
          $$ExerciseTableTableOrderingComposer,
          $$ExerciseTableTableAnnotationComposer,
          $$ExerciseTableTableCreateCompanionBuilder,
          $$ExerciseTableTableUpdateCompanionBuilder,
          (ExerciseTableData, $$ExerciseTableTableReferences),
          ExerciseTableData,
          PrefetchHooks Function({
            bool categoryId,
            bool exerciseSetItemTableRefs,
            bool powerTrainingApproachTableRefs,
          })
        > {
  $$ExerciseTableTableTableManager(_$AppDatabase db, $ExerciseTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseTableCompanion(
                id: id,
                name: name,
                categoryId: categoryId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String categoryId,
                Value<int> rowid = const Value.absent(),
              }) => ExerciseTableCompanion.insert(
                id: id,
                name: name,
                categoryId: categoryId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExerciseTableTable, ExerciseTableData>(table),
                  $$ExerciseTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                categoryId = false,
                exerciseSetItemTableRefs = false,
                powerTrainingApproachTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (exerciseSetItemTableRefs) db.exerciseSetItemTable,
                    if (powerTrainingApproachTableRefs)
                      db.powerTrainingApproachTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoryId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoryId,
                            referencedTable: $$ExerciseTableTableReferences
                                ._categoryIdTable(db),
                            referencedColumn: $$ExerciseTableTableReferences
                                ._categoryIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (exerciseSetItemTableRefs)
                        await $_getPrefetchedData<
                          ExerciseTableData,
                          $ExerciseTableTable,
                          ExerciseSetItemTableData
                        >(
                          currentTable: table,
                          referencedTable: $$ExerciseTableTableReferences
                              ._exerciseSetItemTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExerciseTableTableReferences(
                                db,
                                table,
                                p0,
                              ).exerciseSetItemTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (powerTrainingApproachTableRefs)
                        await $_getPrefetchedData<
                          ExerciseTableData,
                          $ExerciseTableTable,
                          PowerTrainingApproachTableData
                        >(
                          currentTable: table,
                          referencedTable: $$ExerciseTableTableReferences
                              ._powerTrainingApproachTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExerciseTableTableReferences(
                                db,
                                table,
                                p0,
                              ).powerTrainingApproachTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ExerciseTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseTableTable,
      ExerciseTableData,
      $$ExerciseTableTableFilterComposer,
      $$ExerciseTableTableOrderingComposer,
      $$ExerciseTableTableAnnotationComposer,
      $$ExerciseTableTableCreateCompanionBuilder,
      $$ExerciseTableTableUpdateCompanionBuilder,
      (ExerciseTableData, $$ExerciseTableTableReferences),
      ExerciseTableData,
      PrefetchHooks Function({
        bool categoryId,
        bool exerciseSetItemTableRefs,
        bool powerTrainingApproachTableRefs,
      })
    >;
typedef $$ExerciseSetTableTableCreateCompanionBuilder =
    ExerciseSetTableCompanion Function({
      required String id,
      required String name,
      Value<String?> description,
      required bool isCurrent,
      Value<int> rowid,
    });
typedef $$ExerciseSetTableTableUpdateCompanionBuilder =
    ExerciseSetTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> description,
      Value<bool> isCurrent,
      Value<int> rowid,
    });

final class $$ExerciseSetTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExerciseSetTableTable,
          ExerciseSetTableData
        > {
  $$ExerciseSetTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $ExerciseSetItemTableTable,
    List<ExerciseSetItemTableData>
  >
  _exerciseSetItemTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.exerciseSetItemTable,
        aliasName:
            'exercise_set_table__id__exercise_set_item_table__exercise_set_id',
      );

  $$ExerciseSetItemTableTableProcessedTableManager
  get exerciseSetItemTableRefs {
    final manager = $$ExerciseSetItemTableTableTableManager(
      $_db,
      $_db.exerciseSetItemTable,
    ).filter((f) => f.exerciseSetId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _exerciseSetItemTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $PowerTrainingTableTable,
    List<PowerTrainingTableData>
  >
  _powerTrainingTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.powerTrainingTable,
        aliasName:
            'exercise_set_table__id__power_training_table__exercise_set_id',
      );

  $$PowerTrainingTableTableProcessedTableManager get powerTrainingTableRefs {
    final manager = $$PowerTrainingTableTableTableManager(
      $_db,
      $_db.powerTrainingTable,
    ).filter((f) => f.exerciseSetId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _powerTrainingTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExerciseSetTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseSetTableTable> {
  $$ExerciseSetTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCurrent => $composableBuilder(
    column: $table.isCurrent,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> exerciseSetItemTableRefs(
    Expression<bool> Function($$ExerciseSetItemTableTableFilterComposer f) f,
  ) {
    final $$ExerciseSetItemTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseSetItemTable,
      getReferencedColumn: (t) => t.exerciseSetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseSetItemTableTableFilterComposer(
            $db: $db,
            $table: $db.exerciseSetItemTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> powerTrainingTableRefs(
    Expression<bool> Function($$PowerTrainingTableTableFilterComposer f) f,
  ) {
    final $$PowerTrainingTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.powerTrainingTable,
      getReferencedColumn: (t) => t.exerciseSetId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PowerTrainingTableTableFilterComposer(
            $db: $db,
            $table: $db.powerTrainingTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExerciseSetTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseSetTableTable> {
  $$ExerciseSetTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCurrent => $composableBuilder(
    column: $table.isCurrent,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseSetTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseSetTableTable> {
  $$ExerciseSetTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCurrent =>
      $composableBuilder(column: $table.isCurrent, builder: (column) => column);

  Expression<T> exerciseSetItemTableRefs<T extends Object>(
    Expression<T> Function($$ExerciseSetItemTableTableAnnotationComposer a) f,
  ) {
    final $$ExerciseSetItemTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.exerciseSetItemTable,
          getReferencedColumn: (t) => t.exerciseSetId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExerciseSetItemTableTableAnnotationComposer(
                $db: $db,
                $table: $db.exerciseSetItemTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> powerTrainingTableRefs<T extends Object>(
    Expression<T> Function($$PowerTrainingTableTableAnnotationComposer a) f,
  ) {
    final $$PowerTrainingTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.powerTrainingTable,
          getReferencedColumn: (t) => t.exerciseSetId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PowerTrainingTableTableAnnotationComposer(
                $db: $db,
                $table: $db.powerTrainingTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ExerciseSetTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseSetTableTable,
          ExerciseSetTableData,
          $$ExerciseSetTableTableFilterComposer,
          $$ExerciseSetTableTableOrderingComposer,
          $$ExerciseSetTableTableAnnotationComposer,
          $$ExerciseSetTableTableCreateCompanionBuilder,
          $$ExerciseSetTableTableUpdateCompanionBuilder,
          (ExerciseSetTableData, $$ExerciseSetTableTableReferences),
          ExerciseSetTableData,
          PrefetchHooks Function({
            bool exerciseSetItemTableRefs,
            bool powerTrainingTableRefs,
          })
        > {
  $$ExerciseSetTableTableTableManager(
    _$AppDatabase db,
    $ExerciseSetTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseSetTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseSetTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseSetTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isCurrent = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseSetTableCompanion(
                id: id,
                name: name,
                description: description,
                isCurrent: isCurrent,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> description = const Value.absent(),
                required bool isCurrent,
                Value<int> rowid = const Value.absent(),
              }) => ExerciseSetTableCompanion.insert(
                id: id,
                name: name,
                description: description,
                isCurrent: isCurrent,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExerciseSetTableTable, ExerciseSetTableData>(
                    table,
                  ),
                  $$ExerciseSetTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                exerciseSetItemTableRefs = false,
                powerTrainingTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (exerciseSetItemTableRefs) db.exerciseSetItemTable,
                    if (powerTrainingTableRefs) db.powerTrainingTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (exerciseSetItemTableRefs)
                        await $_getPrefetchedData<
                          ExerciseSetTableData,
                          $ExerciseSetTableTable,
                          ExerciseSetItemTableData
                        >(
                          currentTable: table,
                          referencedTable: $$ExerciseSetTableTableReferences
                              ._exerciseSetItemTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExerciseSetTableTableReferences(
                                db,
                                table,
                                p0,
                              ).exerciseSetItemTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseSetId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (powerTrainingTableRefs)
                        await $_getPrefetchedData<
                          ExerciseSetTableData,
                          $ExerciseSetTableTable,
                          PowerTrainingTableData
                        >(
                          currentTable: table,
                          referencedTable: $$ExerciseSetTableTableReferences
                              ._powerTrainingTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExerciseSetTableTableReferences(
                                db,
                                table,
                                p0,
                              ).powerTrainingTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseSetId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ExerciseSetTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseSetTableTable,
      ExerciseSetTableData,
      $$ExerciseSetTableTableFilterComposer,
      $$ExerciseSetTableTableOrderingComposer,
      $$ExerciseSetTableTableAnnotationComposer,
      $$ExerciseSetTableTableCreateCompanionBuilder,
      $$ExerciseSetTableTableUpdateCompanionBuilder,
      (ExerciseSetTableData, $$ExerciseSetTableTableReferences),
      ExerciseSetTableData,
      PrefetchHooks Function({
        bool exerciseSetItemTableRefs,
        bool powerTrainingTableRefs,
      })
    >;
typedef $$ExerciseSetItemTableTableCreateCompanionBuilder =
    ExerciseSetItemTableCompanion Function({
      required String id,
      required String exerciseSetId,
      required String exerciseId,
      required int position,
      required bool isDeleted,
      Value<int> rowid,
    });
typedef $$ExerciseSetItemTableTableUpdateCompanionBuilder =
    ExerciseSetItemTableCompanion Function({
      Value<String> id,
      Value<String> exerciseSetId,
      Value<String> exerciseId,
      Value<int> position,
      Value<bool> isDeleted,
      Value<int> rowid,
    });

final class $$ExerciseSetItemTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExerciseSetItemTableTable,
          ExerciseSetItemTableData
        > {
  $$ExerciseSetItemTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExerciseSetTableTable _exerciseSetIdTable(_$AppDatabase db) =>
      db.exerciseSetTable.createAlias(
        'exercise_set_item_table__exercise_set_id__exercise_set_table__id',
      );

  $$ExerciseSetTableTableProcessedTableManager get exerciseSetId {
    final $_column = $_itemColumn<String>('exercise_set_id')!;

    final manager = $$ExerciseSetTableTableTableManager(
      $_db,
      $_db.exerciseSetTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseSetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExerciseTableTable _exerciseIdTable(_$AppDatabase db) => db
      .exerciseTable
      .createAlias('exercise_set_item_table__exercise_id__exercise_table__id');

  $$ExerciseTableTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<String>('exercise_id')!;

    final manager = $$ExerciseTableTableTableManager(
      $_db,
      $_db.exerciseTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExerciseSetItemTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseSetItemTableTable> {
  $$ExerciseSetItemTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnFilters(column),
  );

  $$ExerciseSetTableTableFilterComposer get exerciseSetId {
    final $$ExerciseSetTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseSetId,
      referencedTable: $db.exerciseSetTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseSetTableTableFilterComposer(
            $db: $db,
            $table: $db.exerciseSetTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExerciseTableTableFilterComposer get exerciseId {
    final $$ExerciseTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exerciseTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseTableTableFilterComposer(
            $db: $db,
            $table: $db.exerciseTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseSetItemTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseSetItemTableTable> {
  $$ExerciseSetItemTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
    column: $table.isDeleted,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExerciseSetTableTableOrderingComposer get exerciseSetId {
    final $$ExerciseSetTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseSetId,
      referencedTable: $db.exerciseSetTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseSetTableTableOrderingComposer(
            $db: $db,
            $table: $db.exerciseSetTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExerciseTableTableOrderingComposer get exerciseId {
    final $$ExerciseTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exerciseTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseTableTableOrderingComposer(
            $db: $db,
            $table: $db.exerciseTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseSetItemTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseSetItemTableTable> {
  $$ExerciseSetItemTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  $$ExerciseSetTableTableAnnotationComposer get exerciseSetId {
    final $$ExerciseSetTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseSetId,
      referencedTable: $db.exerciseSetTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseSetTableTableAnnotationComposer(
            $db: $db,
            $table: $db.exerciseSetTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExerciseTableTableAnnotationComposer get exerciseId {
    final $$ExerciseTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exerciseTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseTableTableAnnotationComposer(
            $db: $db,
            $table: $db.exerciseTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseSetItemTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseSetItemTableTable,
          ExerciseSetItemTableData,
          $$ExerciseSetItemTableTableFilterComposer,
          $$ExerciseSetItemTableTableOrderingComposer,
          $$ExerciseSetItemTableTableAnnotationComposer,
          $$ExerciseSetItemTableTableCreateCompanionBuilder,
          $$ExerciseSetItemTableTableUpdateCompanionBuilder,
          (ExerciseSetItemTableData, $$ExerciseSetItemTableTableReferences),
          ExerciseSetItemTableData,
          PrefetchHooks Function({bool exerciseSetId, bool exerciseId})
        > {
  $$ExerciseSetItemTableTableTableManager(
    _$AppDatabase db,
    $ExerciseSetItemTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseSetItemTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseSetItemTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ExerciseSetItemTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> exerciseSetId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<bool> isDeleted = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseSetItemTableCompanion(
                id: id,
                exerciseSetId: exerciseSetId,
                exerciseId: exerciseId,
                position: position,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String exerciseSetId,
                required String exerciseId,
                required int position,
                required bool isDeleted,
                Value<int> rowid = const Value.absent(),
              }) => ExerciseSetItemTableCompanion.insert(
                id: id,
                exerciseSetId: exerciseSetId,
                exerciseId: exerciseId,
                position: position,
                isDeleted: isDeleted,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $ExerciseSetItemTableTable,
                    ExerciseSetItemTableData
                  >(table),
                  $$ExerciseSetItemTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseSetId = false, exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (exerciseSetId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.exerciseSetId,
                        referencedTable: $$ExerciseSetItemTableTableReferences
                            ._exerciseSetIdTable(db),
                        referencedColumn: $$ExerciseSetItemTableTableReferences
                            ._exerciseSetIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (exerciseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.exerciseId,
                        referencedTable: $$ExerciseSetItemTableTableReferences
                            ._exerciseIdTable(db),
                        referencedColumn: $$ExerciseSetItemTableTableReferences
                            ._exerciseIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExerciseSetItemTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseSetItemTableTable,
      ExerciseSetItemTableData,
      $$ExerciseSetItemTableTableFilterComposer,
      $$ExerciseSetItemTableTableOrderingComposer,
      $$ExerciseSetItemTableTableAnnotationComposer,
      $$ExerciseSetItemTableTableCreateCompanionBuilder,
      $$ExerciseSetItemTableTableUpdateCompanionBuilder,
      (ExerciseSetItemTableData, $$ExerciseSetItemTableTableReferences),
      ExerciseSetItemTableData,
      PrefetchHooks Function({bool exerciseSetId, bool exerciseId})
    >;
typedef $$PowerTrainingTableTableCreateCompanionBuilder =
    PowerTrainingTableCompanion Function({
      required String id,
      required String name,
      required String description,
      Value<DateTime?> date,
      Value<String?> exerciseSetId,
      Value<int> rowid,
    });
typedef $$PowerTrainingTableTableUpdateCompanionBuilder =
    PowerTrainingTableCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> description,
      Value<DateTime?> date,
      Value<String?> exerciseSetId,
      Value<int> rowid,
    });

final class $$PowerTrainingTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PowerTrainingTableTable,
          PowerTrainingTableData
        > {
  $$PowerTrainingTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExerciseSetTableTable _exerciseSetIdTable(_$AppDatabase db) =>
      db.exerciseSetTable.createAlias(
        'power_training_table__exercise_set_id__exercise_set_table__id',
      );

  $$ExerciseSetTableTableProcessedTableManager? get exerciseSetId {
    final $_column = $_itemColumn<String>('exercise_set_id');
    if ($_column == null) return null;
    final manager = $$ExerciseSetTableTableTableManager(
      $_db,
      $_db.exerciseSetTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseSetIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $PowerTrainingApproachTableTable,
    List<PowerTrainingApproachTableData>
  >
  _powerTrainingApproachTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.powerTrainingApproachTable,
        aliasName: 'power_training_table__id__power_training_approach_table__power_training_id',
      );

  $$PowerTrainingApproachTableTableProcessedTableManager
  get powerTrainingApproachTableRefs {
    final manager =
        $$PowerTrainingApproachTableTableTableManager(
          $_db,
          $_db.powerTrainingApproachTable,
        ).filter(
          (f) => f.powerTrainingId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _powerTrainingApproachTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PowerTrainingTableTableFilterComposer
    extends Composer<_$AppDatabase, $PowerTrainingTableTable> {
  $$PowerTrainingTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  $$ExerciseSetTableTableFilterComposer get exerciseSetId {
    final $$ExerciseSetTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseSetId,
      referencedTable: $db.exerciseSetTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseSetTableTableFilterComposer(
            $db: $db,
            $table: $db.exerciseSetTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> powerTrainingApproachTableRefs(
    Expression<bool> Function($$PowerTrainingApproachTableTableFilterComposer f)
    f,
  ) {
    final $$PowerTrainingApproachTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.powerTrainingApproachTable,
          getReferencedColumn: (t) => t.powerTrainingId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PowerTrainingApproachTableTableFilterComposer(
                $db: $db,
                $table: $db.powerTrainingApproachTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PowerTrainingTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PowerTrainingTableTable> {
  $$PowerTrainingTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExerciseSetTableTableOrderingComposer get exerciseSetId {
    final $$ExerciseSetTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseSetId,
      referencedTable: $db.exerciseSetTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseSetTableTableOrderingComposer(
            $db: $db,
            $table: $db.exerciseSetTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PowerTrainingTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PowerTrainingTableTable> {
  $$PowerTrainingTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$ExerciseSetTableTableAnnotationComposer get exerciseSetId {
    final $$ExerciseSetTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseSetId,
      referencedTable: $db.exerciseSetTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseSetTableTableAnnotationComposer(
            $db: $db,
            $table: $db.exerciseSetTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> powerTrainingApproachTableRefs<T extends Object>(
    Expression<T> Function(
      $$PowerTrainingApproachTableTableAnnotationComposer a,
    )
    f,
  ) {
    final $$PowerTrainingApproachTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.powerTrainingApproachTable,
          getReferencedColumn: (t) => t.powerTrainingId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PowerTrainingApproachTableTableAnnotationComposer(
                $db: $db,
                $table: $db.powerTrainingApproachTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PowerTrainingTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PowerTrainingTableTable,
          PowerTrainingTableData,
          $$PowerTrainingTableTableFilterComposer,
          $$PowerTrainingTableTableOrderingComposer,
          $$PowerTrainingTableTableAnnotationComposer,
          $$PowerTrainingTableTableCreateCompanionBuilder,
          $$PowerTrainingTableTableUpdateCompanionBuilder,
          (PowerTrainingTableData, $$PowerTrainingTableTableReferences),
          PowerTrainingTableData,
          PrefetchHooks Function({
            bool exerciseSetId,
            bool powerTrainingApproachTableRefs,
          })
        > {
  $$PowerTrainingTableTableTableManager(
    _$AppDatabase db,
    $PowerTrainingTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PowerTrainingTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PowerTrainingTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PowerTrainingTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime?> date = const Value.absent(),
                Value<String?> exerciseSetId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PowerTrainingTableCompanion(
                id: id,
                name: name,
                description: description,
                date: date,
                exerciseSetId: exerciseSetId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String description,
                Value<DateTime?> date = const Value.absent(),
                Value<String?> exerciseSetId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PowerTrainingTableCompanion.insert(
                id: id,
                name: name,
                description: description,
                date: date,
                exerciseSetId: exerciseSetId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PowerTrainingTableTable, PowerTrainingTableData>(
                    table,
                  ),
                  $$PowerTrainingTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                exerciseSetId = false,
                powerTrainingApproachTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (powerTrainingApproachTableRefs)
                      db.powerTrainingApproachTable,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (exerciseSetId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.exerciseSetId,
                            referencedTable: $$PowerTrainingTableTableReferences
                                ._exerciseSetIdTable(db),
                            referencedColumn:
                                $$PowerTrainingTableTableReferences
                                    ._exerciseSetIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (powerTrainingApproachTableRefs)
                        await $_getPrefetchedData<
                          PowerTrainingTableData,
                          $PowerTrainingTableTable,
                          PowerTrainingApproachTableData
                        >(
                          currentTable: table,
                          referencedTable: $$PowerTrainingTableTableReferences
                              ._powerTrainingApproachTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PowerTrainingTableTableReferences(
                                db,
                                table,
                                p0,
                              ).powerTrainingApproachTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.powerTrainingId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PowerTrainingTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PowerTrainingTableTable,
      PowerTrainingTableData,
      $$PowerTrainingTableTableFilterComposer,
      $$PowerTrainingTableTableOrderingComposer,
      $$PowerTrainingTableTableAnnotationComposer,
      $$PowerTrainingTableTableCreateCompanionBuilder,
      $$PowerTrainingTableTableUpdateCompanionBuilder,
      (PowerTrainingTableData, $$PowerTrainingTableTableReferences),
      PowerTrainingTableData,
      PrefetchHooks Function({
        bool exerciseSetId,
        bool powerTrainingApproachTableRefs,
      })
    >;
typedef $$PowerTrainingApproachTableTableCreateCompanionBuilder =
    PowerTrainingApproachTableCompanion Function({
      required String id,
      required String powerTrainingId,
      required String exerciseId,
      required int position,
      required int reps,
      required double weight,
      required ApproachSource source,
      Value<int> rowid,
    });
typedef $$PowerTrainingApproachTableTableUpdateCompanionBuilder =
    PowerTrainingApproachTableCompanion Function({
      Value<String> id,
      Value<String> powerTrainingId,
      Value<String> exerciseId,
      Value<int> position,
      Value<int> reps,
      Value<double> weight,
      Value<ApproachSource> source,
      Value<int> rowid,
    });

final class $$PowerTrainingApproachTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PowerTrainingApproachTableTable,
          PowerTrainingApproachTableData
        > {
  $$PowerTrainingApproachTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PowerTrainingTableTable _powerTrainingIdTable(_$AppDatabase db) =>
      db.powerTrainingTable.createAlias(
        'power_training_approach_table__power_training_id__power_training_table__id',
      );

  $$PowerTrainingTableTableProcessedTableManager get powerTrainingId {
    final $_column = $_itemColumn<String>('power_training_id')!;

    final manager = $$PowerTrainingTableTableTableManager(
      $_db,
      $_db.powerTrainingTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_powerTrainingIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ExerciseTableTable _exerciseIdTable(_$AppDatabase db) =>
      db.exerciseTable.createAlias(
        'power_training_approach_table__exercise_id__exercise_table__id',
      );

  $$ExerciseTableTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<String>('exercise_id')!;

    final manager = $$ExerciseTableTableTableManager(
      $_db,
      $_db.exerciseTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PowerTrainingApproachTableTableFilterComposer
    extends Composer<_$AppDatabase, $PowerTrainingApproachTableTable> {
  $$PowerTrainingApproachTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ApproachSource, ApproachSource, String>
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$PowerTrainingTableTableFilterComposer get powerTrainingId {
    final $$PowerTrainingTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.powerTrainingId,
      referencedTable: $db.powerTrainingTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PowerTrainingTableTableFilterComposer(
            $db: $db,
            $table: $db.powerTrainingTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExerciseTableTableFilterComposer get exerciseId {
    final $$ExerciseTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exerciseTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseTableTableFilterComposer(
            $db: $db,
            $table: $db.exerciseTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PowerTrainingApproachTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PowerTrainingApproachTableTable> {
  $$PowerTrainingApproachTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  $$PowerTrainingTableTableOrderingComposer get powerTrainingId {
    final $$PowerTrainingTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.powerTrainingId,
      referencedTable: $db.powerTrainingTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PowerTrainingTableTableOrderingComposer(
            $db: $db,
            $table: $db.powerTrainingTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ExerciseTableTableOrderingComposer get exerciseId {
    final $$ExerciseTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exerciseTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseTableTableOrderingComposer(
            $db: $db,
            $table: $db.exerciseTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PowerTrainingApproachTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PowerTrainingApproachTableTable> {
  $$PowerTrainingApproachTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ApproachSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  $$PowerTrainingTableTableAnnotationComposer get powerTrainingId {
    final $$PowerTrainingTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.powerTrainingId,
          referencedTable: $db.powerTrainingTable,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PowerTrainingTableTableAnnotationComposer(
                $db: $db,
                $table: $db.powerTrainingTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$ExerciseTableTableAnnotationComposer get exerciseId {
    final $$ExerciseTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exerciseTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseTableTableAnnotationComposer(
            $db: $db,
            $table: $db.exerciseTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PowerTrainingApproachTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PowerTrainingApproachTableTable,
          PowerTrainingApproachTableData,
          $$PowerTrainingApproachTableTableFilterComposer,
          $$PowerTrainingApproachTableTableOrderingComposer,
          $$PowerTrainingApproachTableTableAnnotationComposer,
          $$PowerTrainingApproachTableTableCreateCompanionBuilder,
          $$PowerTrainingApproachTableTableUpdateCompanionBuilder,
          (
            PowerTrainingApproachTableData,
            $$PowerTrainingApproachTableTableReferences,
          ),
          PowerTrainingApproachTableData,
          PrefetchHooks Function({bool powerTrainingId, bool exerciseId})
        > {
  $$PowerTrainingApproachTableTableTableManager(
    _$AppDatabase db,
    $PowerTrainingApproachTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PowerTrainingApproachTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PowerTrainingApproachTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PowerTrainingApproachTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> powerTrainingId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<ApproachSource> source = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PowerTrainingApproachTableCompanion(
                id: id,
                powerTrainingId: powerTrainingId,
                exerciseId: exerciseId,
                position: position,
                reps: reps,
                weight: weight,
                source: source,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String powerTrainingId,
                required String exerciseId,
                required int position,
                required int reps,
                required double weight,
                required ApproachSource source,
                Value<int> rowid = const Value.absent(),
              }) => PowerTrainingApproachTableCompanion.insert(
                id: id,
                powerTrainingId: powerTrainingId,
                exerciseId: exerciseId,
                position: position,
                reps: reps,
                weight: weight,
                source: source,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $PowerTrainingApproachTableTable,
                    PowerTrainingApproachTableData
                  >(table),
                  $$PowerTrainingApproachTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({powerTrainingId = false, exerciseId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (powerTrainingId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.powerTrainingId,
                            referencedTable:
                                $$PowerTrainingApproachTableTableReferences
                                    ._powerTrainingIdTable(db),
                            referencedColumn:
                                $$PowerTrainingApproachTableTableReferences
                                    ._powerTrainingIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (exerciseId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.exerciseId,
                            referencedTable:
                                $$PowerTrainingApproachTableTableReferences
                                    ._exerciseIdTable(db),
                            referencedColumn:
                                $$PowerTrainingApproachTableTableReferences
                                    ._exerciseIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$PowerTrainingApproachTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PowerTrainingApproachTableTable,
      PowerTrainingApproachTableData,
      $$PowerTrainingApproachTableTableFilterComposer,
      $$PowerTrainingApproachTableTableOrderingComposer,
      $$PowerTrainingApproachTableTableAnnotationComposer,
      $$PowerTrainingApproachTableTableCreateCompanionBuilder,
      $$PowerTrainingApproachTableTableUpdateCompanionBuilder,
      (
        PowerTrainingApproachTableData,
        $$PowerTrainingApproachTableTableReferences,
      ),
      PowerTrainingApproachTableData,
      PrefetchHooks Function({bool powerTrainingId, bool exerciseId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoryTableTableTableManager get categoryTable =>
      $$CategoryTableTableTableManager(_db, _db.categoryTable);
  $$ExerciseTableTableTableManager get exerciseTable =>
      $$ExerciseTableTableTableManager(_db, _db.exerciseTable);
  $$ExerciseSetTableTableTableManager get exerciseSetTable =>
      $$ExerciseSetTableTableTableManager(_db, _db.exerciseSetTable);
  $$ExerciseSetItemTableTableTableManager get exerciseSetItemTable =>
      $$ExerciseSetItemTableTableTableManager(_db, _db.exerciseSetItemTable);
  $$PowerTrainingTableTableTableManager get powerTrainingTable =>
      $$PowerTrainingTableTableTableManager(_db, _db.powerTrainingTable);
  $$PowerTrainingApproachTableTableTableManager
  get powerTrainingApproachTable =>
      $$PowerTrainingApproachTableTableTableManager(
        _db,
        _db.powerTrainingApproachTable,
      );
}
