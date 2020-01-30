# country_codes

Country codes package provides an easy to way to access country codes based on a provided `Locale`.

# Usage
```
final CountryDetails details = CountryDetails.detailsForLocale(Localizations.localeOf(context));

print(details.alpha2Code); // Displays alpha2Code, for example US.
print(details.dialCode); // Displays the dial code, for example +1.
print(details.name); // Displays the extended name, for example United States.
```

You can also take advantage of the provided `DialCodeFormatter` that allows you to dynamically add the country dial code before a phone number.

```
TextFormField(
           autofocus: true,
           keyboardType: TextInputType.phone,
           inputFormatters: [DialCodeFormatter(Localizations.localeOf(context))],
          );
```

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.dev/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
