import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/routes/routes.dart';
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
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery Address",
                          style: GoogleFonts.quicksand(
                              textStyle: SolhTextStyles.QS_body_semi_1)),
                      TextButton(
                          onPressed: _addressController
                                  .addressEntity.value.addressList!.isNotEmpty
                              ? () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (_) => AddressListWidget(),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
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
                                    textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black))),
                            const SizedBox(height: 5),
                            Text(
                                "${_addressController.selectedAddress.value.buildingName} ${_addressController.selectedAddress.value.street}\n${_addressController.selectedAddress.value.landmark} ${_addressController.selectedAddress.value.city} ${_addressController.selectedAddress.value.state} ${_addressController.selectedAddress.value.postalCode}",
                                style: GoogleFonts.signika(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: SolhColors.dark_grey))),
                            const SizedBox(height: 5),
                            Text(
                                _addressController
                                        .selectedAddress.value.phoneNumber ??
                                    '',
                                style: GoogleFonts.signika(
                                    textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: SolhColors.dark_grey)))
                          ],
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          )
        : SolhAddressShimmer());
  }

  Future<void> getAddress() async {
    await _addressController.getAddress();
  }
}
