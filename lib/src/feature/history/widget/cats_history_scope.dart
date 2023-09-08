import 'package:catty/src/core/utils/mixin/scope_mixin.dart';
import 'package:catty/src/feature/cats/model/cat_image_dto.dart';
import 'package:catty/src/feature/history/bloc/cats_history_bloc.dart';
import 'package:catty/src/feature/history/model/cats_history_entity.dart';
import 'package:catty/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template cats_history_controller}
/// [CatsHistoryController] provides facilities to store and retrieve
/// [CatsHistoryEntity].
/// {@endtemplate}
abstract interface class CatsHistoryController {
  /// Save [fact] and [image] into database.
  void save(String fact, CatImageDto image);

  /// Load cats history.
  void loadMore();

  /// Load cats history.
  List<CatsHistoryEntity> get history;
}

/// {@template cats_history_scope}
/// [CatsHistoryScope] provides facilities to store and retrieve
/// [CatsHistoryEntity].
/// {@endtemplate}
class CatsHistoryScope extends StatefulWidget {
  /// {@macro cats_history_scope}
  const CatsHistoryScope({
    required this.child,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// Retrieve [CatsHistoryController] from [context].
  static CatsHistoryController of(
    BuildContext context, {
    bool listen = true,
  }) =>
      ScopeMixin.scopeOf<_CatsHistoryInherited>(context).controller;

  @override
  State<CatsHistoryScope> createState() => _CatsHistoryScopeState();
}

class _CatsHistoryScopeState extends State<CatsHistoryScope>
    implements CatsHistoryController {
  late final CatsHistoryBloc _catsHistoryBloc;

  late CatsHistoryState _catsHistoryState;

  @override
  void initState() {
    _catsHistoryBloc = CatsHistoryBloc(
      DependenciesScope.of(context).catsHistoryRepository,
    );
    _catsHistoryState = _catsHistoryBloc.state;
    _catsHistoryBloc.add(
      const CatsHistoryEvent.load(limit: 20),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CatsHistoryBloc, CatsHistoryState>(
        bloc: _catsHistoryBloc,
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          _catsHistoryState = state;
          return _CatsHistoryInherited(
            controller: this,
            state: _catsHistoryState,
            child: widget.child,
          );
        },
      );

  @override
  List<CatsHistoryEntity> get history => _catsHistoryState.history;

  @override
  void loadMore() => _catsHistoryBloc.add(
        const CatsHistoryEvent.load(limit: 20),
      );

  @override
  void save(String fact, CatImageDto image) => _catsHistoryBloc.add(
        CatsHistoryEvent.add(
          fact: fact,
          image: image,
        ),
      );
}

/// {@template cats_history_scope}
/// _CatsHistoryInherited widget
/// {@endtemplate}
class _CatsHistoryInherited extends InheritedWidget {
  /// {@macro cats_history_scope}
  const _CatsHistoryInherited({
    required super.child,
    required this.controller,
    required this.state,
  });

  final CatsHistoryState state;
  final CatsHistoryController controller;

  @override
  bool updateShouldNotify(_CatsHistoryInherited oldWidget) =>
      state != oldWidget.state;
}
