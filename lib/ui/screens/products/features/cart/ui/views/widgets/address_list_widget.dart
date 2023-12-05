import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/address_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/views/widgets/address_tile_sheet.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class AddressListWidget extends StatelessWidget {
  const AddressListWidget({super.key, required this.wantToChangeBilling});
  final bool wantToChangeBilling;

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.find();
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Choose Address",
                style: GoogleFonts.signika(
                    textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black))),
            ...addressController.addressEntity.value.addressList!
                .map((e) => AddressTileSheet(
                      addressList: e,
                      wantToChangeBilling: wantToChangeBilling,
                    )),
            SolhGreenButton(
              height: 40,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.add),
                const SizedBox(width: 5),
                Text(
                  "Add New",
                  style: SolhTextStyles.QS_body_2_semi.copyWith(
                      color: Colors.white),
                )
              ]),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.addAddressPage,
                    arguments: {"addressList": null});
              },
            )
          ],
        ),
      ),
    );
  }
}
