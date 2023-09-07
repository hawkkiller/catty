import 'package:cached_network_image/cached_network_image.dart';
import 'package:catty/src/feature/cats/bloc/cats_bloc.dart';
import 'package:catty/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template cats_screen}
/// CatsScreen is a screen that displays random facts about cats
/// as well as random images of cats.
/// {@endtemplate}
class CatsScreen extends StatefulWidget {
  /// {@macro cats_screen}
  const CatsScreen({super.key});

  @override
  State<CatsScreen> createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
  late final CatsBloc _catsBloc;

  void _loadFacts() => _catsBloc.add(const CatsEvent.load());

  @override
  void initState() {
    _catsBloc = CatsBloc(
      catsRepository: DependenciesScope.of(context).catsRepository,
    );
    _loadFacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          onPressed: _loadFacts,
          child: const Icon(Icons.generating_tokens),
        ),
        body: BlocBuilder<CatsBloc, CatsState>(
          bloc: _catsBloc,
          builder: (context, state) {
            final image = state.image;
            final fact = state.fact;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  title: Text(
                    'Catty',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                if (image != null)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 200,
                      child: CachedNetworkImage(
                        cacheKey: image.id,
                        width: image.width,
                        height: image.height,
                        imageUrl: image.url,
                      ),
                    ),
                  ),
                if (fact != null)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: Text(
                          fact,
                          style: Theme.of(context).textTheme.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      );
}
