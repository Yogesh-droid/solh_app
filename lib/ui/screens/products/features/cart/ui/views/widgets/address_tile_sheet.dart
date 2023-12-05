import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/products/features/cart/data/models/address_model.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/address_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/delete_address_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class AddressTileSheet extends StatelessWidget {
  const AddressTileSheet(
      {super.key,
      required this.addressList,
      required this.wantToChangeBilling});
  final AddressList addressList;
  final bool wantToChangeBilling;

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.find();
    final DeleteAddressController deleteAddressController = Get.find();
    return Obx(() => Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap:
                wantToChangeBilling // if want different billing than shipping
                    ? () {
                        addressController.selectedBillingAddress.value =
                            addressList;
                      }
                    : () {
                        addressController.selectedAddress.value = addressList;
                        addressController.selectedBillingAddress.value =
                            addressList;
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
                              textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black))),
                      const Spacer(),
                      Radio(
                          activeColor: SolhColors.primary_green,
                          value: addressList.id,
                          groupValue: wantToChangeBilling
                              ? addressController
                                  .selectedBillingAddress.value.id
                              : addressController.selectedAddress.value.id,
                          onChanged: (_) {
                            wantToChangeBilling // if want different billing than shipping
                                ? addressController
                                    .selectedBillingAddress.value = addressList
                                : addressController.selectedAddress.value =
                                    addressList;
                            addressController.selectedBillingAddress.value =
                                addressList;
                          })
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                      "${addressList.buildingName} ${addressList.street}\n${addressList.landmark} ${addressList.city} ${addressList.state} ${addressList.postalCode}",
                      style: GoogleFonts.signika(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: SolhColors.dark_grey))),
                  const SizedBox(height: 5),
                  Text(addressList.phoneNumber ?? '',
                      style: GoogleFonts.signika(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: SolhColors.dark_grey))),
                  // if you want to change billing, edit or delete not allowed
                  if (!wantToChangeBilling)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              addressController.selectedAddress.value =
                                  addressList;
                              Navigator.pushNamed(
                                  context, AppRoutes.addAddressPage,
                                  arguments: {"addressList": addressList});
                            },
                            child: Text("Edit",
                                style: GoogleFonts.signika(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        color: SolhColors.primary_green)))),
                        TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Stack(
                                      children: [
                                        AlertDialog(
                                          actionsPadding:
                                              const EdgeInsets.all(8.0),
                                          content: Text(
                                            'Do you really want to delete address?'
                                                .tr,
                                            style: SolhTextStyles
                                                .JournalingDescriptionText,
                                          ),
                                          actions: [
                                            InkWell(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Yes'.tr,
                                                    style: SolhTextStyles.CTA
                                                        .copyWith(
                                                            color: SolhColors
                                                                .primaryRed),
                                                  ),
                                                ),
                                                onTap: () {
                                                  addressController
                                                      .selectedAddress
                                                      .value = addressList;
                                                  deleteAddressController
                                                      .deleteAddress(
                                                          id: addressList.id ??
                                                              '');
                                                  addressController
                                                      .getAddress();
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                }),
                                            const SizedBox(width: 30),
                                            InkWell(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'No'.tr,
                                                    style: SolhTextStyles.CTA
                                                        .copyWith(
                                                            color: SolhColors
                                                                .primary_green),
                                                  ),
                                                ),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                }),
                                          ],
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Text("Delete",
                                style: GoogleFonts.signika(
                                    textStyle: const TextStyle(
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
