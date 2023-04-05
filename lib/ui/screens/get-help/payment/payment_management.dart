import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/profile/appointment_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/get-help/payment/payment_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class PaymentManagement {
  PaymentController paymentController = Get.find();
  Widget paymentModelSheet({
    required BuildContext context,
    required String appointmentId,
    required String? alliedOrderId,
    required String? inhouseOrderId,
    required String marketplaceType,
    required String currency,
    required String amount,
    required String paymentSource,
    required String paymentGateway,
    required String status,
  }) {
    return Container(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Payment options",
                style: SolhTextStyles.QS_body_1_bold,
              ),
            ],
          ),
        ),
        Divider(),
        InkWell(
          onTap: () {
            makePayment(
              alliedOrderId: alliedOrderId,
              amount: amount,
              appointmentId: appointmentId,
              context: context,
              currency: currency,
              inhouseOrderId: inhouseOrderId,
              marketplaceType: marketplaceType,
              paymentGateway: paymentGateway,
              paymentSource: paymentSource,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.creditcard_fill,
                  color: SolhColors.primary_green,
                  size: 16,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Credit / Debit card',
                  style: SolhTextStyles.QS_caption_bold,
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/bookNowPaylater.svg',
                color: SolhColors.primary_green,
                height: 15,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Book Now & Pay Later',
                style: SolhTextStyles.QS_caption_bold,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ]),
    );
  }

  Future<void> makePayment({
    required BuildContext context,
    required String? appointmentId,
    required String? alliedOrderId,
    required String? inhouseOrderId,
    required String marketplaceType,
    required String currency,
    required String amount,
    required String paymentSource,
    required String paymentGateway,
  }) async {
    paymentController.isgettingPaymentIntent(true);
    try {
      var paymentIntent = await createPaymentIntent(amount, "INR");
      log(paymentIntent.toString());

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  appearance: PaymentSheetAppearance(
                      primaryButton: PaymentSheetPrimaryButtonAppearance()),
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.light,
                  merchantDisplayName: 'Solh'))
          .then((value) {});
      paymentController.isgettingPaymentIntent(false);
      displayPaymentSheet(context, {
        "pgTransactionId": paymentIntent['id'],
        'appointmentId': appointmentId.toString(),
        'alliedOrderId': alliedOrderId.toString(),
        'inhouseOrderId': inhouseOrderId.toString(),
        'marketplaceType': marketplaceType,
        'currency': currency,
        'amount': amount.toString(),
        'paymentSource': paymentSource,
        'paymentGateway': paymentGateway,
        'stripeCusId': paymentIntent['customer'],
        'status': 'Success'
      });
    } catch (err) {
      throw Exception(err);
    }
  }

  createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': "${int.parse(amount) * 100}",
        'currency': "INR",
        "description":
            Get.find<ProfileController>().myProfileModel.value.body!.user!.sId,
        "mobileNo": Get.find<ProfileController>()
            .myProfileModel
            .value
            .body!
            .user!
            .mobile,
        "firstName": Get.find<ProfileController>()
            .myProfileModel
            .value
            .body!
            .user!
            .firstName,
        "lastName": Get.find<ProfileController>()
            .myProfileModel
            .value
            .body!
            .user!
            .lastName,
        "email": Get.find<ProfileController>()
                .myProfileModel
                .value
                .body!
                .user!
                .email ??
            '',
      };
      print("requested");
      //Make post request to Stripe
      var response = await Network.makePostRequestWithToken(
          url: '${APIConstants.api}/api/custom/payment/createPaymentIntent',
          body: body);

      return response['data'];
    } on SocketException {
      print("No Internet");
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet(context, Map<String, dynamic> postBody) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        //Clear paymentIntent variable after successful payment
        await Network.makeHttpPostRequestWithToken(
            url: '${APIConstants.api}/api/custom/payment/createPayment',
            body: postBody);

        showDialog(
            context: context,
            builder: (_) {
              Future.delayed(Duration(seconds: 2), (() {
                Get.find<AppointmentController>().getUserAppointments();
                Get.find<AppointmentController>().getAlliedBooking();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                globalNavigatorKey.currentState!
                    .pushNamed(AppRoutes.appointmentPage, arguments: {});
              }));

              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                        image:
                            AssetImage("assets/images/payment_successful.gif")),
                    SizedBox(height: 10.0),
                    Text(
                      "Payment Successful!",
                      style: SolhTextStyles.QS_body_2_bold,
                    ),
                  ],
                ),
              );
            });
        // paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
    } catch (e) {
      print('$e');
    }
  }
}
