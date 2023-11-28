import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/ui/screens/products/features/order_summary/ui/controller/cancel_reason_controller.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/shimmer_widget.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class CancelReasonsSheet extends StatefulWidget {
  const CancelReasonsSheet({super.key});

  @override
  State<CancelReasonsSheet> createState() => _CancelReasonsSheetState();
}

class _CancelReasonsSheetState extends State<CancelReasonsSheet> {
  final CancelReasonController cancelReasonController = Get.find();

  @override
  void initState() {
    if (cancelReasonController.cancelReasonEntity.value.reasons == null) {
      cancelReasonController.getCancelReason();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: SingleChildScrollView(
          child: Obx(() => cancelReasonController.cancelReasonLoading.value
              ? ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(
                      10,
                      (index) => ShimmerWidget(
                              child: Container(
                            height: 20,
                          ))),
                )
              : Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close_rounded,
                            color: SolhColors.Grey_1, size: 30))
                  ]),
                  Text('Reason for Cancellation',
                      style: GoogleFonts.quicksand(
                          textStyle: SolhTextStyles.QS_body_1_bold)),
                  ...cancelReasonController.cancelReasonEntity.value.reasons!
                      .map((e) => InkWell(
                            onTap: () {
                              cancelReasonController
                                  .reasonRadioGroupValue.value = e.id!;
                              cancelReasonController.selectedReason.value =
                                  e.id!;
                            },
                            child: Row(children: [
                              Radio<String>(
                                value: e.id!,
                                groupValue: cancelReasonController
                                    .reasonRadioGroupValue.value,
                                onChanged: (value) {
                                  cancelReasonController
                                      .reasonRadioGroupValue.value = value!;
                                  cancelReasonController.selectedReason.value =
                                      value;
                                },
                                activeColor: SolhColors.primary_green,
                              ),
                              Text(
                                e.reason ?? '',
                                style: GoogleFonts.quicksand(
                                    textStyle:
                                        SolhTextStyles.QS_caption.copyWith(
                                            color: cancelReasonController
                                                        .selectedReason.value ==
                                                    e.id
                                                ? SolhColors.primary_green
                                                : SolhColors.Grey_1)),
                              )
                            ]),
                          )),
                  const SizedBox(height: 20),
                  SolhGreenButton(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 70,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Done",
                        style:
                            SolhTextStyles.CTA.copyWith(color: Colors.white)),
                  )
                ]))),
    );
  }
}
