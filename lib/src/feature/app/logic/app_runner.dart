import 'dart:ui';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:catty/src/core/utils/logger.dart';
import 'package:catty/src/feature/app/widget/app.dart';
import 'package:catty/src/feature/initialization/logic/initialization_processor.dart';
import 'package:catty/src/feature/initialization/logic/initialization_steps.dart';
import 'package:catty/src/feature/initialization/model/initialization_hook.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A class which is responsible for initialization and running the app.
class AppRunner with InitializationSteps, InitializationProcessor, InitializationFactoryImpl {
  /// run initialization
  ///
  /// if success -> run app
  Future<void> initializeAndRun(InitializationHook hook) async {
    final bindings = WidgetsFlutterBinding.ensureInitialized()..deferFirstFrame();
    FlutterError.onError = Logger.logFlutterError;
    PlatformDispatcher.instance.onError = Logger.logPlatformDispatcherError;
    Bloc.transformer = sequential();

    final result = await processInitialization(
      steps: initializationSteps,
      hook: hook,
      factory: this,
    );
    bindings.addPostFrameCallback((_) {
      bindings.allowFirstFrame();
    });
    // Run application
    App(result: result).run();
  }
}
