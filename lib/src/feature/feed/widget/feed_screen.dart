import 'package:auto_route/auto_route.dart';
import 'package:catty/src/core/router/router.dart';
import 'package:catty/src/core/utils/extensions/context_extension.dart';
import 'package:catty/src/feature/feed/localization/feed_localization_delegate.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) => AutoTabsScaffold(
        routes: const [
          FactsRoute(),
          HistoryRoute(),
        ],
        bottomNavigationBuilder: (_, tabsRouter) => NavigationBar(
          onDestinationSelected: tabsRouter.setActiveIndex,
          selectedIndex: tabsRouter.activeIndex,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.explore),
              label: context.stringOf<FeedStrings>().catFacts,
            ),
            NavigationDestination(
              icon: const Icon(Icons.history),
              label: context.stringOf<FeedStrings>().history,
            ),
          ],
        ),
      );
}
