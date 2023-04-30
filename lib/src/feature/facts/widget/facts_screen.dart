import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:catty/src/core/utils/extensions/context_extension.dart';
import 'package:catty/src/feature/facts/bloc/facts_bloc.dart';
import 'package:catty/src/feature/facts/localization/facts_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class FactsScreen extends StatelessWidget {
  const FactsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton.large(
          child: const Icon(Icons.generating_tokens),
          onPressed: () {
            context.read<FactsBloc>().add(
                  const FactsEvent.load(),
                );
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<FactsBloc, FactsState>(
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
                    child: state.isImageLoaded
                        ? CachedNetworkImage(
                            imageUrl: state.image!.url,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder: (context, url, progress) =>
                                const CircularProgressIndicator.adaptive(),
                          )
                        : const Center(
                            child: CircularProgressIndicator.adaptive(),
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
