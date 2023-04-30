import 'dart:convert';

import 'package:catty/src/core/utils/extensions/collection_extensions.dart';
import 'package:catty/src/feature/facts/model/cat_image_dto.dart';
import 'package:http/http.dart' as http;

abstract class CatImagesDataSource {
  Stream<CatImageDto> loadRandomImage({
    required int limit,
  });
}

class CatImagesDataSourceTheCatApi implements CatImagesDataSource {
  CatImagesDataSourceTheCatApi() : _httpClient = http.Client();

  final http.Client _httpClient;

  @override
  Stream<CatImageDto> loadRandomImage({required int limit}) => Stream<List<Object?>>.fromFuture(
        _httpClient
            .get(Uri.parse('https://api.thecatapi.com/v1/images/search?limit=$limit'))
            .then((response) => response.body)
            .then((e) => jsonDecode(e) as List<Object?>),
      ).asyncExpand(
        (event) => event.whereType<Map<String, Object?>>().map(CatImageDto.fromJson).asStream(),
      );
}
