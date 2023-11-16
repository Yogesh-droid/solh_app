import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/products/features/cart/data/models/address_model.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/address_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/delete_address_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class AddressTileSheet extends StatelessWidget {
  const AddressTileSheet({super.key, required this.addressList});
  final AddressList addressList;

  @override
  Widget build(BuildContext context) {
    final AddressController _addressController = Get.find();
    final DeleteAddressController _deleteAddressController = Get.find();
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              print(_addressController.selectedAddress.value.id);
              print(addressList.id);
              _addressController.selectedAddress.value = addressList;
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(color: SolhColors.primary_green),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(addressList.fullName ?? '',
                          style: GoogleFonts.signika(
                              textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black))),
                      Spacer(),
                      Radio(
                          activeColor: SolhColors.primary_green,
                          value: addressList.id,
                          groupValue:
                              _addressController.selectedAddress.value.id,
                          onChanged: (_) {})
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                      "${addressList.buildingName} ${addressList.street}\n${addressList.landmark} ${addressList.city} ${addressList.state} ${addressList.postalCode}",
                      style: GoogleFonts.signika(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: SolhColors.dark_grey))),
                  const SizedBox(height: 5),
                  Text(addressList.phoneNumber ?? '',
                      style: GoogleFonts.signika(
                          textStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: SolhColors.dark_grey))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _addressController.selectedAddress.value =
                                addressList;
                            Navigator.pushNamed(
                                context, AppRoutes.addAddressPage,
                                arguments: {"addressList": addressList});
                          },
                          child: Text("Edit",
                              style: GoogleFonts.signika(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: SolhColors.primary_green)))),
                      TextButton(
                          onPressed: () {
                            _addressController.selectedAddress.value =
                                addressList;
                            _deleteAddressController.deleteAddress(
                                id: addressList.id ?? '');
                            _addressController.getAddress();
                            Navigator.pop(context);
                          },
                          child: Text("Delete",
                              style: GoogleFonts.signika(
                                  textStyle: TextStyle(
                                      fontSize: 14,
                                      color: SolhColors.primaryRed)))),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
