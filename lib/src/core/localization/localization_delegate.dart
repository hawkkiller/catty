import 'package:catty/src/core/localization/app_localization.dart';
import 'package:flutter/material.dart';

abstract class LocalizationDelegate<T> extends LocalizationsDelegate<T> {
  LocalizationDelegate(this._delegateFactory);

  final T Function(GeneratedLocalization appLocalizations) _delegateFactory;

  @override
  Future<T> load(Locale locale) async {
    final appLocalizations = await GeneratedLocalization.delegate.load(locale);
    return _delegateFactory(appLocalizations);
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<T> old) => old != this;

  @override
  bool isSupported(Locale locale) => GeneratedLocalization.delegate.isSupported(locale);
}
