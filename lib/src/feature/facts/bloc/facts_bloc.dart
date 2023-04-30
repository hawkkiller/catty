import 'package:catty/src/feature/facts/data/facts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'facts_bloc.freezed.dart';

@freezed
class FactsState with _$FactsState {
  const FactsState._();

  const factory FactsState.idle(String fact) = _FactsStateIdle;

  // TODO(mlazebny): add image
  const factory FactsState.inProgress(String fact) = _FactsStateInProgress;

  const factory FactsState.success(String fact) = _FactsStateSuccess;

}

@freezed
class FactsEvent with _$FactsEvent {
  const FactsEvent._();

  const factory FactsEvent.load() = _FactsEventLoad;
}

class FactsBloc extends Bloc<FactsEvent, FactsState> {
  FactsBloc(this._factsRepository) : super(const FactsState.idle('')) {
    on<FactsEvent>(
      (event, emitter) => event.map(
        load: (e) => _onLoad(e, emitter),
      ),
    );
  }

  final FactsRepository _factsRepository;

  Future<void> _onLoad(_FactsEventLoad event, Emitter<FactsState> emit) async {
    try {
      emit(const FactsState.inProgress(''));
      final factCompletion = _factsRepository.getFact();
      final completion = <String>[];
      await for (final factPart in factCompletion) {
        completion.add(factPart);
        emit(FactsState.inProgress(completion.join()));
      }
      emit(FactsState.success(completion.join()));
    } on Object catch (e) {
      // emit(FactsState.idle());
      rethrow;
    }
  }
}
