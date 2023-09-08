// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class CatsHistory extends Table with TableInfo<CatsHistory, CatsHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CatsHistory(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'createdAt', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\'))',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>(
      'updatedAt', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\'))',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _factMeta = const VerificationMeta('fact');
  late final GeneratedColumn<String> fact = GeneratedColumn<String>(
      'fact', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, updatedAt, fact, link];
  @override
  String get aliasedName => _alias ?? 'cats_history';
  @override
  String get actualTableName => 'cats_history';
  @override
  VerificationContext validateIntegrity(Insertable<CatsHistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('createdAt')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['createdAt']!, _createdAtMeta));
    }
    if (data.containsKey('updatedAt')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updatedAt']!, _updatedAtMeta));
    }
    if (data.containsKey('fact')) {
      context.handle(
          _factMeta, fact.isAcceptableOrUnknown(data['fact']!, _factMeta));
    } else if (isInserting) {
      context.missing(_factMeta);
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CatsHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CatsHistoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}createdAt'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}updatedAt'])!,
      fact: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fact'])!,
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link'])!,
    );
  }

  @override
  CatsHistory createAlias(String alias) {
    return CatsHistory(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CatsHistoryData extends DataClass implements Insertable<CatsHistoryData> {
  final int id;
  final int createdAt;
  final int updatedAt;
  final String fact;
  final String link;
  const CatsHistoryData(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.fact,
      required this.link});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['createdAt'] = Variable<int>(createdAt);
    map['updatedAt'] = Variable<int>(updatedAt);
    map['fact'] = Variable<String>(fact);
    map['link'] = Variable<String>(link);
    return map;
  }

  CatsHistoryCompanion toCompanion(bool nullToAbsent) {
    return CatsHistoryCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      fact: Value(fact),
      link: Value(link),
    );
  }

  factory CatsHistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CatsHistoryData(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      updatedAt: serializer.fromJson<int>(json['updatedAt']),
      fact: serializer.fromJson<String>(json['fact']),
      link: serializer.fromJson<String>(json['link']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<int>(createdAt),
      'updatedAt': serializer.toJson<int>(updatedAt),
      'fact': serializer.toJson<String>(fact),
      'link': serializer.toJson<String>(link),
    };
  }

  CatsHistoryData copyWith(
          {int? id,
          int? createdAt,
          int? updatedAt,
          String? fact,
          String? link}) =>
      CatsHistoryData(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        fact: fact ?? this.fact,
        link: link ?? this.link,
      );
  @override
  String toString() {
    return (StringBuffer('CatsHistoryData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fact: $fact, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, fact, link);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CatsHistoryData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.fact == this.fact &&
          other.link == this.link);
}

class CatsHistoryCompanion extends UpdateCompanion<CatsHistoryData> {
  final Value<int> id;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<String> fact;
  final Value<String> link;
  const CatsHistoryCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fact = const Value.absent(),
    this.link = const Value.absent(),
  });
  CatsHistoryCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String fact,
    required String link,
  })  : fact = Value(fact),
        link = Value(link);
  static Insertable<CatsHistoryData> custom({
    Expression<int>? id,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<String>? fact,
    Expression<String>? link,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'createdAt': createdAt,
      if (updatedAt != null) 'updatedAt': updatedAt,
      if (fact != null) 'fact': fact,
      if (link != null) 'link': link,
    });
  }

  CatsHistoryCompanion copyWith(
      {Value<int>? id,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<String>? fact,
      Value<String>? link}) {
    return CatsHistoryCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fact: fact ?? this.fact,
      link: link ?? this.link,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['createdAt'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updatedAt'] = Variable<int>(updatedAt.value);
    }
    if (fact.present) {
      map['fact'] = Variable<String>(fact.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CatsHistoryCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fact: $fact, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final CatsHistory catsHistory = CatsHistory(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [catsHistory];
}
