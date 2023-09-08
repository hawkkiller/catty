import 'dart:async';

import 'package:drift/drift.dart';

/// {@template db_executor}
/// Create a new executor for the given database name.
/// {@endtemplate}
FutureOr<QueryExecutor> createExecutor(String name) => throw UnsupportedError(
      'Platform is not recognised as supported one',
    );
