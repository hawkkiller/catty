import 'package:catty/src/feature/facts/data/facts_data_source.dart';

abstract class FactsRepository {
  Stream<String> getFact();
}

class FactsRepositoryImpl implements FactsRepository {
  FactsRepositoryImpl(this._factsDataSource);

  final FactsDataSource _factsDataSource;

  @override
  Stream<String> getFact() => _factsDataSource.getFact();
}
