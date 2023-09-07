import 'dart:async';

import 'package:async/async.dart';
import 'package:catty/src/core/utils/pattern_match.dart';
import 'package:catty/src/feature/cats/data/cats_repository.dart';
import 'package:catty/src/feature/cats/model/cat_image_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

/// Cats state
@immutable
sealed class CatsState extends _CatsStateBase {
  const CatsState._();

  /// Idle state - state machine isn't doing anything
  const factory CatsState.idle({
    CatImageDto? image,
    String? fact,
    String? error,
    bool finished,
  }) = _CatsStateIdle;

  /// In progress state - state machine is doing something
  const factory CatsState.inProgress({
    CatImageDto? image,
    String? fact,
  }) = _CatsStateInProgress;
}

final class _CatsStateIdle extends CatsState {
  const _CatsStateIdle({
    this.fact,
    this.image,
    this.error,
    this.finished = false,
  }) : super._();

  @override
  final CatImageDto? image;

  @override
  final String? fact;

  @override
  final String? error;

  final bool finished;

  @override
  String toString() => 'CatsState.idle(fact: $fact, image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _CatsStateIdle &&
        other.image == image &&
        other.fact == fact;
  }

  @override
  int get hashCode => image.hashCode ^ fact.hashCode;
}

final class _CatsStateInProgress extends CatsState {
  const _CatsStateInProgress({
    this.fact,
    this.image,
  }) : super._();

  @override
  final CatImageDto? image;

  @override
  final String? fact;

  @override
  String? get error => null;

  @override
  String toString() => 'CatsState.inProgress(fact: $fact, image: $image)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _CatsStateInProgress &&
        other.image == image &&
        other.fact == fact;
  }

  @override
  int get hashCode => image.hashCode ^ fact.hashCode;
}

abstract base class _CatsStateBase {
  const _CatsStateBase();

  abstract final CatImageDto? image;

  abstract final String? fact;

  abstract final String? error;

  bool get isInProgress => maybeMap(
        inProgress: (_) => true,
        orElse: () => false,
      );

  bool get isFinished => maybeMap(
        idle: (state) => state.finished,
        orElse: () => false,
      );

  T maybeMap<T>({
    required T Function() orElse,
    PatternMatch<T, _CatsStateIdle>? idle,
    PatternMatch<T, _CatsStateInProgress>? inProgress,
  }) =>
      map(
        idle: idle ?? (_) => orElse(),
        inProgress: inProgress ?? (_) => orElse(),
      );

  T map<T>({
    required PatternMatch<T, _CatsStateIdle> idle,
    required PatternMatch<T, _CatsStateInProgress> inProgress,
  }) =>
      switch (this) {
        final _CatsStateIdle state => idle(state),
        final _CatsStateInProgress state => inProgress(state),
        _ => throw Exception('Wrong state: $this')
      };
}

/// Cats event
sealed class CatsEvent extends _CatsEventBase {
  const CatsEvent._();

  /// Load cats
  const factory CatsEvent.load() = _CatsEventLoad;
}

final class _CatsEventLoad extends CatsEvent {
  const _CatsEventLoad() : super._();

  @override
  String toString() => 'CatsEvent.load()';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _CatsEventLoad;
  }

  @override
  int get hashCode => 0;
}

abstract base class _CatsEventBase {
  const _CatsEventBase();

  T maybeMap<T>({
    required T Function() orElse,
    PatternMatch<T, _CatsEventLoad>? load,
  }) =>
      map(
        load: load ?? (_) => orElse(),
      );

  T map<T>({
    required PatternMatch<T, _CatsEventLoad> load,
  }) =>
      switch (this) {
        final _CatsEventLoad event => load(event),
        _ => throw Exception('Wrong event: $this')
      };
}

/// {@template cats_bloc}
/// [CatsBloc] is a BLoC that manages cats state
///
/// It communicates with [CatsRepository] to get cats data
/// {@endtemplate}
final class CatsBloc extends Bloc<CatsEvent, CatsState> {
  /// {@macro cats_bloc}
  CatsBloc({
    required CatsRepository catsRepository,
  })  : _catsRepository = catsRepository,
        super(const CatsState.idle()) {
    on<CatsEvent>(
      (event, emitter) => event.map(
        load: (e) => _onLoad(e, emitter),
      ),
    );
  }

  final CatsRepository _catsRepository;

  Future<void> _onLoad(
    _CatsEventLoad event,
    Emitter<CatsState> emitter,
  ) async {
    try {
      emitter(const CatsState.inProgress());

      final fact = _catsRepository.getFact();
      final image = _catsRepository.loadRandomImage(limit: 1);

      final iterator = StreamIterator(
        StreamGroup.merge([fact, image]),
      );

      String completion = '';

      while (await iterator.moveNext()) {
        final current = iterator.current;

        if (current is CatImageDto) {
          emitter(
            CatsState.inProgress(
              fact: completion,
              image: current,
            ),
          );
          continue;
        }

        if (current is String) {
          completion += current;
          emitter(
            CatsState.inProgress(
              fact: completion,
              image: state.image,
            ),
          );
          continue;
        }
      }
    } on Object catch (error, stackTrace) {
      emitter(
        CatsState.idle(
          fact: state.fact,
          image: state.image,
          error: error.toString(),
        ),
      );
      // I do this because I want this error to be in [BlocObserver]
      // but if I rethrow the inner code of BLoC will rethrow this error.
      onError(error, stackTrace);
    } finally {
      emitter(
        CatsState.idle(
          fact: state.fact,
          image: state.image,
          error: state.error,
          finished: true,
        ),
      );
    }
  }
}
