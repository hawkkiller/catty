import 'package:auto_route/auto_route.dart';
import 'package:catty/src/feature/facts_history/widget/history_screen.dart';
import 'package:catty/src/feature/facts/widget/facts_screen.dart';
import 'package:catty/src/feature/feed/widget/feed_screen.dart';

part 'router.gr.dart';

/// The configuration of app routes.
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: FeedRoute.page,
          path: '/',
          initial: true,
          children: [
            AutoRoute(
              page: FactsRoute.page,
              path: 'facts',
              initial: true,
            ),
            AutoRoute(
              page: HistoryRoute.page,
              path: 'history',
            )
          ],
        ),
      ];
}
