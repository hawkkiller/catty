import 'package:catty/src/core/database/connection/open_connection_stub.dart'
    if (dart.library.io) 'package:catty/src/core/database/connection/open_connection_io.dart'
    if (dart.library.html) 'package:catty/src/core/database/connection/open_connection_html.dart'
    as connection;
import 'package:drift/drift.dart';

part 'catty_database.g.dart';

@DriftDatabase(
  include: {'tables/cats_history.drift'},
)
class CattyDatabase extends _$CattyDatabase {
  CattyDatabase({required String name}) : super(connection.openConnection(name));

  @override
  int get schemaVersion => 1;
}
