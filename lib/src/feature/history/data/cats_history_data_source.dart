import 'package:catty/src/feature/history/model/cats_history_entity.dart';
import 'package:database/database.dart';
import 'package:drift/drift.dart';

/// {@template cats_history_data_source}
/// [CatsHistoryDataSource] provides facilities to store and retrieve
/// [CatsHistoryEntity] from database.
/// {@endtemplate}
abstract interface class CatsHistoryDataSource {
  /// Load cats history from database.
  Stream<CatsHistoryEntity> loadCatsHistory({
    int limit = 10,
    int? offset,
  });

  /// Insert [entity] into database.
  Future<void> insert(CatsHistoryEntity entity);
}

/// {@template cats_history_data_source}
final class CatsHistoryDataSourceDrift implements CatsHistoryDataSource {
  final AppDatabase _database;

  /// {@macro cats_history_data_source}
  CatsHistoryDataSourceDrift(this._database);

  @override
  Future<void> insert(CatsHistoryEntity entity) =>
      _database.into(_database.catsHistory).insert(
            CatsHistoryCompanion.insert(
              fact: entity.fact,
              link: entity.link,
            ),
          );

  @override
  Stream<CatsHistoryEntity> loadCatsHistory({int limit = 10, int? offset}) {
    final query = (_database.select(_database.catsHistory)
          ..limit(
            limit,
            offset: offset,
          )
          ..orderBy(
            [
              (e) => OrderingTerm(
                    expression: e.createdAt,
                    mode: OrderingMode.desc,
                  ),
            ],
          ))
        .get();

    return Stream.fromFuture(query).expand((element) => element).asyncMap(
          (e) => Future.value(
            CatsHistoryEntity(
              fact: e.fact,
              link: e.link,
              createdAt: DateTime.fromMillisecondsSinceEpoch(
                e.createdAt * 1000,
              ),
            ),
          ),
        );
  }
}
