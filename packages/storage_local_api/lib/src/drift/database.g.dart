// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
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
  @override
  late final GeneratedColumnWithTypeConverter<PowerTraining, String> data =
      GeneratedColumn<String>(
        'data',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PowerTraining>($PowerTrainingTableTable.$converterdata);
  static const VerificationMeta _setIdMeta = const VerificationMeta('setId');
  @override
  late final GeneratedColumn<String> setId = GeneratedColumn<String>(
    'set_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, data, setId];
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
    if (data.containsKey('set_id')) {
      context.handle(
        _setIdMeta,
        setId.isAcceptableOrUnknown(data['set_id']!, _setIdMeta),
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
      data: $PowerTrainingTableTable.$converterdata.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}data'],
        )!,
      ),
      setId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}set_id'],
      ),
    );
  }

  @override
  $PowerTrainingTableTable createAlias(String alias) {
    return $PowerTrainingTableTable(attachedDatabase, alias);
  }

  static TypeConverter<PowerTraining, String> $converterdata = converter;
}

class PowerTrainingTableData extends DataClass
    implements Insertable<PowerTrainingTableData> {
  final String id;
  final PowerTraining data;

  /// Ссылка на выбранный набор упражнений; null — набор не выбран.
  final String? setId;
  const PowerTrainingTableData({
    required this.id,
    required this.data,
    this.setId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['data'] = Variable<String>(
        $PowerTrainingTableTable.$converterdata.toSql(data),
      );
    }
    if (!nullToAbsent || setId != null) {
      map['set_id'] = Variable<String>(setId);
    }
    return map;
  }

  PowerTrainingTableCompanion toCompanion(bool nullToAbsent) {
    return PowerTrainingTableCompanion(
      id: Value(id),
      data: Value(data),
      setId: setId == null && nullToAbsent
          ? const Value.absent()
          : Value(setId),
    );
  }

  factory PowerTrainingTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PowerTrainingTableData(
      id: serializer.fromJson<String>(json['id']),
      data: serializer.fromJson<PowerTraining>(json['data']),
      setId: serializer.fromJson<String?>(json['setId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'data': serializer.toJson<PowerTraining>(data),
      'setId': serializer.toJson<String?>(setId),
    };
  }

  PowerTrainingTableData copyWith({
    String? id,
    PowerTraining? data,
    Value<String?> setId = const Value.absent(),
  }) => PowerTrainingTableData(
    id: id ?? this.id,
    data: data ?? this.data,
    setId: setId.present ? setId.value : this.setId,
  );
  PowerTrainingTableData copyWithCompanion(PowerTrainingTableCompanion data) {
    return PowerTrainingTableData(
      id: data.id.present ? data.id.value : this.id,
      data: data.data.present ? data.data.value : this.data,
      setId: data.setId.present ? data.setId.value : this.setId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PowerTrainingTableData(')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('setId: $setId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, data, setId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PowerTrainingTableData &&
          other.id == this.id &&
          other.data == this.data &&
          other.setId == this.setId);
}

class PowerTrainingTableCompanion
    extends UpdateCompanion<PowerTrainingTableData> {
  final Value<String> id;
  final Value<PowerTraining> data;
  final Value<String?> setId;
  final Value<int> rowid;
  const PowerTrainingTableCompanion({
    this.id = const Value.absent(),
    this.data = const Value.absent(),
    this.setId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PowerTrainingTableCompanion.insert({
    required String id,
    required PowerTraining data,
    this.setId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       data = Value(data);
  static Insertable<PowerTrainingTableData> custom({
    Expression<String>? id,
    Expression<String>? data,
    Expression<String>? setId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (data != null) 'data': data,
      if (setId != null) 'set_id': setId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PowerTrainingTableCompanion copyWith({
    Value<String>? id,
    Value<PowerTraining>? data,
    Value<String?>? setId,
    Value<int>? rowid,
  }) {
    return PowerTrainingTableCompanion(
      id: id ?? this.id,
      data: data ?? this.data,
      setId: setId ?? this.setId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(
        $PowerTrainingTableTable.$converterdata.toSql(data.value),
      );
    }
    if (setId.present) {
      map['set_id'] = Variable<String>(setId.value);
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
          ..write('data: $data, ')
          ..write('setId: $setId, ')
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
  @override
  late final GeneratedColumnWithTypeConverter<Exercise, String> data =
      GeneratedColumn<String>(
        'data',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Exercise>($ExerciseTableTable.$converterdata);
  @override
  List<GeneratedColumn> get $columns => [id, data];
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
      data: $ExerciseTableTable.$converterdata.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}data'],
        )!,
      ),
    );
  }

  @override
  $ExerciseTableTable createAlias(String alias) {
    return $ExerciseTableTable(attachedDatabase, alias);
  }

  static TypeConverter<Exercise, String> $converterdata = exerciseConverter;
}

class ExerciseTableData extends DataClass
    implements Insertable<ExerciseTableData> {
  final String id;
  final Exercise data;
  const ExerciseTableData({required this.id, required this.data});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['data'] = Variable<String>(
        $ExerciseTableTable.$converterdata.toSql(data),
      );
    }
    return map;
  }

  ExerciseTableCompanion toCompanion(bool nullToAbsent) {
    return ExerciseTableCompanion(id: Value(id), data: Value(data));
  }

  factory ExerciseTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseTableData(
      id: serializer.fromJson<String>(json['id']),
      data: serializer.fromJson<Exercise>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'data': serializer.toJson<Exercise>(data),
    };
  }

  ExerciseTableData copyWith({String? id, Exercise? data}) =>
      ExerciseTableData(id: id ?? this.id, data: data ?? this.data);
  ExerciseTableData copyWithCompanion(ExerciseTableCompanion data) {
    return ExerciseTableData(
      id: data.id.present ? data.id.value : this.id,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseTableData(')
          ..write('id: $id, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseTableData &&
          other.id == this.id &&
          other.data == this.data);
}

class ExerciseTableCompanion extends UpdateCompanion<ExerciseTableData> {
  final Value<String> id;
  final Value<Exercise> data;
  final Value<int> rowid;
  const ExerciseTableCompanion({
    this.id = const Value.absent(),
    this.data = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseTableCompanion.insert({
    required String id,
    required Exercise data,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       data = Value(data);
  static Insertable<ExerciseTableData> custom({
    Expression<String>? id,
    Expression<String>? data,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (data != null) 'data': data,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseTableCompanion copyWith({
    Value<String>? id,
    Value<Exercise>? data,
    Value<int>? rowid,
  }) {
    return ExerciseTableCompanion(
      id: id ?? this.id,
      data: data ?? this.data,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(
        $ExerciseTableTable.$converterdata.toSql(data.value),
      );
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
          ..write('data: $data, ')
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
  @override
  late final GeneratedColumnWithTypeConverter<ExerciseSet, String> data =
      GeneratedColumn<String>(
        'data',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ExerciseSet>($ExerciseSetTableTable.$converterdata);
  @override
  List<GeneratedColumn> get $columns => [id, data];
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
      data: $ExerciseSetTableTable.$converterdata.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}data'],
        )!,
      ),
    );
  }

  @override
  $ExerciseSetTableTable createAlias(String alias) {
    return $ExerciseSetTableTable(attachedDatabase, alias);
  }

  static TypeConverter<ExerciseSet, String> $converterdata =
      exerciseSetConverter;
}

class ExerciseSetTableData extends DataClass
    implements Insertable<ExerciseSetTableData> {
  final String id;
  final ExerciseSet data;
  const ExerciseSetTableData({required this.id, required this.data});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['data'] = Variable<String>(
        $ExerciseSetTableTable.$converterdata.toSql(data),
      );
    }
    return map;
  }

  ExerciseSetTableCompanion toCompanion(bool nullToAbsent) {
    return ExerciseSetTableCompanion(id: Value(id), data: Value(data));
  }

  factory ExerciseSetTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseSetTableData(
      id: serializer.fromJson<String>(json['id']),
      data: serializer.fromJson<ExerciseSet>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'data': serializer.toJson<ExerciseSet>(data),
    };
  }

  ExerciseSetTableData copyWith({String? id, ExerciseSet? data}) =>
      ExerciseSetTableData(id: id ?? this.id, data: data ?? this.data);
  ExerciseSetTableData copyWithCompanion(ExerciseSetTableCompanion data) {
    return ExerciseSetTableData(
      id: data.id.present ? data.id.value : this.id,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetTableData(')
          ..write('id: $id, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, data);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseSetTableData &&
          other.id == this.id &&
          other.data == this.data);
}

class ExerciseSetTableCompanion extends UpdateCompanion<ExerciseSetTableData> {
  final Value<String> id;
  final Value<ExerciseSet> data;
  final Value<int> rowid;
  const ExerciseSetTableCompanion({
    this.id = const Value.absent(),
    this.data = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseSetTableCompanion.insert({
    required String id,
    required ExerciseSet data,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       data = Value(data);
  static Insertable<ExerciseSetTableData> custom({
    Expression<String>? id,
    Expression<String>? data,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (data != null) 'data': data,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseSetTableCompanion copyWith({
    Value<String>? id,
    Value<ExerciseSet>? data,
    Value<int>? rowid,
  }) {
    return ExerciseSetTableCompanion(
      id: id ?? this.id,
      data: data ?? this.data,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(
        $ExerciseSetTableTable.$converterdata.toSql(data.value),
      );
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
          ..write('data: $data, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseSetLinkTableTable extends ExerciseSetLinkTable
    with TableInfo<$ExerciseSetLinkTableTable, ExerciseSetLinkTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseSetLinkTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _setIdMeta = const VerificationMeta('setId');
  @override
  late final GeneratedColumn<String> setId = GeneratedColumn<String>(
    'set_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [setId, exerciseId, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_set_link_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseSetLinkTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('set_id')) {
      context.handle(
        _setIdMeta,
        setId.isAcceptableOrUnknown(data['set_id']!, _setIdMeta),
      );
    } else if (isInserting) {
      context.missing(_setIdMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {setId, exerciseId};
  @override
  ExerciseSetLinkTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseSetLinkTableData(
      setId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}set_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $ExerciseSetLinkTableTable createAlias(String alias) {
    return $ExerciseSetLinkTableTable(attachedDatabase, alias);
  }
}

class ExerciseSetLinkTableData extends DataClass
    implements Insertable<ExerciseSetLinkTableData> {
  final String setId;
  final String exerciseId;
  final int position;
  const ExerciseSetLinkTableData({
    required this.setId,
    required this.exerciseId,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['set_id'] = Variable<String>(setId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['position'] = Variable<int>(position);
    return map;
  }

  ExerciseSetLinkTableCompanion toCompanion(bool nullToAbsent) {
    return ExerciseSetLinkTableCompanion(
      setId: Value(setId),
      exerciseId: Value(exerciseId),
      position: Value(position),
    );
  }

  factory ExerciseSetLinkTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseSetLinkTableData(
      setId: serializer.fromJson<String>(json['setId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'setId': serializer.toJson<String>(setId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'position': serializer.toJson<int>(position),
    };
  }

  ExerciseSetLinkTableData copyWith({
    String? setId,
    String? exerciseId,
    int? position,
  }) => ExerciseSetLinkTableData(
    setId: setId ?? this.setId,
    exerciseId: exerciseId ?? this.exerciseId,
    position: position ?? this.position,
  );
  ExerciseSetLinkTableData copyWithCompanion(
    ExerciseSetLinkTableCompanion data,
  ) {
    return ExerciseSetLinkTableData(
      setId: data.setId.present ? data.setId.value : this.setId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetLinkTableData(')
          ..write('setId: $setId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(setId, exerciseId, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseSetLinkTableData &&
          other.setId == this.setId &&
          other.exerciseId == this.exerciseId &&
          other.position == this.position);
}

class ExerciseSetLinkTableCompanion
    extends UpdateCompanion<ExerciseSetLinkTableData> {
  final Value<String> setId;
  final Value<String> exerciseId;
  final Value<int> position;
  final Value<int> rowid;
  const ExerciseSetLinkTableCompanion({
    this.setId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseSetLinkTableCompanion.insert({
    required String setId,
    required String exerciseId,
    required int position,
    this.rowid = const Value.absent(),
  }) : setId = Value(setId),
       exerciseId = Value(exerciseId),
       position = Value(position);
  static Insertable<ExerciseSetLinkTableData> custom({
    Expression<String>? setId,
    Expression<String>? exerciseId,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (setId != null) 'set_id': setId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseSetLinkTableCompanion copyWith({
    Value<String>? setId,
    Value<String>? exerciseId,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return ExerciseSetLinkTableCompanion(
      setId: setId ?? this.setId,
      exerciseId: exerciseId ?? this.exerciseId,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (setId.present) {
      map['set_id'] = Variable<String>(setId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseSetLinkTableCompanion(')
          ..write('setId: $setId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PowerTrainingTableTable powerTrainingTable =
      $PowerTrainingTableTable(this);
  late final $ExerciseTableTable exerciseTable = $ExerciseTableTable(this);
  late final $ExerciseSetTableTable exerciseSetTable = $ExerciseSetTableTable(
    this,
  );
  late final $ExerciseSetLinkTableTable exerciseSetLinkTable =
      $ExerciseSetLinkTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    powerTrainingTable,
    exerciseTable,
    exerciseSetTable,
    exerciseSetLinkTable,
  ];
}

typedef $$PowerTrainingTableTableCreateCompanionBuilder =
    PowerTrainingTableCompanion Function({
      required String id,
      required PowerTraining data,
      Value<String?> setId,
      Value<int> rowid,
    });
typedef $$PowerTrainingTableTableUpdateCompanionBuilder =
    PowerTrainingTableCompanion Function({
      Value<String> id,
      Value<PowerTraining> data,
      Value<String?> setId,
      Value<int> rowid,
    });

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

  ColumnWithTypeConverterFilters<PowerTraining, PowerTraining, String>
  get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get setId => $composableBuilder(
    column: $table.setId,
    builder: (column) => ColumnFilters(column),
  );
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

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get setId => $composableBuilder(
    column: $table.setId,
    builder: (column) => ColumnOrderings(column),
  );
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

  GeneratedColumnWithTypeConverter<PowerTraining, String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<String> get setId =>
      $composableBuilder(column: $table.setId, builder: (column) => column);
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
          (
            PowerTrainingTableData,
            BaseReferences<
              _$AppDatabase,
              $PowerTrainingTableTable,
              PowerTrainingTableData
            >,
          ),
          PowerTrainingTableData,
          PrefetchHooks Function()
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
                Value<PowerTraining> data = const Value.absent(),
                Value<String?> setId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PowerTrainingTableCompanion(
                id: id,
                data: data,
                setId: setId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required PowerTraining data,
                Value<String?> setId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PowerTrainingTableCompanion.insert(
                id: id,
                data: data,
                setId: setId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PowerTrainingTableTable, PowerTrainingTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $PowerTrainingTableTable,
                    PowerTrainingTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
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
      (
        PowerTrainingTableData,
        BaseReferences<
          _$AppDatabase,
          $PowerTrainingTableTable,
          PowerTrainingTableData
        >,
      ),
      PowerTrainingTableData,
      PrefetchHooks Function()
    >;
typedef $$ExerciseTableTableCreateCompanionBuilder =
    ExerciseTableCompanion Function({
      required String id,
      required Exercise data,
      Value<int> rowid,
    });
typedef $$ExerciseTableTableUpdateCompanionBuilder =
    ExerciseTableCompanion Function({
      Value<String> id,
      Value<Exercise> data,
      Value<int> rowid,
    });

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

  ColumnWithTypeConverterFilters<Exercise, Exercise, String> get data =>
      $composableBuilder(
        column: $table.data,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
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

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );
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

  GeneratedColumnWithTypeConverter<Exercise, String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);
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
          (
            ExerciseTableData,
            BaseReferences<
              _$AppDatabase,
              $ExerciseTableTable,
              ExerciseTableData
            >,
          ),
          ExerciseTableData,
          PrefetchHooks Function()
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
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<Exercise> data = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => ExerciseTableCompanion(id: id, data: data, rowid: rowid),
          createCompanionCallback: ({
            required String id,
            required Exercise data,
            Value<int> rowid = const Value.absent(),
          }) => ExerciseTableCompanion.insert(id: id, data: data, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExerciseTableTable, ExerciseTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ExerciseTableTable,
                    ExerciseTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
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
      (
        ExerciseTableData,
        BaseReferences<_$AppDatabase, $ExerciseTableTable, ExerciseTableData>,
      ),
      ExerciseTableData,
      PrefetchHooks Function()
    >;
typedef $$ExerciseSetTableTableCreateCompanionBuilder =
    ExerciseSetTableCompanion Function({
      required String id,
      required ExerciseSet data,
      Value<int> rowid,
    });
typedef $$ExerciseSetTableTableUpdateCompanionBuilder =
    ExerciseSetTableCompanion Function({
      Value<String> id,
      Value<ExerciseSet> data,
      Value<int> rowid,
    });

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

  ColumnWithTypeConverterFilters<ExerciseSet, ExerciseSet, String> get data =>
      $composableBuilder(
        column: $table.data,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
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

  ColumnOrderings<String> get data => $composableBuilder(
    column: $table.data,
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

  GeneratedColumnWithTypeConverter<ExerciseSet, String> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);
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
          (
            ExerciseSetTableData,
            BaseReferences<
              _$AppDatabase,
              $ExerciseSetTableTable,
              ExerciseSetTableData
            >,
          ),
          ExerciseSetTableData,
          PrefetchHooks Function()
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
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<ExerciseSet> data = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => ExerciseSetTableCompanion(id: id, data: data, rowid: rowid),
          createCompanionCallback:
              ({
                required String id,
                required ExerciseSet data,
                Value<int> rowid = const Value.absent(),
              }) => ExerciseSetTableCompanion.insert(
                id: id,
                data: data,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExerciseSetTableTable, ExerciseSetTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $ExerciseSetTableTable,
                    ExerciseSetTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
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
      (
        ExerciseSetTableData,
        BaseReferences<
          _$AppDatabase,
          $ExerciseSetTableTable,
          ExerciseSetTableData
        >,
      ),
      ExerciseSetTableData,
      PrefetchHooks Function()
    >;
typedef $$ExerciseSetLinkTableTableCreateCompanionBuilder =
    ExerciseSetLinkTableCompanion Function({
      required String setId,
      required String exerciseId,
      required int position,
      Value<int> rowid,
    });
typedef $$ExerciseSetLinkTableTableUpdateCompanionBuilder =
    ExerciseSetLinkTableCompanion Function({
      Value<String> setId,
      Value<String> exerciseId,
      Value<int> position,
      Value<int> rowid,
    });

class $$ExerciseSetLinkTableTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseSetLinkTableTable> {
  $$ExerciseSetLinkTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get setId => $composableBuilder(
    column: $table.setId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExerciseSetLinkTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseSetLinkTableTable> {
  $$ExerciseSetLinkTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get setId => $composableBuilder(
    column: $table.setId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseSetLinkTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseSetLinkTableTable> {
  $$ExerciseSetLinkTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get setId =>
      $composableBuilder(column: $table.setId, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);
}

class $$ExerciseSetLinkTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseSetLinkTableTable,
          ExerciseSetLinkTableData,
          $$ExerciseSetLinkTableTableFilterComposer,
          $$ExerciseSetLinkTableTableOrderingComposer,
          $$ExerciseSetLinkTableTableAnnotationComposer,
          $$ExerciseSetLinkTableTableCreateCompanionBuilder,
          $$ExerciseSetLinkTableTableUpdateCompanionBuilder,
          (
            ExerciseSetLinkTableData,
            BaseReferences<
              _$AppDatabase,
              $ExerciseSetLinkTableTable,
              ExerciseSetLinkTableData
            >,
          ),
          ExerciseSetLinkTableData,
          PrefetchHooks Function()
        > {
  $$ExerciseSetLinkTableTableTableManager(
    _$AppDatabase db,
    $ExerciseSetLinkTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseSetLinkTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseSetLinkTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ExerciseSetLinkTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> setId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseSetLinkTableCompanion(
                setId: setId,
                exerciseId: exerciseId,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String setId,
                required String exerciseId,
                required int position,
                Value<int> rowid = const Value.absent(),
              }) => ExerciseSetLinkTableCompanion.insert(
                setId: setId,
                exerciseId: exerciseId,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $ExerciseSetLinkTableTable,
                    ExerciseSetLinkTableData
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ExerciseSetLinkTableTable,
                    ExerciseSetLinkTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExerciseSetLinkTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseSetLinkTableTable,
      ExerciseSetLinkTableData,
      $$ExerciseSetLinkTableTableFilterComposer,
      $$ExerciseSetLinkTableTableOrderingComposer,
      $$ExerciseSetLinkTableTableAnnotationComposer,
      $$ExerciseSetLinkTableTableCreateCompanionBuilder,
      $$ExerciseSetLinkTableTableUpdateCompanionBuilder,
      (
        ExerciseSetLinkTableData,
        BaseReferences<
          _$AppDatabase,
          $ExerciseSetLinkTableTable,
          ExerciseSetLinkTableData
        >,
      ),
      ExerciseSetLinkTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PowerTrainingTableTableTableManager get powerTrainingTable =>
      $$PowerTrainingTableTableTableManager(_db, _db.powerTrainingTable);
  $$ExerciseTableTableTableManager get exerciseTable =>
      $$ExerciseTableTableTableManager(_db, _db.exerciseTable);
  $$ExerciseSetTableTableTableManager get exerciseSetTable =>
      $$ExerciseSetTableTableTableManager(_db, _db.exerciseSetTable);
  $$ExerciseSetLinkTableTableTableManager get exerciseSetLinkTable =>
      $$ExerciseSetLinkTableTableTableManager(_db, _db.exerciseSetLinkTable);
}
