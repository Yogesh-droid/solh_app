import '../../data/models/country_model.dart';

class CountryListEntity {
  final bool? success;
  final List<CountryList>? countryList;

  CountryListEntity({this.success, this.countryList});
}
