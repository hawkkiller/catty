import 'package:catty/src/core/localization/app_localization.dart';
import 'package:catty/src/core/localization/localization_delegate.dart';

abstract class FactsHistoryStrings {
  String get history;
  String get description;
}

class FactsHistoryLocalizationDelegate extends LocalizationDelegate<FactsHistoryStrings> {
  FactsHistoryLocalizationDelegate() : super(_FactsStringsImpl.new);
}

class _FactsStringsImpl implements FactsHistoryStrings {
  const _FactsStringsImpl(this.localization);

  final GeneratedLocalization localization;

  @override
  String get history => localization.history;

  @override
  String get description => localization.history_description;
}
