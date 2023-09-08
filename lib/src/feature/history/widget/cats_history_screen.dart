import 'package:cached_network_image/cached_network_image.dart';
import 'package:catty/src/core/localization/localization.dart';
import 'package:catty/src/feature/history/widget/cats_history_scope.dart';
import 'package:flutter/material.dart';

/// {@template history_screen}
/// [CatsHistoryScreen] is a screen that displays the history
/// of facts about cats.
/// {@endtemplate}
class CatsHistoryScreen extends StatefulWidget {
  /// {@macro history_screen}
  const CatsHistoryScreen({super.key});

  @override
  State<CatsHistoryScreen> createState() => _CatsHistoryScreenState();
}

class _CatsHistoryScreenState extends State<CatsHistoryScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        final position = _scrollController.position;
        final scope = CatsHistoryScope.of(context, listen: false);
        if (position.pixels > position.maxScrollExtent / 1.5 &&
            !scope.isInProgress && !scope.reachedEnd) {
          scope.loadMore();
        }
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              title: Text(
                Localization.of(context).history,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              backgroundColor: Theme.of(context).colorScheme.surface,
              pinned: true,
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = CatsHistoryScope.of(context).history[index];
                    return Padding(
                      key: ValueKey(item.link),
                      padding: const EdgeInsets.only(top: 16),
                      child: ListTile(
                        subtitle: Text(
                          item.createdAt.toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        tileColor:
                            Theme.of(context).colorScheme.secondaryContainer,
                        title: Text(
                          item.fact,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                  ),
                        ),
                        leading: CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: 50,
                          imageUrl: item.link,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator.adaptive(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    );
                  },
                  childCount: CatsHistoryScope.of(context).history.length,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Visibility(
                    visible: CatsHistoryScope.of(context).isInProgress,
                    child: const CircularProgressIndicator.adaptive(),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
