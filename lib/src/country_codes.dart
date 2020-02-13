import 'dart:async';

import 'package:country_codes/src/codes.dart';
import 'package:country_codes/src/country_details.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CountryCodes {
  static const MethodChannel _channel = const MethodChannel('country_codes');
  static Locale _deviceLocale;

  static String _resolveLocale(Locale locale) {
    locale ??= _deviceLocale;
    assert(locale != null,
        'Locale cannot be null. If you didn\'t provide one, please make sure you call init before using Country Details');
    return locale.countryCode;
  }

  /// Inits the underlying plugin channel and fetch current's device locale to be ready
  /// to use synchronously when required.
  ///
  /// If you don't plan to provide a `locale`, you should call and await this
  /// by calling `await CountryCodes.init();` before accessing any other method.
  static Future<bool> init() async {
    final List<String> locale =
        List<String>.from(await _channel.invokeMethod('getLocale'));
    if (locale != null) {
      _deviceLocale = Locale(locale[0], locale[1]);
    }
    return _deviceLocale != null;
  }

  /// Returns the current device's `Locale`
  /// Eg. `Locale('en','US')`
  static Locale getDeviceLocale() {
    assert(_deviceLocale != null,
        'Please, make sure you call await init() before calling getDeviceLocale()');
    return _deviceLocale;
  }

  /// A list of dial codes for every country
  static List<String> dialNumbers() {
    return codes.values
        .map((each) => CountryDetails.fromMap(each).dialCode)
        .toList();
  }

  /// Returns the `CountryDetails` for the given [locale]. If not provided,
  /// the device's locale will be used instead.
  /// Have in mind that this is different than specifying `supportedLocale`s
  /// on your app.
  /// Exposed properties are the `name`, `alpha2Code`, `alpha3Code` and `dialCode`
  /// Eg.
  /// ```
  /// "name": "United States",
  /// "alpha2Code": "US",
  /// "dial_code": "+1",
  /// ```
  static CountryDetails detailsForLocale([Locale locale]) {
    return CountryDetails.fromMap(codes[_resolveLocale(locale)]);
  }

  /// Returns the ISO 3166-1 `alpha2Code` for the given [locale].
  /// If not provided, device's locale will be used instead.
  /// You can read more about ISO 3166-1 codes [here](https://en.wikipedia.org/wiki/ISO_3166-1)
  /// Eg. (`US`, `PT`, etc.)
  static String alpha2Code([Locale locale]) {
    return CountryDetails.fromMap(codes[_resolveLocale(locale)]).alpha2Code;
  }

  /// Returns the `dialCode` for the given [locale] or device's locale, if not provided.
  /// Eg. (`+1`, `+351`, etc.)
  static String dialCode([Locale locale]) {
    return CountryDetails.fromMap(codes[_resolveLocale(locale)]).dialCode;
  }

  /// Returns the exended `name` for the given [locale] or device's locale, if not provided.
  /// Eg. (`United States`, `Portugal`, etc.)
  static String name([Locale locale]) {
    return CountryDetails.fromMap(codes[_resolveLocale(locale)]).name;
  }
}
