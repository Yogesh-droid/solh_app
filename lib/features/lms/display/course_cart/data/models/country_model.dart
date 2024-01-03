import 'package:solh/features/lms/display/course_cart/domain/entities/country_list_entity.dart';

class CountryModel extends CountryListEntity {
  CountryModel({super.success, super.countryList});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
        success: json["success"],
        countryList: json["countryList"] == null
            ? null
            : (json["countryList"] as List)
                .map((e) => CountryList.fromJson(e))
                .toList());
  }
}

class CountryList {
  String? id;
  String? name;
  List<States>? states;

  CountryList.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    states = json["states"] == null
        ? null
        : (json["states"] as List).map((e) => States.fromJson(e)).toList();
  }
}

class States {
  String? name;

  States({this.name});

  States.fromJson(Map<String, dynamic> json) {
    name = json["name"];
  }
}
