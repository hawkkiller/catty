import 'package:catty/src/feature/facts/data/cat_images_data_source.dart';
import 'package:catty/src/feature/facts/data/facts_data_source.dart';
import 'package:catty/src/feature/facts/model/cat_image_entity.dart';

abstract class FactsRepository {
  Stream<String> getFact();

  Stream<CatImageEntity> loadRandomImage({
    required int limit,
  });
}

class FactsRepositoryImpl implements FactsRepository {
  FactsRepositoryImpl({
    required FactsDataSource factsDataSource,
    required CatImagesDataSource catImagesDataSource,
  })  : _factsDataSource = factsDataSource,
        _catImagesDataSource = catImagesDataSource;

  final FactsDataSource _factsDataSource;

  final CatImagesDataSource _catImagesDataSource;

  @override
  Stream<String> getFact() => _factsDataSource.getFact();

  @override
  Stream<CatImageEntity> loadRandomImage({required int limit}) =>
      _catImagesDataSource.loadRandomImage(limit: limit).map((e) => e.toEntity());
}
