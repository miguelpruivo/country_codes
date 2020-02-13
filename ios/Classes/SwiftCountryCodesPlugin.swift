import Flutter
import UIKit

public class SwiftCountryCodesPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "country_codes", binaryMessenger: registrar.messenger())
    let instance = SwiftCountryCodesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    
    switch call.method {
    case "getRegion":
        result(Locale.current.regionCode)
        break
    case "getLanguage":
        result(Locale.current.languageCode)
        break
    case "getLocale":
        result([Locale.current.languageCode, Locale.current.regionCode])
        break
    default:
        result(FlutterMethodNotImplemented);
    }
  }
}
