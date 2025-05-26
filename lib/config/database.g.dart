// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DiagnosisTable extends Diagnosis
    with TableInfo<$DiagnosisTable, DiagnosisEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiagnosisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _diseaseIdMeta =
      const VerificationMeta('diseaseId');
  @override
  late final GeneratedColumn<String> diseaseId = GeneratedColumn<String>(
      'disease_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _percentageMeta =
      const VerificationMeta('percentage');
  @override
  late final GeneratedColumn<double> percentage = GeneratedColumn<double>(
      'percentage', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _explainMeta =
      const VerificationMeta('explain');
  @override
  late final GeneratedColumn<String> explain = GeneratedColumn<String>(
      'explain', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, diseaseId, percentage, explain, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'diagnosis';
  @override
  VerificationContext validateIntegrity(Insertable<DiagnosisEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('disease_id')) {
      context.handle(_diseaseIdMeta,
          diseaseId.isAcceptableOrUnknown(data['disease_id']!, _diseaseIdMeta));
    } else if (isInserting) {
      context.missing(_diseaseIdMeta);
    }
    if (data.containsKey('percentage')) {
      context.handle(
          _percentageMeta,
          percentage.isAcceptableOrUnknown(
              data['percentage']!, _percentageMeta));
    } else if (isInserting) {
      context.missing(_percentageMeta);
    }
    if (data.containsKey('explain')) {
      context.handle(_explainMeta,
          explain.isAcceptableOrUnknown(data['explain']!, _explainMeta));
    } else if (isInserting) {
      context.missing(_explainMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DiagnosisEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiagnosisEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      diseaseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}disease_id'])!,
      percentage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}percentage'])!,
      explain: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}explain'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DiagnosisTable createAlias(String alias) {
    return $DiagnosisTable(attachedDatabase, alias);
  }
}

