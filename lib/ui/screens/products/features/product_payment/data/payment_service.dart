import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../../../constants/api.dart';
import '../../../../../../services/network/network.dart';

class PaymentService {
  static Future<Map<String, dynamic>> createPaymentIntent(
      Map<String, dynamic> body) async {
    try {
      var response = await Network.makePostRequestWithToken(
          url: '${APIConstants.api}/api/custom/payment/createPaymentIntent',
          body: body);
      await initPayment(response['data']['client_secret']);

      return response['data'];
    } on SocketException {
      throw Exception("Internet is slow or connection interrupted");
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  static Future<void> initPayment(String paymentSecret) async {
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            appearance: const PaymentSheetAppearance(
                primaryButton: PaymentSheetPrimaryButtonAppearance()),
            paymentIntentClientSecret: paymentSecret,
            style: ThemeMode.dark,
            billingDetails: const BillingDetails(
                address: Address(
                    city: null,
                    country: 'IN',
                    line1: null,
                    line2: null,
                    postalCode: null,
                    state: null)),
            merchantDisplayName: 'Solh'));
  }
}
