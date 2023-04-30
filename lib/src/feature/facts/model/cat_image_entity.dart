import 'package:freezed_annotation/freezed_annotation.dart';

part 'cat_image_entity.freezed.dart';

@freezed
class CatImageEntity with _$CatImageEntity {
  const factory CatImageEntity({
    required String url,
    required String id,
    required double width,
    required double height,
  }) = _CatImageEntity;
}
