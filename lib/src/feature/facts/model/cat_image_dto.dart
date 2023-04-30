import 'package:catty/src/feature/facts/model/cat_image_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cat_image_dto.freezed.dart';
part 'cat_image_dto.g.dart';

@freezed
class CatImageDto with _$CatImageDto {
  const factory CatImageDto({
    required String url,
    required String id,
    required double width,
    required double height,
  }) = _CatImageDto;

  const CatImageDto._();

  factory CatImageDto.fromJson(Map<String, dynamic> json) => _$CatImageDtoFromJson(json);

  CatImageEntity toEntity() => CatImageEntity(
        url: url,
        id: id,
        width: width,
        height: height,
      );
}
