import 'package:catty/src/core/utils/extensions/string_extension.dart';
import 'package:catty/src/core/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// [BlocObserver] which logs all bloc state changes, errors and events.
class AppBlocObserver extends BlocObserver {
  @override
  void onTransition(
    Bloc<Object?, Object?> bloc,
    Transition<Object?, Object?> transition,
  ) {
    final buffer = StringBuffer()
      ..writeln('Bloc: ${bloc.runtimeType} | ${transition.event.runtimeType}')
      ..write('Transition: ${transition.currentState.runtimeType}')
      ..writeln(' -> ${transition.nextState.runtimeType}')
      ..writeln('New State: ${transition.nextState.toString().limit(100)}');
    logger.info(buffer.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc<Object?, Object?> bloc, Object? event) {
    final buffer = StringBuffer()
      ..writeln('Bloc: ${bloc.runtimeType} | ${event.runtimeType}')
      ..writeln('Event: ${event.toString().limit(100)}');
    logger.info(buffer.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onError(
    BlocBase<Object?> bloc,
    Object error,
    StackTrace stackTrace,
  ) {
    logger.error(
      'Bloc: ${bloc.runtimeType}',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
