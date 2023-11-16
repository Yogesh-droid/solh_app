import 'package:solh/ui/screens/products/features/cart/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  AddressModel({bool? success, List<AddressList>? addressList})
      : super(addressList: addressList, success: success);

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
        success: json["success"],
        addressList: json["addressList"] == null
            ? null
            : (json["addressList"] as List)
                .map((e) => AddressList.fromJson(e))
                .toList());
  }
}

class AddressList {
  String? id;
  String? userId;
  String? fullName;
  String? phoneNumber;
  String? buildingName;
  String? street;
  String? city;
  String? state;
  String? postalCode;
  String? landmark;
  bool? isDefault;

  AddressList(
      {this.id,
      this.userId,
      this.fullName,
      this.phoneNumber,
      this.buildingName,
      this.street,
      this.city,
      this.state,
      this.postalCode,
      this.landmark,
      this.isDefault});

  AddressList.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    userId = json["userId"];
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
}
