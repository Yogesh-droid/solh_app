import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/course_cart/ui/controllers/country_list_controller.dart';
import 'package:solh/features/lms/display/course_cart/ui/controllers/get_course_cart_controller.dart';
import 'package:solh/features/lms/display/course_cart/ui/screens/course_items_list.dart';
import 'package:solh/features/lms/display/course_cart/ui/widgets/course_billing_widget.dart';
import 'package:solh/features/lms/display/course_cart/ui/widgets/course_checkout_bottom_nav.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/cart/ui/views/widgets/empty_cart_widget.dart';
import 'package:solh/ui/screens/products/features/product_payment/ui/widgets/payment_details.dart';
import 'package:solh/ui/screens/products/features/product_payment/ui/widgets/payment_options_tile.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class CourseCartWidget extends StatefulWidget {
  const CourseCartWidget({super.key});

  @override
  State<CourseCartWidget> createState() => _CourseCartWidgetState();
}

class _CourseCartWidgetState extends State<CourseCartWidget>
    with AutomaticKeepAliveClientMixin {
  final CountryListController countryListController = Get.find();

  @override
  void initState() {
    if (countryListController.countryList.isEmpty) {
      countryListController.getCountryList();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final GetCourseCartController getCourseCartController = Get.find();
    return Scaffold(
      bottomNavigationBar: Obx(() => getCourseCartController.isLoading.value ||
              getCourseCartController.cartList.isEmpty
          ? const SizedBox.shrink()
          : CourseCheckoutBottomNav(
              price: getCourseCartController.grandTotal.value,
              currency: getCourseCartController.cartList[0].currency)),
      body: Obx(() => getCourseCartController.isLoading.value
          ? MyLoader()
          : getCourseCartController.cartList.isEmpty
              ? const EmptyCartWidget()
              : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                    child: Column(children: [
                      // Cart Items
                      const CourseItemsList(),
                      const GetHelpDivider(),
                      const CourseBillingWidget(),
                      const GetHelpDivider(),
                      PaymentDetails(
                          total:
                              getCourseCartController.totalPrice.value.toDouble(),
                          discount: getCourseCartController.totalPrice.value
                                  .toDouble() -
                              getCourseCartController.grandTotal.value.toDouble(),
                          currencySymbol:
                              getCourseCartController.cartList[0].currency ?? '',
                          horizontalPadding: 8),
                      const GetHelpDivider(),
                      const PaymentOptionsTile(horizontalPadding: 8)
                    ]),
                  ),
              )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
