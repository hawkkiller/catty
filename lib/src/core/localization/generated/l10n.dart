// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class GeneratedLocalization {
  GeneratedLocalization();

  static GeneratedLocalization? _current;

  static GeneratedLocalization get current {
    assert(_current != null,
        'No instance of GeneratedLocalization was loaded. Try to initialize the GeneratedLocalization delegate before accessing GeneratedLocalization.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<GeneratedLocalization> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = GeneratedLocalization();
      GeneratedLocalization._current = instance;

      return instance;
    });
  }

  static GeneratedLocalization of(BuildContext context) {
    final instance = GeneratedLocalization.maybeOf(context);
    assert(instance != null,
        'No instance of GeneratedLocalization present in the widget tree. Did you add GeneratedLocalization.delegate in localizationsDelegates?');
    return instance!;
  }

  static GeneratedLocalization? maybeOf(BuildContext context) {
    return Localizations.of<GeneratedLocalization>(
        context, GeneratedLocalization);
  }

  /// `Cat Facts`
  String get cat_facts {
    return Intl.message(
      'Cat Facts',
      name: 'cat_facts',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Explore Facts`
  String get explore_facts {
    return Intl.message(
      'Explore Facts',
      name: 'explore_facts',
      desc: '',
      args: [],
    );
  }

  /// `Press the floating button to generate a random cat fact`
  String get explore_facts_description {
    return Intl.message(
      'Press the floating button to generate a random cat fact',
      name: 'explore_facts_description',
      desc: '',
      args: [],
    );
  }

  /// `Generate Fact!`
  String get generate_fact {
    return Intl.message(
      'Generate Fact!',
      name: 'generate_fact',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred`
  String get error {
    return Intl.message(
      'An unexpected error occurred',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Click to retry`
  String get click_to_retry {
    return Intl.message(
      'Click to retry',
      name: 'click_to_retry',
      desc: '',
      args: [],
    );
  }

  /// `Here you can see all the facts you have generated`
  String get history_description {
    return Intl.message(
      'Here you can see all the facts you have generated',
      name: 'history_description',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate
    extends LocalizationsDelegate<GeneratedLocalization> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<GeneratedLocalization> load(Locale locale) =>
      GeneratedLocalization.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
