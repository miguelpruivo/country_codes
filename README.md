# Country Codes
 <a href="https://pub.dartlang.org/packages/country_codes">
    <img alt="Country Codes" src="https://img.shields.io/pub/v/country_codes.svg">
  </a>
 <a href="https://codemagic.io/apps/5e337605cb139582fb63de68/5e337605cb139582fb63de67/latest_build">
    <img alt="Build Status" src="https://api.codemagic.io/apps/5e337605cb139582fb63de68/5e337605cb139582fb63de67/status_badge.svg">
  </a>
 <a href="https://www.buymeacoffee.com/gQyz2MR">
    <img alt="Buy me a coffee" src="https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-yellow.svg">
  </a>
</p>

Country codes package provides an easy to way to access country codes based on a provided `Locale`.

# Usage
There are two main ways to use this package.

### 1. Default by using device region
This will allow you to fetch the region of the underlying platform and display the data accordingly. Very handy if you use along with the `DialCodeFormatter` to provide integration with dial codes formatter, on phone `TextFormField`s in a `Form`, for example.

Assuming an **en-US** region based revice.
```
await CountryCodes.init(); // Optionally, you may provide a `Locale` to get countrie's localizadName

final Locale deviceLocale = CountryCodes.getDeviceLocale();
print(deviceLocale.languageCode); // Displays en
print(deviceLocale.countryCode); // Displays US

final CountryDetails details = CountryCodes.detailsForLocale();
print(details.alpha2Code); // Displays alpha2Code, for example US.
print(details.dialCode); // Displays the dial code, for example +1.
print(details.name); // Displays the extended name, for example United States.
print(details.localizedName); // Displays the extended name based on device's language (or other, if provided on init)
```
### 2. Use a custom `Locale`
This will use the provided `Locale`, which may not be related to the device's region but instead to the app supported languages.

For example, if your device is on US region but the app only supports PT, you'll get the following:
```
final CountryDetails details = CountryCodes.detailsForLocale(Localization.localeOf(context));

print(details.alpha2Code); // Displays alpha2Code, displays PT.
print(details.dialCode); // Displays the dial code for PT, +351.
print(details.name); // Displays the extended name, Portugal.
```

# Formatters
### `DialCodeFormatter`
Currently there's only available `TextInputFormatter` which allows you to dynamically set the dial code dynamically on a `TextFormField`. 
```
TextFormField(
           keyboardType: TextInputType.phone,
           inputFormatters: [DialCodeFormatter()],
          );
```

# Example app
![Example](https://github.com/miguelpruivo/country_codes/blob/master/example/example.png)


## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
