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
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 90),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumnWithTypeConverter<PowerTraining, String> data =
      GeneratedColumn<String>('data', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<PowerTraining>(
              $PowerTrainingTableTable.$converterdata);
  @override
  List<GeneratedColumn> get $columns => [id, data];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'power_training_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PowerTrainingTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    context.handle(_dataMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  PowerTrainingTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PowerTrainingTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      data: $PowerTrainingTableTable.$converterdata.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}data'])!),
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
  const PowerTrainingTableData({required this.id, required this.data});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['data'] =
          Variable<String>($PowerTrainingTableTable.$converterdata.toSql(data));
    }
    return map;
  }

  PowerTrainingTableCompanion toCompanion(bool nullToAbsent) {
    return PowerTrainingTableCompanion(
      id: Value(id),
      data: Value(data),
    );
  }

  factory PowerTrainingTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PowerTrainingTableData(
      id: serializer.fromJson<String>(json['id']),
      data: serializer.fromJson<PowerTraining>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'data': serializer.toJson<PowerTraining>(data),
    };
  }

  PowerTrainingTableData copyWith({String? id, PowerTraining? data}) =>
      PowerTrainingTableData(
        id: id ?? this.id,
        data: data ?? this.data,
      );
  @override
  String toString() {
    return (StringBuffer('PowerTrainingTableData(')
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
      (other is PowerTrainingTableData &&
          other.id == this.id &&
          other.data == this.data);
}

class PowerTrainingTableCompanion
    extends UpdateCompanion<PowerTrainingTableData> {
  final Value<String> id;
  final Value<PowerTraining> data;
  final Value<int> rowid;
  const PowerTrainingTableCompanion({
    this.id = const Value.absent(),
    this.data = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PowerTrainingTableCompanion.insert({
    required String id,
    required PowerTraining data,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        data = Value(data);
  static Insertable<PowerTrainingTableData> custom({
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

  PowerTrainingTableCompanion copyWith(
      {Value<String>? id, Value<PowerTraining>? data, Value<int>? rowid}) {
    return PowerTrainingTableCompanion(
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
          $PowerTrainingTableTable.$converterdata.toSql(data.value));
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
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $PowerTrainingTableTable powerTrainingTable =
      $PowerTrainingTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [powerTrainingTable];
}
