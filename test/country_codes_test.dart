import 'package:country_codes/country_codes.dart';
import 'package:country_codes/src/codes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('No Country lacks name,alphaCode2 and dialCode', () {
    final numberOfParsedCountries = CountryCodes.countryCodes().length;
    expect(numberOfParsedCountries, codes.values.length);
  });
}
