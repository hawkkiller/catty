import 'dart:async';

import 'package:catty/src/feature/facts/model/cat_image_entity.dart';
import 'package:catty/src/feature/facts_history/data/facts_history_repository.dart';
import 'package:catty/src/feature/facts_history/model/cats_history_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'facts_history_bloc.freezed.dart';

@freezed
class FactsHistoryState with _$FactsHistoryState {
  const factory FactsHistoryState.idle({
    @Default(<CatsHistoryEntity>[]) List<CatsHistoryEntity> factsHistory,
  }) = _FactsHistoryStateIdle;

  const factory FactsHistoryState.loading({
    required List<CatsHistoryEntity> factsHistory,
  }) = _FactsHistoryStateLoading;

  const factory FactsHistoryState.inserting({
    required List<CatsHistoryEntity> factsHistory,
    required String fact,
    required CatImageEntity image,
  }) = _FactsHistoryStateInserting;

  const factory FactsHistoryState.inserted({
    required List<CatsHistoryEntity> factsHistory,
    required String fact,
    required CatImageEntity image,
  }) = _FactsHistoryStateInserted;

  const factory FactsHistoryState.loaded({
    required List<CatsHistoryEntity> factsHistory,
  }) = _FactsHistoryStateLoaded;

  const factory FactsHistoryState.failure({
    @Default(<CatsHistoryEntity>[]) List<CatsHistoryEntity> factsHistory,
  }) = _FactsHistoryStateFailure;

  const FactsHistoryState._();

  bool get isFailure => maybeMap(
        failure: (_) => true,
        orElse: () => false,
      );

  bool get isLoading => maybeMap(
        loading: (_) => true,
        orElse: () => false,
      );

  bool get isIdle => maybeMap(
        idle: (_) => true,
        orElse: () => false,
      );
}

@freezed
class FactsHistoryEvent with _$FactsHistoryEvent {
  const factory FactsHistoryEvent.insert({
    required String fact,
    required CatImageEntity image,
  }) = _FactsHistoryEventInsert;

  const factory FactsHistoryEvent.load() = _FactsHistoryEventLoad;
}

class FactsHistoryBloc extends Bloc<FactsHistoryEvent, FactsHistoryState> {
  FactsHistoryBloc(this._repository)
      : super(
          const FactsHistoryState.idle(),
        ) {
    on<FactsHistoryEvent>(
      (event, emit) => event.map(
        insert: (event) => _insert(event, emit),
        load: (event) => _load(event, emit),
      ),
    );
  }

  final FactsHistoryRepository _repository;

  Future<void> _load(_FactsHistoryEventLoad event, Emitter<FactsHistoryState> emitter) async {
    try {
      final history = await _repository.getAllCatsHistory();
      return emitter(
        FactsHistoryState.loaded(
          factsHistory: history,
        ),
      );
    } on Object catch (_) {
      emitter(
        FactsHistoryState.failure(
          factsHistory: state.factsHistory,
        ),
      );
      rethrow;
    }
  }

  Future<void> _insert(_FactsHistoryEventInsert event, Emitter<FactsHistoryState> emitter) async {
    try {
      emitter(
        FactsHistoryState.inserting(
          factsHistory: state.factsHistory,
          fact: event.fact,
          image: event.image,
        ),
      );
      await _repository.insert(event.fact, event.image);
      final newHistory = List.of(
        [
          CatsHistoryEntity(
            fact: event.fact,
            link: event.image.url,
            createdAt: DateTime.now(),
          ),
          ...state.factsHistory,
        ],
      );
      emitter(
        FactsHistoryState.inserted(
          factsHistory: newHistory,
          fact: event.fact,
          image: event.image,
        ),
      );
    } on Object catch (_) {
      emitter(
        FactsHistoryState.failure(
          factsHistory: state.factsHistory,
        ),
      );
      rethrow;
    }
  }
}
