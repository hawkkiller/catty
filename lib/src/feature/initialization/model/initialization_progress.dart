import 'package:catty/src/core/database/catty_database.dart';
import 'package:catty/src/core/router/router.dart';
import 'package:catty/src/feature/facts/data/facts_repository.dart';
import 'package:catty/src/feature/facts_history/data/facts_history_repository.dart';
import 'package:catty/src/feature/initialization/model/environment_store.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'initialization_progress.freezed.dart';

@freezed
class RepositoriesStore with _$RepositoriesStore {
  const factory RepositoriesStore({
    required FactsRepository factsRepository,
    required FactsHistoryRepository factsHistoryRepository
  }) = _RepositoriesStore;
}

@freezed
class DependenciesStore with _$DependenciesStore {
  const factory DependenciesStore({
    required SharedPreferences preferences,
    required AppRouter router,
    required CattyDatabase database,
  }) = _DependenciesStore;

  const DependenciesStore._();
}

@freezed
class InitializationProgress with _$InitializationProgress {
  const factory InitializationProgress({
    required IEnvironmentStore environment,
    SharedPreferences? preferences,
    AppRouter? router,
    FactsRepository? factsRepository,
    CattyDatabase? database,
    FactsHistoryRepository? factsHistoryRepository,
  }) = _InitializationProgress;

  const InitializationProgress._();

  DependenciesStore dependencies() => DependenciesStore(
        preferences: preferences!,
        router: router!,
        database: database!,
      );

  RepositoriesStore repositories() => RepositoriesStore(
        factsRepository: factsRepository!,
        factsHistoryRepository: factsHistoryRepository!,
      );
}

@freezed
class InitializationResult with _$InitializationResult {
  const factory InitializationResult({
    required DependenciesStore dependencies,
    required RepositoriesStore repositories,
    required int stepCount,
    required int msSpent,
  }) = _InitializationResult;
}
