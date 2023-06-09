import 'package:catty/src/core/localization/localization_delegate.dart';
import 'package:catty/src/feature/facts/localization/facts_localization_delegate.dart';
import 'package:catty/src/feature/facts_history/localization/facts_history_localization_delegate.dart';
import 'package:catty/src/feature/feed/localization/feed_localization_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/generated_localizations.dart';

typedef GeneratedLocalization = GeneratedLocalizations;

/// A class which is responsible for providing the localization.
///
/// [AppLocalization] is a wrapper around [GeneratedLocalizations].
class AppLocalization {
  AppLocalization._();

  /// All the supported locales
  ///
  /// SSOT - arb files
  static const supportedLocales = GeneratedLocalizations.supportedLocales;

  /// All the localizations delegates
  static final localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    ...GeneratedLocalizations.localizationsDelegates,
    ...featureDelegates,
  ];

  /// Feature localization delegates
  static final featureDelegates = <LocalizationDelegate<Object>>[
    FeedLocalizationDelegate(),
    FactsLocalizationDelegate(),
    FactsHistoryLocalizationDelegate(),
  ];

  /// Returns the localized strings for the given [context].
  static T stringOf<T>(BuildContext context) => Localizations.of<T>(context, T)!;

  /// Returns the current locale of the [context].
  static Locale? localeOf(BuildContext context) => Localizations.localeOf(context);

  /// Loads the [locale].
  static Future<GeneratedLocalizations> load(Locale locale) =>
      GeneratedLocalizations.delegate.load(locale);
}
