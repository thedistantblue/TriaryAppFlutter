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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
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
  PowerTrainingTableData copyWithCompanion(PowerTrainingTableCompanion data) {
    return PowerTrainingTableData(
      id: data.id.present ? data.id.value : this.id,
      data: data.data.present ? data.data.value : this.data,
    );
  }

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
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PowerTrainingTableTable powerTrainingTable =
      $PowerTrainingTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [powerTrainingTable];
}

typedef $$PowerTrainingTableTableCreateCompanionBuilder
    = PowerTrainingTableCompanion Function({
  required String id,
  required PowerTraining data,
  Value<int> rowid,
});
typedef $$PowerTrainingTableTableUpdateCompanionBuilder
    = PowerTrainingTableCompanion Function({
  Value<String> id,
  Value<PowerTraining> data,
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
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PowerTraining, PowerTraining, String>
      get data => $composableBuilder(
          column: $table.data,
          builder: (column) => ColumnWithTypeConverterFilters(column));
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
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get data => $composableBuilder(
      column: $table.data, builder: (column) => ColumnOrderings(column));
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
}

class $$PowerTrainingTableTableTableManager extends RootTableManager<
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
      BaseReferences<_$AppDatabase, $PowerTrainingTableTable,
          PowerTrainingTableData>
    ),
    PowerTrainingTableData,
    PrefetchHooks Function()> {
  $$PowerTrainingTableTableTableManager(
      _$AppDatabase db, $PowerTrainingTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PowerTrainingTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PowerTrainingTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PowerTrainingTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<PowerTraining> data = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PowerTrainingTableCompanion(
            id: id,
            data: data,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required PowerTraining data,
            Value<int> rowid = const Value.absent(),
          }) =>
              PowerTrainingTableCompanion.insert(
            id: id,
            data: data,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PowerTrainingTableTableProcessedTableManager = ProcessedTableManager<
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
      BaseReferences<_$AppDatabase, $PowerTrainingTableTable,
          PowerTrainingTableData>
    ),
    PowerTrainingTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PowerTrainingTableTableTableManager get powerTrainingTable =>
      $$PowerTrainingTableTableTableManager(_db, _db.powerTrainingTable);
}
