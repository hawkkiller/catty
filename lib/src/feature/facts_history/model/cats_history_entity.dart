import 'package:freezed_annotation/freezed_annotation.dart';

part 'cats_history_entity.freezed.dart';

@freezed
class CatsHistoryEntity with _$CatsHistoryEntity {
  const factory CatsHistoryEntity({
    required String fact,
    required String link,
    required DateTime createdAt,
  }) = _CatsHistoryEntity;
}
