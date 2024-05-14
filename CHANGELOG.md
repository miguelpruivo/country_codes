## [3.1.0] - 14/05/2024
* Adds `countryCode` property.

## [3.0.0] - 13/05/2024
* Adds Android namespace and other minor improvements.

## [2.2.0] - 10/05/2022

* Upgrades to Android project (pre 1.12). Thank you @vergardan.

## [2.1.1] - 21/10/2021

* Fixes Sint Marteen code ([#20](https://github.com/miguelpruivo/country_codes/issues/20)).

## [2.1.0] - 17/10/2021

* Adds a method to get a `List` with all country's details ([#16](https://github.com/miguelpruivo/country_codes/issues/16#issuecomment-945192260)). Thank you @wizlif.

## [2.0.1] - 25/03/2021

* Updates gradle to 5.4.1. ([#15](https://github.com/miguelpruivo/country_codes/issues/15))

## [2.0.0] - 25/03/2021

* Updates to null safety. Thank you @AntonyLeons.

## [1.0.3] - 17/11/2020

* Adds new codes from Netherlands Antilles dissolution ([#5](https://github.com/miguelpruivo/country_codes/issues/5)). Thanks @comESK.
## [1.0.2] - 20/10/2020

* Fixes dial code for Shqipëria.

## [1.0.1] - 05/08/2020

* Sets default `Locale` to en-US whenever a device hasn't a default locale set (typically will happen only on iOS simulators).

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
