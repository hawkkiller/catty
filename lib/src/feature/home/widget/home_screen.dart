import 'package:catty/src/core/localization/localization.dart';
import 'package:catty/src/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// {@template sample_page}
/// SamplePage widget
/// {@endtemplate}
class HomeScreen extends StatefulWidget {
  /// {@macro sample_page}
  const HomeScreen({
    required this.child,
    super.key,
  });

  /// Child to render inside the page
  final Widget child;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    return Scaffold(
        body: widget.child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: switch (location) {
            '/' => 0,
            '/history' => 1,
            _ => throw Exception(
                'Invalid uri: ${GoRouterState.of(context).uri}',
              ),
          },
          onDestinationSelected: (index) => switch (index) {
            0 => const CatsRoute().go(context),
            1 => const HistoryRoute().go(context),
            _ => throw Exception('Invalid index: $index'),
          },
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.explore),
              label: Localization.of(context).cat_facts,
            ),
            NavigationDestination(
              icon: const Icon(Icons.history),
              label: Localization.of(context).history,
            ),
          ],
        ),
      );
  }
}
