import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:catty/src/core/utils/extensions/context_extension.dart';
import 'package:catty/src/feature/facts/bloc/facts_bloc.dart';
import 'package:catty/src/feature/facts/localization/facts_localization_delegate.dart';
import 'package:catty/src/feature/facts_history/bloc/facts_history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FactsScreen extends StatefulWidget {
  const FactsScreen({super.key});

  @override
  State<FactsScreen> createState() => _FactsScreenState();
}

class _FactsScreenState extends State<FactsScreen> {
  void _loadFacts() {
    context.read<FactsBloc>().add(
          const FactsEvent.load(),
        );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton.large(
          onPressed: _loadFacts,
          child: const Icon(Icons.generating_tokens),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocConsumer<FactsBloc, FactsState>(
          listener: (context, state) {
            state.maybeMap(
              orElse: () {},
              success: (value) {
                context.read<FactsHistoryBloc>().add(
                      FactsHistoryEvent.insert(
                        fact: value.fact,
                        image: value.image,
                      ),
                    );
              },
            );
          },
          builder: (context, state) => Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  context.stringOf<FactsStrings>().exploreFacts,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  context.stringOf<FactsStrings>().description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: SizedBox(
                    height: 324,
                    width: double.infinity,
                    child: state.maybeMap(
                      orElse: () {
                        if (state.isImageLoaded) {
                          return CachedNetworkImage(
                            imageUrl: state.image!.url,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, progress) =>
                                const CircularProgressIndicator.adaptive(),
                          );
                        }
                        if (state.inProgress) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      failure: (f) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: context.stringOf<FactsStrings>().error,
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Icon(
                                      Icons.error,
                                      color: Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                          IconButton(
                            onPressed: _loadFacts,
                            icon: const Icon(Icons.refresh),
                            tooltip: context.stringOf<FactsStrings>().clickToRetry,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    state.fact,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
