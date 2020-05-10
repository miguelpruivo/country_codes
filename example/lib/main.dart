import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:country_codes/country_codes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CountryCodes.init();
  runApp(CountryCodesExampleApp());
}

class CountryCodesExampleApp extends StatelessWidget {
  TableRow _buildEntry({String title, String description}) {
    return TableRow(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Text(
            title,
            textAlign: TextAlign.end,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(description),
        ),
      ],
    );
  }

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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Table(
                    border: TableBorder(
                      horizontalInside: const BorderSide(width: 0.5),
                      verticalInside: const BorderSide(width: 0.5),
                      top: const BorderSide(),
                      bottom: const BorderSide(),
                      left: const BorderSide(),
                      right: const BorderSide(),
                    ),
                    children: <TableRow>[
                      _buildEntry(
                          title: 'Device region',
                          description:
                              '${locale.languageCode}-${locale.countryCode}'),
                      _buildEntry(
                          title: 'Name', description: '${details.name}'),
                      _buildEntry(
                          title: 'Localized (PT lang)',
                          description: '${details.localizedName}'),
                      _buildEntry(
                          title: 'Alpha 2',
                          description: '${details.alpha2Code}'),
                      _buildEntry(
                          title: 'Dial code',
                          description: '${details.dialCode}'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 200.0,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [DialCodeFormatter()],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
