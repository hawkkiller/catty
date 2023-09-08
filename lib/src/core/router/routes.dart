// ignore_for_file: public_member_api_docs

import 'package:catty/src/feature/cats/widget/cats_screen.dart';
import 'package:catty/src/feature/history/widget/cats_history_screen.dart';
import 'package:catty/src/feature/home/widget/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedStatefulShellRoute<HomeRoute>(
  branches: [
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<CatsRoute>(path: '/'),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<HistoryRoute>(path: '/history'),
      ],
    ),
  ],
)
class HomeRoute extends StatefulShellRouteData {
  const HomeRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    Widget navigationShell,
  ) =>
      HomeScreen(child: navigationShell);
}

class CatsRoute extends GoRouteData {
  const CatsRoute();

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) =>
      const CatsScreen();
}

class HistoryRoute extends GoRouteData {
  const HistoryRoute();

  @override
  Widget build(
    BuildContext context,
    GoRouterState state,
  ) =>
      const CatsHistoryScreen();
}
