import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:catty/src/core/utils/extensions/context_extension.dart';
import 'package:catty/src/feature/facts_history/bloc/facts_history_bloc.dart';
import 'package:catty/src/feature/facts_history/localization/facts_history_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<FactsHistoryBloc, FactsHistoryState>(
          builder: (context, state) => CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(
                  context.stringOf<FactsHistoryStrings>().history,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                backgroundColor: Theme.of(context).colorScheme.surface,
                pinned: true,
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        tileColor: Theme.of(context).colorScheme.secondaryContainer,
                        title: Text(
                          state.factsHistory[index].fact,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        leading: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: state.factsHistory[index].link,
                          placeholder: (context, url) => const CircularProgressIndicator.adaptive(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                    childCount: state.factsHistory.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
