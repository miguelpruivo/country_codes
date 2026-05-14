import 'package:country_codes/country_codes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('country_codes');

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('init handles a missing localized country names map', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      expect(call.method, 'getLocale');
      return ['en', 'GB'];
    });

    expect(await CountryCodes.init(), isTrue);
    expect(CountryCodes.getDeviceLocale(), const Locale('en', 'GB'));
  });

  test('init handles a null localized country names map', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
      expect(call.method, 'getLocale');
      return ['en', 'GB', null];
    });

    expect(await CountryCodes.init(), isTrue);
    expect(CountryCodes.getDeviceLocale(), const Locale('en', 'GB'));
  });
}
