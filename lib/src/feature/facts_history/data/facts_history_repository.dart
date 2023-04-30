import 'package:catty/src/core/database/catty_database.dart';
import 'package:catty/src/feature/facts/model/cat_image_entity.dart';
import 'package:catty/src/feature/facts_history/data/facts_history_data_source.dart';
import 'package:catty/src/feature/facts_history/model/cats_history_entity.dart';

abstract class FactsHistoryRepository {
  Future<List<CatsHistoryEntity>> getAllCatsHistory();

  Future<void> insert(String fact, CatImageEntity image);
}

class FactsHistoryRepositoryImpl implements FactsHistoryRepository {
  FactsHistoryRepositoryImpl(this._dataSource);

  final CatsHistoryDataSource _dataSource;

  @override
  Future<List<CatsHistoryEntity>> getAllCatsHistory() async {
    final history = await _dataSource.getAllCatsHistory();
    return history
        .map(
          (dto) => CatsHistoryEntity(
            fact: dto.fact,
            link: dto.link,
            createdAt: DateTime.fromMillisecondsSinceEpoch(dto.createdAt * 1000),
          ),
        )
        .toList();
  }

  @override
  Future<void> insert(String fact, CatImageEntity image) => _dataSource.insert(
        CatsHistoryCompanion.insert(
          fact: fact,
          link: image.url,
        ),
      );
}
