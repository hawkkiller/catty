import 'dart:async';

import 'package:catty/src/core/database/catty_database.dart';
import 'package:catty/src/core/router/router.dart';
import 'package:catty/src/feature/facts/data/cat_images_data_source.dart';
import 'package:catty/src/feature/facts/data/facts_data_source.dart';
import 'package:catty/src/feature/facts/data/facts_repository.dart';
import 'package:catty/src/feature/facts_history/data/facts_history_data_source.dart';
import 'package:catty/src/feature/facts_history/data/facts_history_repository.dart';
import 'package:catty/src/feature/initialization/model/initialization_progress.dart';
import 'package:dart_openai/openai.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef StepAction = FutureOr<InitializationProgress>? Function(
  InitializationProgress progress,
);
mixin InitializationSteps {
  final initializationSteps = <String, StepAction>{
    ..._dependencies,
    ..._data,
  };
  static final _dependencies = <String, StepAction>{
    'Init OpenAI': (progress) {
      OpenAI.apiKey = progress.environment.openaiKey;
      return progress;
    },
    'Init Shared Preferences': (progress) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      return progress.copyWith(
        preferences: sharedPreferences,
      );
    },
    'Init Router': (progress) {
      final router = AppRouter();
      return progress.copyWith(
        router: router,
      );
    },
    'Init Drift Database': (progress) {
      final cattyDatabase = CattyDatabase(name: 'catty');
      return progress.copyWith(
        database: cattyDatabase,
      );
    }
  };
  static final _data = <String, StepAction>{
    'Init Facts Repository': (progress) {
      final factsRepository = FactsRepositoryImpl(
        factsDataSource: FactsDataSourceGPT(),
        catImagesDataSource: CatImagesDataSourceTheCatApi(),
      );
      return progress.copyWith(
        factsRepository: factsRepository,
      );
    },
    'Init Facts History Repository': (progress) {
      final factsHistoryRepository = FactsHistoryRepositoryImpl(
        CatsHistoryDao(progress.database!),
      );
      return progress.copyWith(
        factsHistoryRepository: factsHistoryRepository,
      );
    },
  };
}
