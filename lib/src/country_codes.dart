import 'dart:async';

import 'package:country_codes/src/codes.dart';
import 'package:country_codes/src/country_details.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CountryCodes {
  static const MethodChannel _channel = const MethodChannel('country_codes');
  static Locale? _deviceLocale;
  static late Map<String, String> _localizedCountryNames;

  static String? _resolveLocale(Locale? locale) {
    locale ??= _deviceLocale;
    assert(locale != null && locale.countryCode != null, '''
         Locale and country code cannot be null. If you are using an iOS simulator, please, make sure you go to region settings and select any country (even if it\'s already selected) because otherwise your country might be null.
         If you didn\'t provide one, please make sure you call init before using Country Details
        ''');
    return locale!.countryCode;
  }

  /// Inits the underlying plugin channel and fetch current's device locale to be ready
  /// to use synchronously when required.
  ///
  /// If you never plan to provide a `locale` directly, you must call and await this
  /// by calling `await CountryCodes.init();` before accessing any other method.
  ///
  /// Optionally, you may want to provide your [appLocale] to access localized
  /// country name (eg. if your app is in English, display Italy instead of Italia).
  ///
  /// Example:
  /// ```dart
  /// CountryCodes.init(Localizations.localeOf(context))
  /// ```
  /// This will default to device's language if none is provided.
  static Future<bool> init([Locale? appLocale]) async {
    final List<dynamic>? locale = List<dynamic>.from(
        await (_channel.invokeMethod('getLocale', appLocale?.toLanguageTag())));
    if (locale != null) {
      _deviceLocale = Locale(locale[0], locale[1]);
      _localizedCountryNames = Map.from(locale[2]);
    }
    return _deviceLocale != null;
  }

  /// Returns the current device's `Locale`
  /// Eg. `Locale('en','US')`
  static Locale? getDeviceLocale() {
    assert(_deviceLocale != null,
        'Please, make sure you call await init() before calling getDeviceLocale()');
    return _deviceLocale;
  }

  /// A list of dial codes for every country
  static List<String?> dialNumbers() {
    return codes.values
        .map((each) => CountryDetails.fromMap(each).dialCode)
        .toList();
  }

  /// A list of country data for every country
  static List<CountryDetails> countryCodes() {
    return codes.entries
        .map((entry) => CountryDetails.fromMap(
            entry.value, _localizedCountryNames[entry.key]))
        .toList();
  }

  /// Returns the `CountryDetails` for the given [locale]. If not provided,
  /// the device's locale will be used instead.
  /// Have in mind that this is different than specifying `supportedLocale`s
  /// on your app.
  /// Exposed properties are the `name`, `alpha2Code`, `alpha3Code` and `dialCode`
  ///
  /// Example:
  /// ```dart
  /// "name": "United States",
  /// "alpha2Code": "US",
  /// "dial_code": "+1",
  /// ```
  static CountryDetails detailsForLocale([Locale? locale]) {
    String? code = _resolveLocale(locale);
    return CountryDetails.fromMap(codes[code!], _localizedCountryNames[code]);
  }

  /// Returns the `CountryDetails` for the given country alpha2 code.
  static CountryDetails detailsFromAlpha2(String alpha2) {
    return CountryDetails.fromMap(codes.entries.where((entry) => entry.key == alpha2).single.value);
  }


  /// Returns the ISO 3166-1 `alpha2Code` for the given [locale].
  /// If not provided, device's locale will be used instead.
  /// You can read more about ISO 3166-1 codes [here](https://en.wikipedia.org/wiki/ISO_3166-1)
  ///
  /// Example: (`US`, `PT`, etc.)
  static String? alpha2Code([Locale? locale]) {
    String? code = _resolveLocale(locale);
    return CountryDetails.fromMap(codes[code!], _localizedCountryNames[code])
        .alpha2Code;
  }

  /// Returns the `dialCode` for the given [locale] or device's locale, if not provided.
  ///
  /// Example: (`+1`, `+351`, etc.)
  static String? dialCode([Locale? locale]) {
    String? code = _resolveLocale(locale);
    return CountryDetails.fromMap(codes[code!], _localizedCountryNames[code])
        .dialCode;
  }

  /// Returns the exended `name` for the given [locale] or if not provided, device's locale.
  ///
  /// Example: (`United States`, `Portugal`, etc.)
  static String? name({Locale? locale}) {
    String? code = _resolveLocale(locale);
    return CountryDetails.fromMap(codes[code!], _localizedCountryNames[code])
        .name;
  }
}
