package com.miguelruivo.flutter.plugin.countrycodes.country_codes

import android.R
import java.util.Locale
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** CountryCodesPlugin */
public class CountryCodesPlugin: FlutterPlugin, MethodCallHandler {
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "country_codes")
    channel.setMethodCallHandler(CountryCodesPlugin());
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

    when (call.method) {
        "getLocale" -> result.success(listOf(Locale.getDefault().language, Locale.getDefault().country, getLocalizedCountryNames(call.arguments as String?)))
        "getRegion" -> result.success(Locale.getDefault().country)
        "getLanguage" -> result.success(Locale.getDefault().language)
        else -> result.notImplemented()
    }
  }

  private fun getLocalizedCountryNames(localeTag: String?) : HashMap<String, String> {
    var localizedCountries: HashMap<String,String> = HashMap()

    val deviceCountry: String = Locale.getDefault().toLanguageTag();

    for (countryCode in Locale.getISOCountries()) {
      val locale = Locale(localeTag ?: deviceCountry,countryCode)
      var countryName: String? = locale.getDisplayCountry(Locale.forLanguageTag(localeTag ?: deviceCountry))
      localizedCountries[countryCode.toUpperCase()] = countryName ?: "";
    }
    return localizedCountries
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }
}
