## [1.0.0+1] - 08/07/2020

* Updates assert to also validate that `countryCode` is not `null`.

## [1.0.0] - 10/05/2020

* Added `localizedName` property to `CountryDetails`. This allows you to display any country name base on a `Locale` language. Must be set when doing `CountryCodes.init(locale)`, defaults to device's language.
* Updated Android `compileSdkVersion` to 29 and `minSdkVersion` to 21;
* Updated example app;

## [0.1.0] - 13/02/2020

Exposes device `Locale` (language and country code) instead of country only.

## [0.0.6+2] - 12/02/2020

Updates `dialCode()` to receive the [locale] optionally instead of explictly `null` in order to retrieve the device's region dial code.

## [0.0.6+1] - 03/02/2020

Replaces `FutureOr<Locale>` with `Locale` to make it explicitly synchronous when invoking `getDeviceLocale()`

## [0.0.6] - 03/02/2020

Exposes device's `Locale` through `getDeviceLocale()` method.

## [0.0.5] - 31/01/2020

Updates README

## [0.0.4] - 31/01/2020

* Adds default `locale` from device region when not provided. For this to work, please call `CountryCodes.init()` before invoking other methods.
* Overall minor improvements.

## [0.0.3] - 30/01/2020

Format

## [0.0.2] - 30/01/2020

Adds license (MIT)

## [0.0.1] - 30/01/2020

Initial release. Provides access to `DialCodeFormatter` for `TextFormField`s, `alpha2Code`, `dialCode` and `name`.
