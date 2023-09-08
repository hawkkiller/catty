import 'dart:async';
import 'dart:ui';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:catty/src/core/bloc/app_bloc_observer.dart';
import 'package:catty/src/core/utils/logger.dart';
import 'package:catty/src/feature/app/widget/app.dart';
import 'package:catty/src/feature/initialization/logic/initialization_processor.dart';
import 'package:catty/src/feature/initialization/logic/initialization_steps.dart';
import 'package:catty/src/feature/initialization/model/initialization_hook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A class which is responsible for initialization and running the app.
final class AppRunner
    with
        InitializationSteps,
        InitializationProcessor,
        InitializationFactoryImpl {
  /// Start the initialization and in case of success run application
  Future<void> initializeAndRun(InitializationHook hook) async {
    final bindings = WidgetsFlutterBinding.ensureInitialized()
      ..deferFirstFrame();

    FlutterError.onError = logger.logFlutterError;
    PlatformDispatcher.instance.onError = logger.logPlatformDispatcherError;
    Bloc.observer = AppBlocObserver();
    Bloc.transformer = bloc_concurrency.sequential();

    final result = await processInitialization(
      steps: initializationSteps,
      hook: hook,
      factory: this,
    );

    bindings.allowFirstFrame();

    // Attach this widget to the root of the tree.
    App(result: result).attach();
  }
}
