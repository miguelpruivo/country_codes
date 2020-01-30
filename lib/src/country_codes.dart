import 'package:country_codes/src/codes.dart';
import 'package:country_codes/src/country_details.dart';
import 'package:flutter/widgets.dart';

extension on Locale {
  String get code => this.countryCode.toUpperCase();
}

class CountryCodes {
  /// A list of dial codes for every country
  static List<String> dialNumbers() {
    return codes.values.map((each) => CountryDetails.fromMap(each).dialCode).toList();
  }

  /// Returns the `CountryDetails` for the given [locale].
  /// Exposed properties are the `name`, `alpha2Code`, `alpha3Code` and `dialCode`
  static CountryDetails detailsForLocale(Locale locale) {
    assert(locale != null, 'A locale must be provided');
    return CountryDetails.fromMap(codes[locale.code]);
  }

  /// Returns the ISO 3166-1 `alpha2Code` for the given [locale].
  /// You can read more about ISO 3166-1 codes [here](https://en.wikipedia.org/wiki/ISO_3166-1)
  static String alpha2Code(Locale locale) {
    assert(locale != null, 'A locale must be provided');
    return CountryDetails.fromMap(codes[locale.code]).alpha2Code;
  }

  /// Returns the `dialCode` for the given [locale].
  static String dialCode(Locale locale) {
    assert(locale != null, 'A locale must be provided');
    return CountryDetails.fromMap(codes[locale.code]).dialCode;
  }

  /// Returns the exended `name` for the given [locale].
  static String name(Locale locale) {
    assert(locale != null, 'A locale must be provided');
    return CountryDetails.fromMap(codes[locale.code]).name;
  }
}
