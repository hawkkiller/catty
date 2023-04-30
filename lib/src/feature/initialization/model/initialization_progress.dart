import 'package:catty/src/core/router/router.dart';
import 'package:catty/src/feature/facts/data/facts_data_source.dart';
import 'package:catty/src/feature/facts/data/facts_repository.dart';
import 'package:catty/src/feature/initialization/model/environment_store.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'initialization_progress.freezed.dart';

@freezed
class RepositoriesStore with _$RepositoriesStore {
  const factory RepositoriesStore({
    required FactsRepository factsRepository,
  }) = _RepositoriesStore;
}

@freezed
class DependenciesStore with _$DependenciesStore {
  const factory DependenciesStore({
    required SharedPreferences preferences,
    required AppRouter router,
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
  }) = _InitializationProgress;

  const InitializationProgress._();

  DependenciesStore dependencies() => DependenciesStore(
        preferences: preferences!,
        router: router!,
      );

  RepositoriesStore repositories() => RepositoriesStore(
    factsRepository: factsRepository!,
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
