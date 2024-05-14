class CountryDetails {
  /// Dial code represents a global phone prefix for the region
  /// Example: `+1`, `+351`
  final String? dialCode;

  /// ISO 3166 alpha 2 code
  /// Example: `US`, `PT`
  final String? alpha2Code;

  /// ISO 3166 alpha 3 code
  /// Example: `USA`, `PRT`
  final String? alpha3Code;

  /// Country code
  /// Example: `en_US`
  final String? countryCode;

  /// Extended country name in its own language
  ///
  /// Examples:
  /// US : United States
  /// IT : Italia
  /// DE : Deutschland
  final String? name;

  /// Extended country name based on a region language
  ///
  /// Examples for `US`:
  /// US : United States
  /// IT : Italy
  /// DE : Germany
  final String? localizedName;

  CountryDetails.fromMap(Map<String, dynamic> data,
      [String? localizedCountryName])
      : this.name = data['name'],
        this.alpha2Code = data['alpha2Code'],
        this.alpha3Code = data['alpha3Code'],
        this.dialCode = data['dial_code'],
        this.countryCode = data['country_code'],
        this.localizedName = localizedCountryName;
}
