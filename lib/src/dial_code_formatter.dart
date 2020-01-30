import 'package:country_codes/country_codes.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// A formatter that dynamically adds the `dialCode` for the given [locale] as a prefix of the input text
/// This can be handy to use along with `TextFormFields` that are typically used on phone numbers forms.
class DialCodeFormatter extends TextInputFormatter {
  final Locale locale;

  DialCodeFormatter(this.locale);
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String code = CountryCodes.dialCode(locale);
    if (newValue.text.startsWith(code)) {
      return newValue;
    }
    return TextEditingValue(text: code);
  }
}
