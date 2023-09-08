import 'dart:async';

import 'package:catty/src/feature/app/data/locale_datasource.dart';
import 'package:catty/src/feature/app/data/locale_repository.dart';
import 'package:catty/src/feature/app/data/theme_datasource.dart';
import 'package:catty/src/feature/app/data/theme_repository.dart';
import 'package:catty/src/feature/cats/data/cat_facts_data_source.dart';
import 'package:catty/src/feature/cats/data/cat_images_data_source.dart';
import 'package:catty/src/feature/cats/data/cats_repository.dart';
import 'package:catty/src/feature/history/data/cats_history_data_source.dart';
import 'package:catty/src/feature/history/data/cats_history_repository.dart';
import 'package:catty/src/feature/initialization/model/dependencies.dart';
import 'package:catty/src/feature/initialization/model/initialization_progress.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A function which represents a single initialization step.
typedef StepAction = FutureOr<void>? Function(InitializationProgress progress);

/// The initialization steps, which are executed in the order they are defined.
///
/// The [Dependencies] object is passed to each step, which allows the step to
/// set the dependency, and the next step to use it.
mixin InitializationSteps {
  /// The initialization steps,
  /// which are executed in the order they are defined.
  final initializationSteps = <String, StepAction>{
    'Shared Preferences': (progress) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      progress.dependencies.sharedPreferences = sharedPreferences;
    },
    'Theme Repository': (progress) {
      final sharedPreferences = progress.dependencies.sharedPreferences;
      final themeDataSource = ThemeDataSourceImpl(sharedPreferences);
      progress.dependencies.themeRepository = ThemeRepositoryImpl(
        themeDataSource,
      );
    },
    'Locale Repository': (progress) {
      final sharedPreferences = progress.dependencies.sharedPreferences;
      final localeDataSource = LocaleDataSourceImpl(
        sharedPreferences: sharedPreferences,
      );
      progress.dependencies.localeRepository = LocaleRepositoryImpl(
        localeDataSource,
      );
    },
    'CatsRepository': (progress) {
      OpenAI.apiKey = progress.environmentStore.openAiApiKey;
      final factsDataSource = CatFactsDataSourceGPT();

      final catImagesDataSource = CatImagesDataSourceTheCatApi();

      progress.dependencies.catsRepository = CatsRepositoryImpl(
        factsDataSource: factsDataSource,
        catImagesDataSource: catImagesDataSource,
      );
    },
    'CatsHistoryRepository': (progress) async {
      final database = await createExecutor('cats_history.db');

      final catsHistoryDataSource = CatsHistoryDataSourceDrift(
        AppDatabase(database),
      );

      progress.dependencies.catsHistoryRepository = CatsHistoryRepositoryImpl(
        catsHistoryDataSource,
      );
    },
  };
}
