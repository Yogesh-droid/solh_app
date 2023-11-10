import '../../data/models/address_model.dart';

class AddressEntity {
  final bool? success;
  final List<AddressList>? addressList;

  AddressEntity({this.success, this.addressList});
}
