package com.miguelruivo.flutter.plugin.countrycodes.country_codes

import android.R
import android.os.Build
import java.util.Locale
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import org.apache.commons.lang3.LocaleUtils

/** CountryCodesPlugin */
public class CountryCodesPlugin: FlutterPlugin, MethodCallHandler {
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "country_codes")
    channel.setMethodCallHandler(CountryCodesPlugin());
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "country_codes")
      channel.setMethodCallHandler(CountryCodesPlugin())
    }
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

    val deviceCountry: String = Locale.getDefault().getLanguageTag();

    for (countryCode in Locale.getISOCountries()) {
      val locale = Locale(localeTag ?: deviceCountry,countryCode)
      var countryName: String? = locale.getDisplayCountry(initLocaleForTag(localeTag ?: deviceCountry))
      localizedCountries[countryCode.toUpperCase()] = countryName ?: "";
    }
    return localizedCountries
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
  }

  private fun initLocaleForTag(languageTag: String): Locale {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      return Locale.forLanguageTag(languageTag)
    }

    return LocaleUtils.toLocale(languageTag)
  }
}

private fun Locale.getLanguageTag(): String {
  if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
    return toLanguageTag()
  }

  // we will use a dash as per BCP 47
  val SEP = '-'
  var language: String = language
  var region: String = country
  var variant: String = variant

  // special case for Norwegian Nynorsk since "NY" cannot be a variant as per BCP 47
  // this goes before the string matching since "NY" wont pass the variant checks
  if (language == "no" && region == "NO" && variant == "NY") {
    language = "nn"
    region = "NO"
    variant = ""
  }

  if (language.isEmpty() || !language.matches(Regex("\\p{Alpha}{2,8}"))) {
    language = "und" // Follow the Locale#toLanguageTag() implementation
    // which says to return "und" for Undetermined
  } else if (language.equals("iw")) {
    language = "he" // correct deprecated "Hebrew"
  } else if (language.equals("in")) {
    language = "id" // correct deprecated "Indonesian"
  } else if (language.equals("ji")) {
    language = "yi" // correct deprecated "Yiddish"
  }

  // ensure valid country code, if not well formed, it's omitted
  if (!region.matches(Regex("\\p{Alpha}{2}|\\p{Digit}{3}"))) {
    region = ""
  }

  // variant subtags that begin with a letter must be at least 5 characters long
  if (!variant.matches(Regex("\\p{Alnum}{5,8}|\\p{Digit}\\p{Alnum}{3}"))) {
    variant = ""
  }

  val bcp47Tag = StringBuilder(language)
  if (region.isNotEmpty()) {
    bcp47Tag.append(SEP).append(region)
  }
  if (variant.isNotEmpty()) {
    bcp47Tag.append(SEP).append(variant)
  }

  return bcp47Tag.toString()
}
