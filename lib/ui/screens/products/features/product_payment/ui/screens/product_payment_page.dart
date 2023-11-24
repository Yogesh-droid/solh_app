import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/address_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/ui/screens/products/features/product_payment/ui/widgets/payment_details.dart';
import 'package:solh/ui/screens/products/features/product_payment/ui/widgets/payment_options_tile.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../../../../../../../controllers/profile/profile_controller.dart';

class ProductPaymentPage extends StatefulWidget {
  const ProductPaymentPage({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  State<ProductPaymentPage> createState() => _ProductPaymentPageState();
}

class _ProductPaymentPageState extends State<ProductPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          "Payment Mode",
          style: SolhTextStyles.QS_body_1_bold,
        ),
        isLandingScreen: false,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //paymentDetails(),
        PaymentDetails(
            total: double.parse(widget.args['totalPrice'].toString()),
            discount: double.parse(widget.args['discount'].toString()),
            shipping: double.parse(widget.args['shipping'].toString())),
        SizedBox(height: 10),
        GetHelpDivider(),
        PaymentOptionsTile(),
        Spacer(),
        Padding(
          padding: const EdgeInsets.all(24),
          child: SolhGreenButton(
            onPressed: () {
              // launchUrl(Uri.parse(
              // 'upi://pay?pa=dinesh@dlanzer&pn=Dinesh&am=1&tn=Test Payment&cu=INR'));

              double amount = widget.args['totalPrice'] -
                  widget.args['discount'] +
                  widget.args['shipping'];
              startPayment(
                  amount: '${amount.toInt()}',
                  currency: "INR",
                  feeCode: "inr",
                  paymentGateway: "Stripe",
                  paymentSource: "App");
            },
            child: Text(
              "Make Payment",
              style: SolhTextStyles.CTA.copyWith(color: Colors.white),
            ),
            height: 40,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ]),
    );
  }

  Future<void> startPayment({
    required String currency,
    required String amount,
    required String paymentSource,
    required String paymentGateway,
    required String feeCode,
  }) async {
    // paymentController.isgettingPaymentIntent(true);
    try {
      print(feeCode);
      var paymentIntent = await createPaymentIntent(amount, "$feeCode");
      log(paymentIntent.toString());

      final CartController _cartController = Get.find();
      final AddressController _addressController = Get.find();

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              appearance: PaymentSheetAppearance(
                  primaryButton: PaymentSheetPrimaryButtonAppearance()),
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              style: ThemeMode.dark,
              billingDetails: BillingDetails(
                  address: Address(
                      city: null,
                      country: 'IN',
                      line1: null,
                      line2: null,
                      postalCode: null,
                      state: null)),
              merchantDisplayName: 'Solh'));

      Map<String, dynamic> _body = {
        "transaction": {
          "pgTransactionId": paymentIntent['id'],
          "currency": currency,
          "amount": amount,
          "paymentSource": paymentSource,
          "paymentGateway": paymentGateway,
          "stripeCusId": paymentIntent['customer'],
          "status": "Success"
        },
        "order": {
          "shippingCharges": (widget.args['shipping']),
          "totalItems":
              _cartController.cartEntity.value.cartList!.items!.length,
          "totalBill": widget.args['totalPrice'],
          "source": "App",
          "orderItems": _cartController.cartEntity.value.cartList!.items!
              .map((e) => {
                    "name": e.productId!.productName ?? '',
                    "product_id": e.productId!.id ?? '',
                    "salePrice": e.productId!.afterDiscountPrice ?? 0,
                    "originalPrice": e.productId!.price ?? 0,
                    "quantity": e.quantity ?? 0,
                    "image": e.productId!.productImage![0]
                  })
              .toList(),
          "shippingAddress": {
            "fullName": _addressController.selectedAddress.value.fullName,
            "phoneNumber": _addressController.selectedAddress.value.phoneNumber,
            "buildingName":
                _addressController.selectedAddress.value.buildingName,
            "street": _addressController.selectedAddress.value.street,
            "city": _addressController.selectedAddress.value.city,
            "state": _addressController.selectedAddress.value.state,
            "postalCode": _addressController.selectedAddress.value.postalCode,
            "landmark": _addressController.selectedAddress.value.landmark,
            "country": "6242b1b86fabd390bf0063fc"
          },
          "billingAddress": {
            "fullName":
                _addressController.selectedBillingAddress.value.fullName,
            "phoneNumber":
                _addressController.selectedBillingAddress.value.phoneNumber,
            "buildingName":
                _addressController.selectedBillingAddress.value.buildingName,
            "street": _addressController.selectedBillingAddress.value.street,
            "city": _addressController.selectedBillingAddress.value.city,
            "state": _addressController.selectedBillingAddress.value.state,
            "postalCode":
                _addressController.selectedBillingAddress.value.postalCode,
            "landmark":
                _addressController.selectedBillingAddress.value.landmark,
            "country": "6242b1b86fabd390bf0063fc"
          },
          "paymentGateway": "UPI",
          "currency": "₹",
          "paymentStatus": "Paid"
        }
      };

      displayPaymentSheet(context, _body);
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
        'currency': currency,
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
        log("this is output ${value.toString()}");
        makeOrderRequest(postBody);
      }).onError((error, stackTrace) {
        if (error is StripeException) {
          throw StripeException(error: error.error);
        }
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print("In Stripe Exception");
      Utility.showToast(e.error.message ?? '');
    } catch (e) {
      print('$e');
    }
  }

  Future<void> makeOrderRequest(Map<String, dynamic> postBody) async {
    try {
      Map<String, dynamic> response = await Network.makePostRequestWithToken(
          isEncoded: true,
          url: '${APIConstants.api}/api/product/order-product',
          body: postBody);

      if (response["success"]) {
        final cartController = Get.find<CartController>();
        cartController.cartEntity.value.cartList!.items!.clear();
        cartController.cartEntity.refresh();

        showDialog(
            context: context,
            builder: (_) {
              Future.delayed(Duration(seconds: 3), (() {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.orderListScreen, (route) {
                  log("This is route ${route.settings.name}");
                  return route.settings.name == AppRoutes.master;
                });
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
                      response['message'],
                      style: SolhTextStyles.QS_body_2_bold,
                    ),
                  ],
                ),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (_) {
              // Future.delayed(Duration(seconds: 3), (() {
              //   Navigator.of(context).pop();
              //   Navigator.of(context).pop();
              //   Navigator.of(context).pop();
              // }));

              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.warning_amber_rounded, size: 40),
                    SizedBox(height: 10.0),
                    Text(
                      response['message'],
                      style: SolhTextStyles.QS_body_2_bold,
                    ),
                  ],
                ),
              );
            });
      }
    } on SocketException {
      Utility.showToast("Something went wrong with your network");
    } on Exception catch (e) {
      Utility.showToast(e.toString());
    }
  }
}
