import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/get-help/payment/payment_controller.dart';
import 'package:solh/ui/screens/get-help/payment/payment_management.dart';
import 'package:solh/ui/screens/my-profile/appointments/controller/appointment_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

// ignore: must_be_immutable
class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key, required Map<dynamic, dynamic> args})
      : _amount = args["amount"].toString(),
        _feeCurrency = args["feeCurrency"] ?? '',
        _alliedOrderId = args["alliedOrderId"] ?? null,
        _appointmentId = args["appointmentId"] ?? null,
        _inhouseOrderId = args["inhouseOrderId"] ?? null,
        _marketplaceType = args["marketplaceType"],
        _paymentGateway = args["paymentGateway"],
        _paymentSource = args["paymentSource"],
        _feeCode = args["feeCode"] ?? "INR";

  final String _feeCode;
  final String _amount;
  final String _feeCurrency;
  final String? _alliedOrderId;
  final String? _appointmentId;
  final String? _inhouseOrderId;
  final String _marketplaceType;
  final String _paymentGateway;
  final String _paymentSource;
  var paymentController = Get.put(PaymentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text(
          "Payment Mode",
          style: SolhTextStyles.QS_body_1_bold,
        ),
      ),
      body: ListView(shrinkWrap: true, children: [
        GetHelpDivider(),
        BillingDetailScection(
          amount: _amount.toString(),
          feeCurrency: _feeCurrency,
        ),
        GetHelpDivider(),
        CardPaymentSection(
          amount: _amount.toString(),
          currency: _feeCurrency,
          alliedOrderId: _alliedOrderId,
          appointmentId: _appointmentId,
          inhouseOrderId: _inhouseOrderId,
          marketplaceType: _marketplaceType,
          paymentGateway: _paymentGateway,
          paymentSource: _paymentSource,
          feeCode: _feeCode,
        ),
        GetHelpDivider(),
        UPIPaymentSection(),
      ]),
    );
  }
}

class BillingDetailScection extends StatelessWidget {
  const BillingDetailScection(
      {super.key, required this.amount, required this.feeCurrency});
  final String amount;
  final String? feeCurrency;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Billing Details'.tr,
            style: SolhTextStyles.QS_body_2_bold,
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Consultation Fee'.tr,
                style: SolhTextStyles.QS_cap_semi.copyWith(
                    color: SolhColors.Grey_1),
              ),
              Row(
                children: [
                  Text(
                    " $feeCurrency $amount",
                    style: SolhTextStyles.QS_cap_semi.copyWith(
                        color: SolhColors.Grey_1),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Service Fee & Taxes".tr,
            style:
                SolhTextStyles.QS_cap_semi.copyWith(color: SolhColors.Grey_1),
          ),
          Divider(
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Payable'.tr,
                style: SolhTextStyles.QS_cap_semi,
              ),
              Text(
                "$feeCurrency $amount",
                style: SolhTextStyles.QS_cap_semi,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CardPaymentSection extends StatelessWidget {
  CardPaymentSection(
      {super.key,
      required this.alliedOrderId,
      required this.amount,
      required this.appointmentId,
      required this.currency,
      required this.inhouseOrderId,
      required this.marketplaceType,
      required this.paymentGateway,
      required this.paymentSource,
      required this.feeCode});
  final String? alliedOrderId;
  final String amount;
  final String? appointmentId;
  final String currency;
  final String? inhouseOrderId;
  final String marketplaceType;
  final String paymentGateway;
  final String paymentSource;
  final String feeCode;

  PaymentManagement paymentManagement = PaymentManagement();
  PaymentController paymentController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Credit/Debit Card".tr,
            style: SolhTextStyles.QS_body_2_semi,
          ),
          Text(
            "We also accept payments through credit and debit cards. Kindly ensure that the card details provided by you shall be complete and accurate. Please note that we may use this information to ensure that the payment is successful."
                .tr,
            style:
                SolhTextStyles.QS_cap_semi.copyWith(color: SolhColors.Grey_1),
          ),
          SizedBox(
            height: 14,
          ),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                paymentController.isgettingPaymentIntent.value
                    ? SolhGreenButton(
                        child: ButtonLoadingAnimation(
                        ballColor: SolhColors.white,
                        ballSizeLowerBound: 3,
                        ballSizeUpperBound: 8,
                      ))
                    : SolhGreenButton(
                        onPressed: () {
                          paymentManagement.makePayment(
                              context: context,
                              alliedOrderId: alliedOrderId,
                              amount: amount,
                              appointmentId: appointmentId,
                              currency: currency,
                              inhouseOrderId: inhouseOrderId,
                              marketplaceType: marketplaceType,
                              paymentGateway: paymentGateway,
                              paymentSource: paymentSource,
                              feeCode: feeCode);
                        },
                        child: Text(
                          "Pay through card".tr,
                          style: SolhTextStyles.CTA
                              .copyWith(color: SolhColors.white),
                        )),
              ],
            );
          })
        ],
      ),
    );
  }
}

class UPIPaymentSection extends StatelessWidget {
  const UPIPaymentSection({super.key});
  static const String vpaId = "solhwellness95@icici";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "UPI".tr,
              style: SolhTextStyles.QS_body_2_semi,
            ),
            Text(
              "Opt for our mobile banking services for a hassle-free payment process. Kindly copy our UPI-ID and proceed with your payment"
                  .tr
                  .tr,
              style:
                  SolhTextStyles.QS_cap_semi.copyWith(color: SolhColors.Grey_1),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: 30.w,
                        width: 30.w,
                        child: Image(
                            image:
                                AssetImage("assets/images/solh_qr_ code.png"))),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 40,
                      width: 60.w,
                      decoration: BoxDecoration(
                          color: SolhColors.light_Bg_2,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: SolhColors.primary_green,
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Text(
                              vpaId,
                              style: SolhTextStyles.QS_caption_bold,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await Clipboard.setData(
                                  ClipboardData(text: vpaId));
                              Utility.showToast("Successfully copied".tr);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: SolhColors.primary_green,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(3),
                                      bottomRight: Radius.circular(3))),
                              child: Center(
                                child: Icon(
                                  Icons.copy,
                                  color: SolhColors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: 80.w,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Note:".tr,
                    style: SolhTextStyles.QS_body_2_bold,
                  ),
                  Expanded(
                    child: Text(
                      "Kindly keep a proof of your payment at hand (screenshot) and send it to +91 9667215980 or email it at info@solhapp.com"
                          .tr,
                      style: SolhTextStyles.QS_cap_semi.copyWith(
                          color: SolhColors.Grey_1),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SolhGreenBorderButton(
                  width: 60.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Done".tr),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        CupertinoIcons.check_mark,
                        size: 18,
                        color: SolhColors.primary_green,
                      ),
                    ],
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          Future.delayed(Duration(seconds: 2), (() {
                            Get.find<AppointmentController>()
                                .getUserAppointments();
                            Get.find<AppointmentController>()
                                .getAlliedBooking();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            globalNavigatorKey.currentState!.pushNamed(
                                AppRoutes.appointmentPage,
                                arguments: {});
                          }));

                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image(
                                    image: AssetImage(
                                        "assets/images/payment_successful.gif")),
                                SizedBox(height: 10.0),
                                Text(
                                  "Booked",
                                  style: SolhTextStyles.QS_body_2_bold,
                                ),
                              ],
                            ),
                          );
                        });
                  },
                ),
              ],
            ),
          ]),
    );
  }
}
