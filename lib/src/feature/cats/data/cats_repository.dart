import 'package:catty/src/feature/cats/data/cat_facts_data_source.dart';
import 'package:catty/src/feature/cats/data/cat_images_data_source.dart';
import 'package:catty/src/feature/cats/model/cat_image_dto.dart';

/// {@template facts_repository}
/// [CatsRepository] is an intermediate abstraction
/// between BLoC and data source.
/// {@endtemplate}
abstract class CatsRepository {
  /// Returns a streamed response of a random fact about cats
  Stream<String> getFact();

  /// Load random image
  Stream<CatImageDto> loadRandomImage({
    required int limit,
  });
}

/// {@macro facts_repository}
class CatsRepositoryImpl implements CatsRepository {
  /// {@macro facts_repository}
  CatsRepositoryImpl({
    required CatFactsDataSource factsDataSource,
    required CatImagesDataSource catImagesDataSource,
  })  : _factsDataSource = factsDataSource,
        _catImagesDataSource = catImagesDataSource;

  final CatFactsDataSource _factsDataSource;

  final CatImagesDataSource _catImagesDataSource;

  @override
  Stream<String> getFact() => _factsDataSource.getFact();

  @override
  Stream<CatImageDto> loadRandomImage({
    required int limit,
  }) =>
      _catImagesDataSource.loadRandomImage(limit: limit);
}
