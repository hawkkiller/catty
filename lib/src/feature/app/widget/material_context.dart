import 'package:catty/src/core/localization/localization.dart';
import 'package:catty/src/core/router/routes.dart';
import 'package:catty/src/feature/app/widget/locale_scope.dart';
import 'package:catty/src/feature/app/widget/theme_scope.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// {@template material_context}
/// [MaterialContext] is an entry point to the material context.
///
/// This widget sets locales, themes and routing.
/// {@endtemplate}
class MaterialContext extends StatefulWidget {
  /// {@macro material_context}
  const MaterialContext({super.key});

  @override
  State<MaterialContext> createState() => _MaterialContextState();
}

class _MaterialContextState extends State<MaterialContext> {
  late final RouterConfig<Object> config;

  @override
  void initState() {
    config = GoRouter(routes: $appRoutes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeScope.of(context).theme;

    return MaterialApp.router(
      routerConfig: config,
      debugShowCheckedModeBanner: false,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.themeMode,
      localizationsDelegates: Localization.localizationDelegates,
      supportedLocales: Localization.supportedLocales,
      locale: LocaleScope.of(context).locale,
    );
  }
}
