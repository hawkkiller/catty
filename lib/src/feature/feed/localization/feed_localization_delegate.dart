import 'package:catty/src/core/localization/app_localization.dart';
import 'package:catty/src/core/localization/localization_delegate.dart';

abstract class FeedStrings {
  String get catFacts;
  String get history;
}

class FeedLocalizationDelegate extends LocalizationDelegate<FeedStrings> {
  FeedLocalizationDelegate() : super(_FeedStringsImpl.new);
}

class _FeedStringsImpl implements FeedStrings {
  const _FeedStringsImpl(this.localization);

  final GeneratedLocalization localization;

  @override
  String get catFacts => localization.cat_facts;

  @override
  String get history => localization.history;
}
