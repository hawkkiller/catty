import 'package:catty/src/core/localization/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// {@template localization}
/// Localization class which is used to localize app.
/// This class provides handy methods and tools.
/// {@endtemplate}
final class Localization extends GeneratedLocalization {
  /// {@macro localization}
  Localization._({
    required this.locale,
  });

  /// {@macro localization}
  static const localizationDelegate = _LocalizationDelegate(
    AppLocalizationDelegate(),
  );

  /// List of supported locales.
  static List<Locale> get supportedLocales =>
      const AppLocalizationDelegate().supportedLocales;

  /// List of localization delegates.
  static List<LocalizationsDelegate<void>> get localizationDelegates => [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        Localization.localizationDelegate,
      ];

  /// {@macro localization}
  static Localization? get current => _current;

  /// {@macro localization}
  static Localization? _current;

  /// Locale which is currently used.
  final Locale locale;

  /// Obtain [Localization] instance from [BuildContext].
  static Localization of(BuildContext context) =>
      Localizations.of<Localization>(context, Localization) ??
      (throw ArgumentError('No Localization found in context'));
}

final class _LocalizationDelegate extends LocalizationsDelegate<Localization> {
  const _LocalizationDelegate(this._delegate);

  final AppLocalizationDelegate _delegate;

  @override
  bool isSupported(Locale locale) => _delegate.isSupported(locale);

  @override
  Future<Localization> load(Locale locale) =>
      GeneratedLocalization.load(locale).then(
        (value) => Localization._current = Localization._(locale: locale),
      );

  @override
  bool shouldReload(_LocalizationDelegate old) => false;
}
