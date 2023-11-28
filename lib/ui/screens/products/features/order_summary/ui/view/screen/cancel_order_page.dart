import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/entity/order_detail_entity.dart';
import 'package:solh/ui/screens/products/features/order_summary/ui/controller/cancel_reason_controller.dart';
import 'package:solh/ui/screens/products/features/order_summary/ui/view/widgets/cancel_reasons_sheet.dart';
import 'package:solh/ui/screens/products/features/order_summary/ui/view/widgets/item_detail_cancel_order.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../../../../../../../../widgets_constants/constants/colors.dart';
import '../../../../../../../../widgets_constants/constants/textstyles.dart';

class CancelOrderPage extends StatelessWidget {
  const CancelOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;
    final OrderDetailEntity orderDetailEntity = args['orderDetailEntity'];
    final TextEditingController textEditingController = TextEditingController();
    final CancelReasonController cancelReasonController = Get.find();
    return Scaffold(
      appBar: SolhAppBar(
          title: Text(
            "Select Reason",
            style:
                GoogleFonts.quicksand(textStyle: SolhTextStyles.QS_body_1_bold),
          ),
          isLandingScreen: false),
      floatingActionButton: Obx(() => FloatingActionButton.extended(
            onPressed: cancelReasonController.isCancelInProgress.value
                ? null
                : () {
                    if (cancelReasonController.selectedReason.value.isEmpty) {
                      Utility.showToast("Please Choose Reason to Cancel");
                      return;
                    }
                    _cancelOrder(
                        orderId: orderDetailEntity.userOrderDetails!.id,
                        refIf: orderDetailEntity
                            .userOrderDetails!.orderItems!.refId,
                        comment: textEditingController.text);
                    if (cancelReasonController.cancelFailMsg.value.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              cancelReasonController.cancelFailMsg.value,
                              style: SolhTextStyles.CTA
                                  .copyWith(color: Colors.white))));
                      cancelReasonController.cancelReasonLoading.value = false;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              cancelReasonController.cancelSuccessMsg.value,
                              style: SolhTextStyles.CTA
                                  .copyWith(color: Colors.white)),
                          behavior: SnackBarBehavior.floating));
                      cancelReasonController.cancelReasonLoading.value = false;
                    }
                    Navigator.pop(context);
                  },
            label: SizedBox(
                width: MediaQuery.of(context).size.width - 75,
                child: Center(
                    child: cancelReasonController.isCancelInProgress.value
                        ? MyLoader()
                        : Text(
                            "Cancel Order",
                            style: GoogleFonts.quicksand(
                                textStyle: SolhTextStyles.CTA
                                    .copyWith(color: Colors.white)),
                          ))),
            backgroundColor: SolhColors.primaryRed,
          )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Product Details",
                  style: GoogleFonts.quicksand(
                    textStyle: SolhTextStyles.QS_body_1_bold.copyWith(
                        color: Colors.black),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ItemDetailCancelOrder(
                  itemName:
                      orderDetailEntity.userOrderDetails!.orderItems!.name ??
                          '',
                  quantity:
                      "${orderDetailEntity.userOrderDetails!.orderItems!.quantity}",
                  image:
                      orderDetailEntity.userOrderDetails!.orderItems!.image ??
                          '',
                  price:
                      "${orderDetailEntity.userOrderDetails!.currency} ${orderDetailEntity.userOrderDetails!.orderItems!.salePrice}"),
            ),
            ListTile(
              onTap: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    enableDrag: true,
                    context: context,
                    builder: (_) => const CancelReasonsSheet(),
                    backgroundColor: Colors.transparent);
              },
              contentPadding: const EdgeInsets.all(12),
              title: Text("Select reason for cancellation",
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: Colors.black)),
              trailing: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: SolhColors.primary_green,
              ),
            ),
            const GetHelpDivider(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Could you tell us a reason for canceling?",
                  style: GoogleFonts.quicksand(
                    textStyle: SolhTextStyles.QS_body_1_bold.copyWith(
                        color: Colors.black),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    label: const Text("Tell Us More"),
                    alignLabelWithHint: true),
                maxLines: 5,
              ),
            ),
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }

  Future<void> _cancelOrder(
      {String? orderId, String? refIf, required String comment}) async {
    final CancelReasonController cancelReasonController = Get.find();
    await cancelReasonController.cancelOrder(
        orderId: orderId ?? '',
        refId: refIf ?? '',
        reason: cancelReasonController.selectedReason.value,
        comment: comment);
  }
}
