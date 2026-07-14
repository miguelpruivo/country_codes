import Flutter
import UIKit

public class CountryCodesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "country_codes", binaryMessenger: registrar.messenger())
    let instance = CountryCodesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getRegion":
      result(Locale.current.regionCode)
    case "getLanguage":
      result(Locale.current.languageCode)
    case "getLocale":
      result([
        Locale.current.languageCode as Any,
        Locale.current.regionCode as Any,
        getLocalizedCountryNames(localeTag: call.arguments as? String),
      ])
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  func getLocalizedCountryNames(localeTag: String?) -> [String: String] {
    var localizedCountries = [String: String]()

    for countryCode in NSLocale.isoCountryCodes {
      let countryName = NSLocale(localeIdentifier: localeTag ?? Locale.preferredLanguages[0])
        .displayName(forKey: .countryCode, value: countryCode)
      localizedCountries[countryCode.uppercased()] = countryName ?? ""
    }
    return localizedCountries
  }
}
