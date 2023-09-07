import 'dart:convert';

import 'package:catty/src/feature/cats/model/cat_image_dto.dart';
import 'package:http/http.dart' as http;

/// {@template cat_images_data_source}
/// [CatImagesDataSource] is the lowest layer that interacts with the API.
/// {@endtemplate}
abstract class CatImagesDataSource {
  /// Returns [Stream] of cat images.
  Stream<CatImageDto> loadRandomImage({
    required int limit,
  });
}

/// {@macro cat_images_data_source}
class CatImagesDataSourceTheCatApi implements CatImagesDataSource {
  /// {@macro cat_images_data_source}
  CatImagesDataSourceTheCatApi() : _httpClient = http.Client();

  final http.Client _httpClient;

  static final _uri = Uri.parse('https://api.thecatapi.com/v1/images/search');

  @override
  Stream<CatImageDto> loadRandomImage({required int limit}) =>
      Stream<List<Object?>>.fromFuture(
        _httpClient
            .get(_uri)
            .then((response) => response.body)
            .then((e) => jsonDecode(e) as List<Object?>),
      ).asyncExpand(
        (event) => Stream.fromIterable(
          event.whereType<Map<String, Object?>>().map(CatImageDto.fromJson),
        ),
      );
}
