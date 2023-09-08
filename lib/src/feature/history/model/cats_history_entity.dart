/// {@template cats_history_entity}
/// [CatsHistoryEntity] is a model that is stored in database
/// and represents a finished completion about cat, associated image.
/// {@endtemplate}
class CatsHistoryEntity {
  /// The finished completion about cat.
  final String fact;

  /// The link of the image.
  final String link;

  /// The date when the fact was created.
  final DateTime createdAt;

  /// {@macro cats_history_entity}
  const CatsHistoryEntity({
    required this.fact,
    required this.link,
    required this.createdAt,
  });

  @override
  String toString() =>
      'CatsHistoryEntity(fact: $fact, link: $link, createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CatsHistoryEntity &&
        other.fact == fact &&
        other.link == link &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => fact.hashCode ^ link.hashCode ^ createdAt.hashCode;
}
