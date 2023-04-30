import 'package:catty/src/core/database/catty_database.dart';
import 'package:drift/drift.dart';

part 'facts_history_data_source.g.dart';

abstract class CatsHistoryDataSource {
  Future<List<CatsHistoryData>> getAllCatsHistory();

  Future<void> insert(CatsHistoryCompanion entry);
}

@DriftAccessor(tables: [CatsHistory])
class CatsHistoryDao extends DatabaseAccessor<CattyDatabase>
    with _$CatsHistoryDaoMixin
    implements CatsHistoryDataSource {
  CatsHistoryDao(super.attachedDatabase);

  @override
  Future<List<CatsHistoryData>> getAllCatsHistory() =>
      select(attachedDatabase.catsHistory).get();

  @override
  Future<void> insert(CatsHistoryCompanion entry) =>
      into(attachedDatabase.catsHistory).insert(entry);
}
