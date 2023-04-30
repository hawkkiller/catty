import 'dart:async';

import 'package:async/async.dart';
import 'package:catty/src/feature/facts/data/facts_repository.dart';
import 'package:catty/src/feature/facts/model/cat_image_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'facts_bloc.freezed.dart';

@freezed
class FactsState with _$FactsState {
  const FactsState._();

  const factory FactsState.idle({
    @Default('') String fact,
  }) = _FactsStateIdle;

  // TODO(mlazebny): add image
  const factory FactsState.inProgress({
    required String fact,
    CatImageEntity? image,
  }) = _FactsStateInProgress;

  const factory FactsState.success({
    required String fact,
    required CatImageEntity image,
  }) = _FactsStateSuccess;

  bool get isImageLoaded => maybeMap(
        success: (_) => true,
        inProgress: (s) => s.image != null,
        orElse: () => false,
      );

  CatImageEntity? get image => maybeMap(
        success: (s) => s.image,
        orElse: () => null,
      );
}

@freezed
class FactsEvent with _$FactsEvent {
  const FactsEvent._();

  const factory FactsEvent.load() = _FactsEventLoad;
}

class FactsBloc extends Bloc<FactsEvent, FactsState> {
  FactsBloc(this._factsRepository) : super(const FactsState.idle()) {
    on<FactsEvent>(
      (event, emitter) => event.map(
        load: (e) => _onLoad(e, emitter),
      ),
    );
  }

  final FactsRepository _factsRepository;

  Future<void> _onLoad(_FactsEventLoad event, Emitter<FactsState> emit) async {
    try {
      emit(const FactsState.inProgress(fact: ''));
      final factCompletion = _factsRepository.getFact();
      final imageCompletion = _factsRepository.loadRandomImage(limit: 1);
      final merged = StreamGroup.merge([factCompletion, imageCompletion]);
      final completion = <String>[];
      await for (final event in merged) {
        if (event is String) {
          completion.add(event);
          emit(
            FactsState.inProgress(
              fact: completion.join(),
              image: state.image,
            ),
          );
        }
        if (event is CatImageEntity) {
          emit(
            FactsState.inProgress(
              fact: state.fact,
              image: event,
            ),
          );
        }
      }
      emit(
        FactsState.success(
          fact: completion.join(),
          image: state.image!,
        ),
      );
    } on Object catch (e) {
      // emit(FactsState.idle());
      rethrow;
    }
  }
}
