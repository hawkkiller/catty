import 'package:catty/src/core/localization/app_localization.dart';
import 'package:catty/src/core/localization/localization_delegate.dart';

abstract class FactsStrings {
  String get exploreFacts;

  String get description;

  String get generateFact;
}

class FactsLocalizationDelegate extends LocalizationDelegate<FactsStrings> {
  FactsLocalizationDelegate() : super(_FactsStringsImpl.new);
}

class _FactsStringsImpl implements FactsStrings {
  const _FactsStringsImpl(this.localization);

  final GeneratedLocalization localization;

  @override
  String get exploreFacts => localization.explore_facts;

  @override
  String get description => localization.explore_facts_description;

  @override
  String get generateFact => localization.generate_fact;
}
