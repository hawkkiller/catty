/// {@template cat_image_dto}
/// Cat image dto, that is returned by **CatImagesDataSource**
/// {@endtemplate}
class CatImageDto {
  /// URL of a cat image
  final String url;

  /// ID of a cat image
  final String id;

  /// Width of a cat image
  final double width;

  /// Height of a cat image
  final double height;

  /// {@macro cat_image_dto}
  const CatImageDto({
    required this.url,
    required this.id,
    required this.width,
    required this.height,
  });

  /// Converts [json] to [CatImageDto]
  factory CatImageDto.fromJson(Map<String, Object?> json) {
    if (json
        case {
          'id': final String id,
          'url': final String url,
          'width': final int width,
          'height': final int height,
        }) {
      return CatImageDto(
        url: url,
        id: id,
        width: width.toDouble(),
        height: height.toDouble(),
      );
    }

    throw FormatException('Invalid json: $json');
  }
}