class DiagnosisEntity extends DataClass implements Insertable<DiagnosisEntity> {
  final int id;
  final String diseaseId;
  final double percentage;
  final String explain;
  final DateTime createdAt;
  const DiagnosisEntity(
      {required this.id,
      required this.diseaseId,
      required this.percentage,
      required this.explain,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['disease_id'] = Variable<String>(diseaseId);
    map['percentage'] = Variable<double>(percentage);
    map['explain'] = Variable<String>(explain);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DiagnosisCompanion toCompanion(bool nullToAbsent) {
    return DiagnosisCompanion(
      id: Value(id),
      diseaseId: Value(diseaseId),
      percentage: Value(percentage),
      explain: Value(explain),
      createdAt: Value(createdAt),
    );
  }

  factory DiagnosisEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiagnosisEntity(
      id: serializer.fromJson<int>(json['id']),
      diseaseId: serializer.fromJson<String>(json['diseaseId']),
      percentage: serializer.fromJson<double>(json['percentage']),
      explain: serializer.fromJson<String>(json['explain']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'diseaseId': serializer.toJson<String>(diseaseId),
      'percentage': serializer.toJson<double>(percentage),
      'explain': serializer.toJson<String>(explain),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DiagnosisEntity copyWith(
          {int? id,
          String? diseaseId,
          double? percentage,
          String? explain,
          DateTime? createdAt}) =>
      DiagnosisEntity(
        id: id ?? this.id,
        diseaseId: diseaseId ?? this.diseaseId,
        percentage: percentage ?? this.percentage,
        explain: explain ?? this.explain,
        createdAt: createdAt ?? this.createdAt,
      );
  DiagnosisEntity copyWithCompanion(DiagnosisCompanion data) {
    return DiagnosisEntity(
      id: data.id.present ? data.id.value : this.id,
      diseaseId: data.diseaseId.present ? data.diseaseId.value : this.diseaseId,
      percentage:
          data.percentage.present ? data.percentage.value : this.percentage,
      explain: data.explain.present ? data.explain.value : this.explain,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiagnosisEntity(')
          ..write('id: $id, ')
          ..write('diseaseId: $diseaseId, ')
          ..write('percentage: $percentage, ')
          ..write('explain: $explain, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, diseaseId, percentage, explain, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiagnosisEntity &&
          other.id == this.id &&
          other.diseaseId == this.diseaseId &&
          other.percentage == this.percentage &&
          other.explain == this.explain &&
          other.createdAt == this.createdAt);
}

class DiagnosisCompanion extends UpdateCompanion<DiagnosisEntity> {
  final Value<int> id;
  final Value<String> diseaseId;
  final Value<double> percentage;
  final Value<String> explain;
  final Value<DateTime> createdAt;
  const DiagnosisCompanion({
    this.id = const Value.absent(),
    this.diseaseId = const Value.absent(),
    this.percentage = const Value.absent(),
    this.explain = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DiagnosisCompanion.insert({
    this.id = const Value.absent(),
    required String diseaseId,
    required double percentage,
    required String explain,
    this.createdAt = const Value.absent(),
  })  : diseaseId = Value(diseaseId),
        percentage = Value(percentage),
        explain = Value(explain);
  static Insertable<DiagnosisEntity> custom({
    Expression<int>? id,
    Expression<String>? diseaseId,
    Expression<double>? percentage,
    Expression<String>? explain,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (diseaseId != null) 'disease_id': diseaseId,
      if (percentage != null) 'percentage': percentage,
      if (explain != null) 'explain': explain,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DiagnosisCompanion copyWith(
      {Value<int>? id,
      Value<String>? diseaseId,
      Value<double>? percentage,
      Value<String>? explain,
      Value<DateTime>? createdAt}) {
    return DiagnosisCompanion(
      id: id ?? this.id,
      diseaseId: diseaseId ?? this.diseaseId,
      percentage: percentage ?? this.percentage,
      explain: explain ?? this.explain,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (diseaseId.present) {
      map['disease_id'] = Variable<String>(diseaseId.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<double>(percentage.value);
    }
    if (explain.present) {
      map['explain'] = Variable<String>(explain.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiagnosisCompanion(')
          ..write('id: $id, ')
          ..write('diseaseId: $diseaseId, ')
          ..write('percentage: $percentage, ')
          ..write('explain: $explain, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DetailDiagnosisTable extends DetailDiagnosis
    with TableInfo<$DetailDiagnosisTable, DetailDiagnosisEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DetailDiagnosisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _diagnosisIdMeta =
      const VerificationMeta('diagnosisId');
  @override
  late final GeneratedColumn<int> diagnosisId = GeneratedColumn<int>(
      'diagnosis_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _diseaseIdMeta =
      const VerificationMeta('diseaseId');
  @override
  late final GeneratedColumn<String> diseaseId = GeneratedColumn<String>(
      'disease_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _percentageMeta =
      const VerificationMeta('percentage');
  @override
  late final GeneratedColumn<double> percentage = GeneratedColumn<double>(
      'percentage', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, diagnosisId, diseaseId, percentage, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'detail_diagnosis';
  @override
  VerificationContext validateIntegrity(
      Insertable<DetailDiagnosisEntity> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('diagnosis_id')) {
      context.handle(
          _diagnosisIdMeta,
          diagnosisId.isAcceptableOrUnknown(
              data['diagnosis_id']!, _diagnosisIdMeta));
    } else if (isInserting) {
      context.missing(_diagnosisIdMeta);
    }
    if (data.containsKey('disease_id')) {
      context.handle(_diseaseIdMeta,
          diseaseId.isAcceptableOrUnknown(data['disease_id']!, _diseaseIdMeta));
    } else if (isInserting) {
      context.missing(_diseaseIdMeta);
    }
    if (data.containsKey('percentage')) {
      context.handle(
          _percentageMeta,
          percentage.isAcceptableOrUnknown(
              data['percentage']!, _percentageMeta));
    } else if (isInserting) {
      context.missing(_percentageMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DetailDiagnosisEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DetailDiagnosisEntity(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      diagnosisId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}diagnosis_id'])!,
      diseaseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}disease_id'])!,
      percentage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}percentage'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DetailDiagnosisTable createAlias(String alias) {
    return $DetailDiagnosisTable(attachedDatabase, alias);
  }
}

class DetailDiagnosisEntity extends DataClass
    implements Insertable<DetailDiagnosisEntity> {
  final int id;
  final int diagnosisId;
  final String diseaseId;
  final double percentage;
  final DateTime createdAt;
  const DetailDiagnosisEntity(
      {required this.id,
      required this.diagnosisId,
      required this.diseaseId,
      required this.percentage,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['diagnosis_id'] = Variable<int>(diagnosisId);
    map['disease_id'] = Variable<String>(diseaseId);
    map['percentage'] = Variable<double>(percentage);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DetailDiagnosisCompanion toCompanion(bool nullToAbsent) {
    return DetailDiagnosisCompanion(
      id: Value(id),
      diagnosisId: Value(diagnosisId),
      diseaseId: Value(diseaseId),
      percentage: Value(percentage),
      createdAt: Value(createdAt),
    );
  }

  factory DetailDiagnosisEntity.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DetailDiagnosisEntity(
      id: serializer.fromJson<int>(json['id']),
      diagnosisId: serializer.fromJson<int>(json['diagnosisId']),
      diseaseId: serializer.fromJson<String>(json['diseaseId']),
      percentage: serializer.fromJson<double>(json['percentage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'diagnosisId': serializer.toJson<int>(diagnosisId),
      'diseaseId': serializer.toJson<String>(diseaseId),
      'percentage': serializer.toJson<double>(percentage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DetailDiagnosisEntity copyWith(
          {int? id,
          int? diagnosisId,
          String? diseaseId,
          double? percentage,
          DateTime? createdAt}) =>
      DetailDiagnosisEntity(
        id: id ?? this.id,
        diagnosisId: diagnosisId ?? this.diagnosisId,
        diseaseId: diseaseId ?? this.diseaseId,
        percentage: percentage ?? this.percentage,
        createdAt: createdAt ?? this.createdAt,
      );
  DetailDiagnosisEntity copyWithCompanion(DetailDiagnosisCompanion data) {
    return DetailDiagnosisEntity(
      id: data.id.present ? data.id.value : this.id,
      diagnosisId:
          data.diagnosisId.present ? data.diagnosisId.value : this.diagnosisId,
      diseaseId: data.diseaseId.present ? data.diseaseId.value : this.diseaseId,
      percentage:
          data.percentage.present ? data.percentage.value : this.percentage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DetailDiagnosisEntity(')
          ..write('id: $id, ')
          ..write('diagnosisId: $diagnosisId, ')
          ..write('diseaseId: $diseaseId, ')
          ..write('percentage: $percentage, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, diagnosisId, diseaseId, percentage, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DetailDiagnosisEntity &&
          other.id == this.id &&
          other.diagnosisId == this.diagnosisId &&
          other.diseaseId == this.diseaseId &&
          other.percentage == this.percentage &&
          other.createdAt == this.createdAt);
}

class DetailDiagnosisCompanion extends UpdateCompanion<DetailDiagnosisEntity> {
  final Value<int> id;
  final Value<int> diagnosisId;
  final Value<String> diseaseId;
  final Value<double> percentage;
  final Value<DateTime> createdAt;
  const DetailDiagnosisCompanion({
    this.id = const Value.absent(),
    this.diagnosisId = const Value.absent(),
    this.diseaseId = const Value.absent(),
    this.percentage = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DetailDiagnosisCompanion.insert({
    this.id = const Value.absent(),
    required int diagnosisId,
    required String diseaseId,
    required double percentage,
    this.createdAt = const Value.absent(),
  })  : diagnosisId = Value(diagnosisId),
        diseaseId = Value(diseaseId),
        percentage = Value(percentage);
  static Insertable<DetailDiagnosisEntity> custom({
    Expression<int>? id,
    Expression<int>? diagnosisId,
    Expression<String>? diseaseId,
    Expression<double>? percentage,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (diagnosisId != null) 'diagnosis_id': diagnosisId,
      if (diseaseId != null) 'disease_id': diseaseId,
      if (percentage != null) 'percentage': percentage,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DetailDiagnosisCompanion copyWith(
      {Value<int>? id,
      Value<int>? diagnosisId,
      Value<String>? diseaseId,
      Value<double>? percentage,
      Value<DateTime>? createdAt}) {
    return DetailDiagnosisCompanion(
      id: id ?? this.id,
      diagnosisId: diagnosisId ?? this.diagnosisId,
      diseaseId: diseaseId ?? this.diseaseId,
      percentage: percentage ?? this.percentage,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (diagnosisId.present) {
      map['diagnosis_id'] = Variable<int>(diagnosisId.value);
    }
    if (diseaseId.present) {
      map['disease_id'] = Variable<String>(diseaseId.value);
    }
    if (percentage.present) {
      map['percentage'] = Variable<double>(percentage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DetailDiagnosisCompanion(')
          ..write('id: $id, ')
          ..write('diagnosisId: $diagnosisId, ')
          ..write('diseaseId: $diseaseId, ')
          ..write('percentage: $percentage, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DiagnosisTable diagnosis = $DiagnosisTable(this);
  late final $DetailDiagnosisTable detailDiagnosis =
      $DetailDiagnosisTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [diagnosis, detailDiagnosis];
}

typedef $$DiagnosisTableCreateCompanionBuilder = DiagnosisCompanion Function({
  Value<int> id,
  required String diseaseId,
  required double percentage,
  required String explain,
  Value<DateTime> createdAt,
});
typedef $$DiagnosisTableUpdateCompanionBuilder = DiagnosisCompanion Function({
  Value<int> id,
  Value<String> diseaseId,
  Value<double> percentage,
  Value<String> explain,
  Value<DateTime> createdAt,
});

class $$DiagnosisTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DiagnosisTable,
    DiagnosisEntity,
    $$DiagnosisTableFilterComposer,
    $$DiagnosisTableOrderingComposer,
    $$DiagnosisTableCreateCompanionBuilder,
    $$DiagnosisTableUpdateCompanionBuilder> {
  $$DiagnosisTableTableManager(_$AppDatabase db, $DiagnosisTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DiagnosisTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DiagnosisTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> diseaseId = const Value.absent(),
            Value<double> percentage = const Value.absent(),
            Value<String> explain = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DiagnosisCompanion(
            id: id,
            diseaseId: diseaseId,
            percentage: percentage,
            explain: explain,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String diseaseId,
            required double percentage,
            required String explain,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DiagnosisCompanion.insert(
            id: id,
            diseaseId: diseaseId,
            percentage: percentage,
            explain: explain,
            createdAt: createdAt,
          ),
        ));
}

class $$DiagnosisTableFilterComposer
    extends FilterComposer<_$AppDatabase, $DiagnosisTable> {
  $$DiagnosisTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get diseaseId => $state.composableBuilder(
      column: $state.table.diseaseId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get percentage => $state.composableBuilder(
      column: $state.table.percentage,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get explain => $state.composableBuilder(
      column: $state.table.explain,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$DiagnosisTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $DiagnosisTable> {
  $$DiagnosisTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get diseaseId => $state.composableBuilder(
      column: $state.table.diseaseId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get percentage => $state.composableBuilder(
      column: $state.table.percentage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get explain => $state.composableBuilder(
      column: $state.table.explain,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$DetailDiagnosisTableCreateCompanionBuilder = DetailDiagnosisCompanion
    Function({
  Value<int> id,
  required int diagnosisId,
  required String diseaseId,
  required double percentage,
  Value<DateTime> createdAt,
});
typedef $$DetailDiagnosisTableUpdateCompanionBuilder = DetailDiagnosisCompanion
    Function({
  Value<int> id,
  Value<int> diagnosisId,
  Value<String> diseaseId,
  Value<double> percentage,
  Value<DateTime> createdAt,
});

class $$DetailDiagnosisTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DetailDiagnosisTable,
    DetailDiagnosisEntity,
    $$DetailDiagnosisTableFilterComposer,
    $$DetailDiagnosisTableOrderingComposer,
    $$DetailDiagnosisTableCreateCompanionBuilder,
    $$DetailDiagnosisTableUpdateCompanionBuilder> {
  $$DetailDiagnosisTableTableManager(
      _$AppDatabase db, $DetailDiagnosisTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DetailDiagnosisTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DetailDiagnosisTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> diagnosisId = const Value.absent(),
            Value<String> diseaseId = const Value.absent(),
            Value<double> percentage = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DetailDiagnosisCompanion(
            id: id,
            diagnosisId: diagnosisId,
            diseaseId: diseaseId,
            percentage: percentage,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int diagnosisId,
            required String diseaseId,
            required double percentage,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              DetailDiagnosisCompanion.insert(
            id: id,
            diagnosisId: diagnosisId,
            diseaseId: diseaseId,
            percentage: percentage,
            createdAt: createdAt,
          ),
        ));
}

class $$DetailDiagnosisTableFilterComposer
    extends FilterComposer<_$AppDatabase, $DetailDiagnosisTable> {
  $$DetailDiagnosisTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get diagnosisId => $state.composableBuilder(
      column: $state.table.diagnosisId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get diseaseId => $state.composableBuilder(
      column: $state.table.diseaseId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get percentage => $state.composableBuilder(
      column: $state.table.percentage,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$DetailDiagnosisTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $DetailDiagnosisTable> {
  $$DetailDiagnosisTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get diagnosisId => $state.composableBuilder(
      column: $state.table.diagnosisId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get diseaseId => $state.composableBuilder(
      column: $state.table.diseaseId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get percentage => $state.composableBuilder(
      column: $state.table.percentage,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DiagnosisTableTableManager get diagnosis =>
      $$DiagnosisTableTableManager(_db, _db.diagnosis);
  $$DetailDiagnosisTableTableManager get detailDiagnosis =>
      $$DetailDiagnosisTableTableManager(_db, _db.detailDiagnosis);
}
