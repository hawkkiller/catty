import 'package:catty/src/core/widget/scope_widgets.dart';
import 'package:catty/src/feature/app/widget/app_context.dart';
import 'package:catty/src/feature/facts/bloc/facts_bloc.dart';
import 'package:catty/src/feature/initialization/model/initialization_progress.dart';
import 'package:catty/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// A widget which is responsible for running the app.
class App extends StatelessWidget {
  const App({
    required this.result,
    super.key,
  });

  void run() => runApp(this);

  final InitializationResult result;

  @override
  Widget build(BuildContext context) => DefaultAssetBundle(
        bundle: SentryAssetBundle(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => FactsBloc(result.repositories.factsRepository)
                ..add(
                  const FactsEvent.load(),
                ),
            ),
          ],
          child: ScopeProvider(
            buildScope: (child) => DependenciesScope(
              dependencies: result.dependencies,
              repositories: result.repositories,
              child: child,
            ),
            child: const AppContext(),
          ),
        ),
      );
}
