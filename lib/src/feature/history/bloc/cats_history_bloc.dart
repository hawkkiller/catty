import 'package:catty/src/core/utils/pattern_match.dart';
import 'package:catty/src/feature/cats/model/cat_image_dto.dart';
import 'package:catty/src/feature/history/data/cats_history_repository.dart';
import 'package:catty/src/feature/history/model/cats_history_entity.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

/// State that contains the history of facts about cats.
@immutable
sealed class CatsHistoryState extends _CatsHistoryStateBase {
  const CatsHistoryState._();

  /// State that indicates that the state machine is idling.
  const factory CatsHistoryState.idle({
    List<CatsHistoryEntity> history,
    String? error,
    bool reachedEnd,
  }) = _CatsHistoryStateIdle;

  /// State that indicates that the state machine is in progress.
  const factory CatsHistoryState.inProgress({
    List<CatsHistoryEntity> history,
    bool reachedEnd,
  }) = _CatsHistoryStateInProgress;
}

final class _CatsHistoryStateIdle extends CatsHistoryState {
  const _CatsHistoryStateIdle({
    this.history = const <CatsHistoryEntity>[],
    this.error,
    this.reachedEnd = false,
  }) : super._();

  @override
  final List<CatsHistoryEntity> history;

  @override
  final String? error;

  @override
  final bool reachedEnd;

  @override
  String toString() =>
      '_CatsHistoryStateIdle(history: $history, error: $error)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _CatsHistoryStateIdle &&
        const DeepCollectionEquality().equals(history, other.history) &&
        other.error == error &&
        other.reachedEnd == reachedEnd;
  }

  @override
  int get hashCode => history.hashCode ^ error.hashCode;
}

final class _CatsHistoryStateInProgress extends CatsHistoryState {
  const _CatsHistoryStateInProgress({
    this.history = const <CatsHistoryEntity>[],
    this.reachedEnd = false,
  }) : super._();

  @override
  final List<CatsHistoryEntity> history;

  @override
  final bool reachedEnd;

  @override
  String toString() => '_CatsHistoryStateInProgress('
      'history: $history, '
      'reachedEnd: '
      '$reachedEnd)'
      ')';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _CatsHistoryStateInProgress &&
        const DeepCollectionEquality().equals(history, other.history) &&
        other.reachedEnd == reachedEnd;
  }

  @override
  int get hashCode => history.hashCode;
}

abstract base class _CatsHistoryStateBase {
  const _CatsHistoryStateBase();

  abstract final List<CatsHistoryEntity> history;

  abstract final bool reachedEnd;

  bool get isInProgress => maybeMap(
        inProgress: (_) => true,
        orElse: () => false,
      );

  String? get error => maybeMap(
        idle: (state) => state.error,
        orElse: () => null,
      );

  T maybeMap<T>({
    required T Function() orElse,
    PatternMatch<T, _CatsHistoryStateIdle>? idle,
    PatternMatch<T, _CatsHistoryStateInProgress>? inProgress,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        inProgress: inProgress ?? (_) => orElse(),
      );

  T map<T>({
    required PatternMatch<T, _CatsHistoryStateIdle> idle,
    required PatternMatch<T, _CatsHistoryStateInProgress> inProgress,
  }) =>
      switch (this) {
        final _CatsHistoryStateIdle state => idle(state),
        final _CatsHistoryStateInProgress state => inProgress(state),
        _ => throw AssertionError('Unknown state: $this'),
      };
}

/// Cats history event
@immutable
sealed class CatsHistoryEvent extends _CatsHistoryEventBase {
  const CatsHistoryEvent._();

  /// Event that indicates that the history of
  /// facts about cats should be loaded.
  const factory CatsHistoryEvent.load({
    int limit,
  }) = _CatsHistoryLoad;

  /// Event that indicates that the fact about cats
  /// should be added to the history.
  const factory CatsHistoryEvent.add({
    required String fact,
    required CatImageDto image,
  }) = _CatsHistoryAdd;
}

final class _CatsHistoryAdd extends CatsHistoryEvent {
  const _CatsHistoryAdd({
    required this.fact,
    required this.image,
  }) : super._();

  final String fact;

  final CatImageDto image;

  @override
  String toString() => '_CatsHistoryAdd(fact: $fact, image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _CatsHistoryAdd &&
        other.fact == fact &&
        other.image == image;
  }

  @override
  int get hashCode => fact.hashCode ^ image.hashCode;
}

final class _CatsHistoryLoad extends CatsHistoryEvent {
  const _CatsHistoryLoad({
    this.limit = 10,
  }) : super._();

  final int limit;

  @override
  String toString() => '_CatsHistoryLoad(limit: $limit)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _CatsHistoryLoad && other.limit == limit;
  }

  @override
  int get hashCode => limit.hashCode;
}

abstract base class _CatsHistoryEventBase {
  const _CatsHistoryEventBase();

  T maybeMap<T>({
    required T Function() orElse,
    PatternMatch<T, _CatsHistoryLoad>? load,
    PatternMatch<T, _CatsHistoryAdd>? add,
  }) =>
      map(
        load: load ?? (_) => orElse(),
        add: add ?? (_) => orElse(),
      );

  T map<T>({
    required PatternMatch<T, _CatsHistoryLoad> load,
    required PatternMatch<T, _CatsHistoryAdd> add,
  }) =>
      switch (this) {
        final _CatsHistoryLoad event => load(event),
        final _CatsHistoryAdd event => add(event),
        _ => throw AssertionError('Unknown event: $this'),
      };
}

/// {@template cats_history_bloc}
/// [CatsHistoryBloc] is a business logic component
/// that is responsible for managing the history of facts about cats.
/// {@endtemplate}
final class CatsHistoryBloc extends Bloc<CatsHistoryEvent, CatsHistoryState> {
  /// {@macro cats_history_bloc}
  CatsHistoryBloc(this._repository)
      : super(
          const CatsHistoryState.idle(),
        ) {
    on<CatsHistoryEvent>(
      (event, emit) => event.map(
        load: (event) => _load(event, emit),
        add: (event) => _add(event, emit),
      ),
    );
  }

  final CatsHistoryRepository _repository;

  Future<void> _add(
    _CatsHistoryAdd event,
    Emitter<CatsHistoryState> emitter,
  ) async {
    try {
      final entity = await _repository.insert(
        event.fact,
        event.image,
      );
      emitter(
        CatsHistoryState.idle(
          history: [entity, ...state.history],
          reachedEnd: state.reachedEnd,
        ),
      );
    } on Object catch (e) {
      emitter(
        CatsHistoryState.idle(
          history: state.history,
          error: e.toString(),
        ),
      );
      rethrow;
    }
  }

  Future<void> _load(
    _CatsHistoryLoad event,
    Emitter<CatsHistoryState> emitter,
  ) async {
    try {
      if (state.reachedEnd) return;
      emitter(
        CatsHistoryState.inProgress(
          history: state.history,
          reachedEnd: state.reachedEnd,
        ),
      );
      final history = state.history;
      final newHistory = await _repository
          .loadCatsHistory(
            limit: event.limit,
            offset: history.length,
          )
          .toList();

      return emitter(
        CatsHistoryState.idle(
          history: [...history, ...newHistory],
          reachedEnd: newHistory.length < event.limit,
        ),
      );
    } on Object catch (e) {
      emitter(
        CatsHistoryState.idle(
          history: state.history,
          error: e.toString(),
        ),
      );
      rethrow;
    }
  }
}
