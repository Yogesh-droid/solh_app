
class AddAddressReqModel {
  String? fullName;
  String? phoneNumber;
  String? buildingName;
  String? street;
  String? city;
  String? state;
  String? postalCode;
  String? landmark;
  bool? isDefault;

  AddAddressReqModel({this.fullName, this.phoneNumber, this.buildingName, this.street, this.city, this.state, this.postalCode, this.landmark, this.isDefault});

  AddAddressReqModel.fromJson(Map<String, dynamic> json) {
    fullName = json["fullName"];
    phoneNumber = json["phoneNumber"];
    buildingName = json["buildingName"];
    street = json["street"];
    city = json["city"];
    state = json["state"];
    postalCode = json["postalCode"];
    landmark = json["landmark"];
    isDefault = json["isDefault"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["fullName"] = fullName;
    _data["phoneNumber"] = phoneNumber;
    _data["buildingName"] = buildingName;
    _data["street"] = street;
    _data["city"] = city;
    _data["state"] = state;
    _data["postalCode"] = postalCode;
    _data["landmark"] = landmark;
    _data["isDefault"] = isDefault;
    return _data;
  }
}