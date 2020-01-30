class CountryDetails {
  final String dialCode;
  final String alpha2Code;
  final String alpha3Code;
  final String name;

  CountryDetails.fromMap(Map<String, dynamic> data)
      : this.name = data['name'],
        this.alpha2Code = data['alpha2Code'],
        this.alpha3Code = data['alpha3Code'],
        this.dialCode = data['dial_code'];
}
