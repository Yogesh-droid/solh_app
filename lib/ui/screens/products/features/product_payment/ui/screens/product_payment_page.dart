import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/address_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/ui/screens/products/features/product_payment/data/payment_service.dart';
import 'package:solh/ui/screens/products/features/product_payment/ui/controllers/make_order_controller.dart';
import 'package:solh/ui/screens/products/features/product_payment/ui/widgets/payment_details.dart';
import 'package:solh/ui/screens/products/features/product_payment/ui/widgets/payment_options_tile.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../../../../../../../controllers/profile/profile_controller.dart';

class ProductPaymentPage extends StatefulWidget {
  const ProductPaymentPage({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  State<ProductPaymentPage> createState() => _ProductPaymentPageState();
}

class _ProductPaymentPageState extends State<ProductPaymentPage> {
  bool isPaymentStarted = false;
  final MakeOrderController makeOrderController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isVideoCallScreen: true,
        title: const Text(
          "Payment Mode",
          style: SolhTextStyles.QS_body_1_bold,
        ),
        isLandingScreen: false,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //paymentDetails(),
        PaymentDetails(
            total: double.parse(widget.args['finalPrice'].toString()),
            discount: double.parse(widget.args['discount'].toString()),
            shipping: double.parse(widget.args['shipping'].toString()),
            currencySymbol: widget.args['currency']),
        const SizedBox(height: 10),
        const GetHelpDivider(),
        const PaymentOptionsTile(),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(24),
          child: SolhGreenButton(
              onPressed: () async {
                // launchUrl(Uri.parse(
                // 'upi://pay?pa=dinesh@dlanzer&pn=Dinesh&am=1&tn=Test Payment&cu=INR'));

                double amount = widget.args['totalPrice'];
                setState(() {
                  isPaymentStarted = true;
                });
                await startPayment(
                        amount: '${amount.toInt()}',
                        currency: widget.args['feeCode'],
                        feeCode:
                            widget.args['feeCode'].toString().toLowerCase(),
                        paymentGateway: "Stripe",
                        paymentSource: "App")
                    .onError((error, stackTrace) {
                  setState(() {
                    isPaymentStarted = false;
                  });
                });

                setState(() {
                  isPaymentStarted = false;
                });
              },
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: Obx(() => isPaymentStarted ||
                      Get.find<MakeOrderController>().isCreatingOrder.value
                  ? MyLoader(
                      radius: 10,
                      strokeWidth: 2,
                    )
                  : Text(
                      "Make Payment",
                      style: SolhTextStyles.CTA.copyWith(color: Colors.white),
                    ))),
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
      final user =
          Get.find<ProfileController>().myProfileModel.value.body!.user!;
      Map<String, dynamic>? paymentIntent =
          await PaymentService.createPaymentIntent({
        'amount': "${int.parse(amount) * 100}",
        'currency': currency,
        "description": user.sId,
        "mobileNo": user.mobile,
        "firstName": user.firstName,
        "lastName": user.lastName,
        "email": user.email ?? '',
      });

      final CartController cartController = Get.find();
      final AddressController addressController = Get.find();

      List<Map<String, dynamic>> items = [];
      for (var e in cartController.cartEntity.value.cartList!.items!) {
        if (!e.isOutOfStock!) {
          items.add({
            "name": e.productId!.productName ?? '',
            "product_id": e.productId!.id ?? '',
            "salePrice": e.productId!.afterDiscountPrice ?? 0,
            "originalPrice": e.productId!.price ?? 0,
            "quantity": e.quantity ?? 0,
            "image": e.productId!.productImage![0],
            "shortDescription": e.productId!.shortDescription
          });
        }
      }
      Map<String, dynamic> body = {
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
          "totalItems": cartController.cartEntity.value.cartList!.items!.length,
          "totalBill": widget.args['totalPrice'],
          "source": "App",
          "orderItems": items,
          "shippingAddress": {
            "fullName": addressController.selectedAddress.value.fullName,
            "phoneNumber": addressController.selectedAddress.value.phoneNumber,
            "buildingName":
                addressController.selectedAddress.value.buildingName,
            "street": addressController.selectedAddress.value.street,
            "city": addressController.selectedAddress.value.city,
            "state": addressController.selectedAddress.value.state,
            "postalCode": addressController.selectedAddress.value.postalCode,
            "landmark": addressController.selectedAddress.value.landmark,
            "country": "6242b1b86fabd390bf0063fc"
          },
          "billingAddress": {
            "fullName": addressController.selectedBillingAddress.value.fullName,
            "phoneNumber":
                addressController.selectedBillingAddress.value.phoneNumber,
            "buildingName":
                addressController.selectedBillingAddress.value.buildingName,
            "street": addressController.selectedBillingAddress.value.street,
            "city": addressController.selectedBillingAddress.value.city,
            "state": addressController.selectedBillingAddress.value.state,
            "postalCode":
                addressController.selectedBillingAddress.value.postalCode,
            "landmark": addressController.selectedBillingAddress.value.landmark,
            "country": "6242b1b86fabd390bf0063fc"
          },
          "paymentGateway": "Stripe",
          "currency": "₹",
          "paymentStatus": "Paid"
        }
      };

      displayPaymentSheet(body);
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet(Map<String, dynamic> postBody) async {
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
      Utility.showToast(e.error.message ?? '');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> makeOrderRequest(Map<String, dynamic> postBody) async {
    await makeOrderController.makeOrderRequest(postBody).then((value) {
      if (makeOrderController.success.value.isNotEmpty) {
        final cartController = Get.find<CartController>();
        cartController.cartEntity.value.cartList!.items!.clear();
        cartController.cartEntity.refresh();

        showDialog(
            context: context,
            builder: (_) {
              Future.delayed(const Duration(seconds: 3), (() {
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
                    const Image(
                        image:
                            AssetImage("assets/images/payment_successful.gif")),
                    const SizedBox(height: 10.0),
                    Text(
                      makeOrderController.success.value,
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
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.warning_amber_rounded, size: 40),
                    const SizedBox(height: 10.0),
                    Text(
                      makeOrderController.err.value,
                      style: SolhTextStyles.QS_body_2_bold,
                    ),
                  ],
                ),
              );
            });
      }
    });
  }
}
