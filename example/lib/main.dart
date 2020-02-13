import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:country_codes/country_codes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CountryCodes.init();
  runApp(CountryCodesExampleApp());
}

class CountryCodesExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Country codes example app'),
        ),
        body: Builder(builder: (context) {
          CountryDetails details = CountryCodes.detailsForLocale();
          Locale locale = CountryCodes.getDeviceLocale();
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'Device locale: ${locale.languageCode}-${locale.countryCode}'),
              Text('Name: ${details.name}'),
              Text('Alpha 2: ${details.alpha2Code}'),
              Text('Dial Code: ${details.dialCode}'),
              SizedBox(
                width: 200.0,
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: [DialCodeFormatter()],
                ),
              ),
            ],
          ));
        }),
      ),
    );
  }
}
