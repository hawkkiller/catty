import 'package:catty/src/feature/initialization/model/enum/environment.dart';
import 'package:pure/pure.dart';

abstract class IEnvironmentStore {
  abstract final Environment environment;
  abstract final String sentryDsn;
  abstract final String openaiKey;

  bool get isProduction => environment == Environment.prod;
}

class EnvironmentStore extends IEnvironmentStore {
  EnvironmentStore();

  @override
  Environment get environment =>
      const String.fromEnvironment('env').pipe(Environment.fromEnvironment);

  @override
  String get sentryDsn => const String.fromEnvironment('sentry_dsn');

  @override
  String get openaiKey => const String.fromEnvironment('openai_key');
}
