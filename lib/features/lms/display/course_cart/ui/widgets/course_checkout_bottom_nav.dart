import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/features/lms/display/course_cart/ui/controllers/get_course_cart_controller.dart';
import 'package:solh/features/lms/display/course_cart/ui/controllers/make_course_order_controller.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/products/features/product_payment/data/payment_service.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class CourseCheckoutBottomNav extends StatefulWidget {
  const CourseCheckoutBottomNav({super.key, this.price, this.currency});
  final int? price;
  final String? currency;

  @override
  State<CourseCheckoutBottomNav> createState() =>
      _CourseCheckoutBottomNavState();
}

class _CourseCheckoutBottomNavState extends State<CourseCheckoutBottomNav> {
  final MakeCourseOrderController makeCourseOrderController = Get.find();
  final GetCourseCartController getCourseCartController = Get.find();
  bool isPaymentStarted = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 5, spreadRadius: 1, color: Colors.grey),
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 12),
        child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("You Pay", style: SolhTextStyles.QS_body_semi_1),
              Text("${widget.currency} ${widget.price}",
                  style: SolhTextStyles.QS_head_5.copyWith(color: Colors.black))
            ],
          ),
          const Spacer(),
          Obx(() => SolhGreenButton(
                onPressed: () => startPayment(),
                height: 40,
                child: isPaymentStarted ||
                        Get.find<MakeCourseOrderController>()
                            .isCreatingOrder
                            .value
                    ? MyLoader(
                        radius: 10,
                        strokeWidth: 2,
                      )
                    : Text("Make Payments",
                        style:
                            SolhTextStyles.CTA.copyWith(color: Colors.white)),
              ))
        ]),
      ),
    );
  }

  Future<void> startPayment() async {
    try {
      setState(() {
        isPaymentStarted = true;
      });
      final user =
          Get.find<ProfileController>().myProfileModel.value.body!.user!;
      Map<String, dynamic>? paymentIntent =
          await PaymentService.createPaymentIntent({
        'amount': "${widget.price! * 100}",
        'currency': 'inr',
        "description": user.sId,
        "mobileNo": user.mobile,
        "firstName": user.firstName,
        "lastName": user.lastName,
        "email": user.email ?? '',
      });

      List<Map<String, dynamic>> items = [];
      for (var e in getCourseCartController.cartList) {
        items.add({
          "name": e.title ?? '',
          "courseId": e.id ?? '',
          "salePrice": e.salePrice ?? '',
          "originalPrice": e.price ?? '',
          "totalDuration":
              "${e.totalDuration!.hours}hrs ${e.totalDuration!.minutes}mins",
          "image": e.thumbnail ?? ''
        });
      }

      Map<String, dynamic> body = {
        "transaction": {
          "pgTransactionId": paymentIntent['id'],
          "currency": widget.currency,
          "amount": widget.price,
          "paymentSource": "App",
          "paymentGateway": "UPI",
          "stripeCusId": paymentIntent['customer'],
          "status": "Success"
        },
        "order": {
          "totalItems": getCourseCartController.cartList.length,
          "totalBill": widget.price,
          "source": "App",
          "orderItems": items,
          "billingAddress": {
            "state": "addressController.selectedBillingAddress.value.state",
            "country": "6242b1b86fabd390bf0063fc"
          },
          "paymentGateway": "UPI",
          "currency": widget.currency,
          "paymentStatus": "Paid"
        }
      };

      displayPaymentSheet(body);
    } catch (err) {
      setState(() {
        isPaymentStarted = false;
      });
      throw Exception(err);
    }
    setState(() {
      isPaymentStarted = false;
    });
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
    await makeCourseOrderController.makeOrderRequest(postBody).then((value) {
      if (makeCourseOrderController.success.value.isNotEmpty) {
        final cartController = Get.find<GetCourseCartController>();
        cartController.cartList.clear();

        showDialog(
            context: context,
            builder: (_) {
              Future.delayed(const Duration(seconds: 3), (() {}));

              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Image(
                        image:
                            AssetImage("assets/images/payment_successful.gif")),
                    const SizedBox(height: 10.0),
                    Text(
                      makeCourseOrderController.success.value,
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
                      makeCourseOrderController.err.value,
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
