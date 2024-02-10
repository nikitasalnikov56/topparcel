import 'package:topparcel/data/models/response/fetch_country_response.dart';

class CountryToId {}

class CountryFromIdModel {
  final String name;
  final String code;
  final String? code2;

  CountryFromIdModel({
    required this.name,
    required this.code,
    this.code2,
  });
}

CountryFromIdModel getCountryFromId(String id, List<Country> countries) {
  for (var country in countries) {
    if (country.id == id) {
      return CountryFromIdModel(
        name: country.name,
        code: country.code,
        code2: country.code2,
      );
    }
  }
  throw Exception('Country with id $id not found');
}
