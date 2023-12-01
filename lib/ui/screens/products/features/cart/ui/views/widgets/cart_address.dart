import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/address_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/views/widgets/address_list_widget.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'address_shimmer.dart';

class CartAddress extends StatefulWidget {
  const CartAddress({super.key});

  @override
  State<CartAddress> createState() => _CartAddressState();
}

class _CartAddressState extends State<CartAddress> {
  late AddressController _addressController;

  @override
  void initState() {
    _addressController = Get.find();
    getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => !_addressController.isAddressLoading.value
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shipping Address",
                          style: GoogleFonts.quicksand(
                              textStyle: SolhTextStyles.QS_body_semi_1)),
                      TextButton(
                          onPressed: _addressController
                                  .addressEntity.value.addressList!.isNotEmpty
                              ? () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (_) => const AddressListWidget(
                                          wantToChangeBilling: false),
                                      showDragHandle: true);
                                }
                              : () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.addAddressPage,
                                      arguments: {"addressList": null});
                                },
                          child: Text(
                              _addressController.addressEntity.value
                                      .addressList!.isNotEmpty
                                  ? "Change Address"
                                  : "Add Address",
                              style: GoogleFonts.quicksand(
                                  textStyle:
                                      SolhTextStyles.QS_body_2_bold.copyWith(
                                          color: SolhColors.primary_green))))
                    ]),
              ),
              _addressController.addressEntity.value.addressList!.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(color: SolhColors.grey_2),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                _addressController
                                        .selectedAddress.value.fullName ??
                                    '',
                                style: GoogleFonts.signika(
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black))),
                            const SizedBox(height: 5),
                            Text(
                                "${_addressController.selectedAddress.value.buildingName}, ${_addressController.selectedAddress.value.street}\n${_addressController.selectedAddress.value.landmark}, ${_addressController.selectedAddress.value.city}, ${_addressController.selectedAddress.value.state} ${_addressController.selectedAddress.value.postalCode}",
                                style: GoogleFonts.signika(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: SolhColors.dark_grey))),
                            const SizedBox(height: 5),
                            Text(
                                _addressController
                                        .selectedAddress.value.phoneNumber ??
                                    '',
                                style: GoogleFonts.signika(
                                    textStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: SolhColors.dark_grey)))
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              const GetHelpDivider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_addressController.selectedAddress !=
                      _addressController.selectedBillingAddress)
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("Billing Address",
                                style: GoogleFonts.quicksand(
                                    textStyle: SolhTextStyles.QS_body_semi_1)),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: TextButton(
                                onPressed: _addressController
                                            .selectedBillingAddress
                                            .value
                                            .buildingName !=
                                        null
                                    ? () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.addAddressPage,
                                            arguments: {
                                              "addressList": _addressController
                                                  .selectedBillingAddress.value,
                                              'title': 'Add Billing Address'
                                            });
                                      }
                                    : () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.addAddressPage,
                                            arguments: {
                                              "addressList": null,
                                              'title': 'Add Billing Address'
                                            });
                                      },
                                child: Text("Change Address",
                                    style: GoogleFonts.quicksand(
                                        textStyle: SolhTextStyles.QS_body_2_bold
                                            .copyWith(
                                                color: SolhColors
                                                    .primary_green)))),
                          )
                        ]),
                  if (_addressController.selectedAddress ==
                      _addressController.selectedBillingAddress)
                    ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.addAddressPage,
                            arguments: {
                              "addressList": null,
                              'title': 'Add Billing Address'
                            });
                      },
                      title: Text("Same as shipping address",
                          style: GoogleFonts.quicksand(
                              textStyle: SolhTextStyles.QS_body_semi_1)),
                      leading: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.addAddressPage,
                              arguments: {
                                "addressList": null,
                                'title': 'Add Billing Address'
                              });
                        },
                        child: const Icon(Icons.check_box,
                            color: SolhColors.primary_green),
                      ),
                      /* trailing: Radio(
                          value: 1,
                          groupValue: 0,
                          onChanged: (_) {
                            Navigator.pushNamed(
                                context, AppRoutes.addAddressPage, arguments: {
                              "addressList": null,
                              'title': 'Add Billing Address'
                            });
                          }), */
                    ),

                  // If Billing address is different than Shipping then Show it else hide it

                  if (_addressController.selectedAddress !=
                      _addressController.selectedBillingAddress)
                    _addressController
                            .addressEntity.value.addressList!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  border: Border.all(color: SolhColors.grey_2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      _addressController.selectedBillingAddress
                                              .value.fullName ??
                                          '',
                                      style: GoogleFonts.signika(
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black))),
                                  const SizedBox(height: 5),
                                  Text(
                                      "${_addressController.selectedBillingAddress.value.buildingName}, ${_addressController.selectedBillingAddress.value.street}\n${_addressController.selectedBillingAddress.value.landmark}, ${_addressController.selectedBillingAddress.value.city}, ${_addressController.selectedBillingAddress.value.state}, ${_addressController.selectedBillingAddress.value.postalCode}",
                                      style: GoogleFonts.signika(
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: SolhColors.dark_grey))),
                                  const SizedBox(height: 5),
                                  Text(
                                      _addressController.selectedBillingAddress
                                              .value.phoneNumber ??
                                          '',
                                      style: GoogleFonts.signika(
                                          textStyle: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: SolhColors.dark_grey)))
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                ],
              )
            ],
          )
        : const SolhAddressShimmer());
  }

  Future<void> getAddress() async {
    await _addressController.getAddress();
  }
}
