import 'package:catty/src/feature/cats/model/cat_image_dto.dart';
import 'package:catty/src/feature/history/data/cats_history_data_source.dart';
import 'package:catty/src/feature/history/model/cats_history_entity.dart';

/// {@template facts_history_repository}
/// [CatsHistoryRepository] provides facilities to store and retrieve
/// {@endtemplate}
abstract interface class CatsHistoryRepository {
  /// Load cats history.
  Stream<CatsHistoryEntity> loadCatsHistory({
    int limit = 10,
    int? offset,
  });

  /// Insert [fact] and [image] into database.
  Future<CatsHistoryEntity> insert(String fact, CatImageDto image);
}

/// {@template facts_history_repository}
final class CatsHistoryRepositoryImpl implements CatsHistoryRepository {
  final CatsHistoryDataSource _catsHistoryDataSource;

  /// {@macro facts_history_repository}
  CatsHistoryRepositoryImpl(this._catsHistoryDataSource);

  @override
  Stream<CatsHistoryEntity> loadCatsHistory({
    int limit = 10,
    int? offset,
  }) =>
      _catsHistoryDataSource.loadCatsHistory(
        limit: limit,
        offset: offset,
      );

  @override
  Future<CatsHistoryEntity> insert(String fact, CatImageDto image) async {
    final entity = CatsHistoryEntity(
      fact: fact,
      link: image.url,
      createdAt: DateTime.now(),
    );
    await _catsHistoryDataSource.insert(entity);
    return entity;
  }
}
