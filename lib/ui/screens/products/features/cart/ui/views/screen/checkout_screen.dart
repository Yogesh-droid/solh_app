import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/address_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/controllers/cart_controller.dart';
import 'package:solh/ui/screens/products/features/cart/ui/views/widgets/cart_address.dart';
import 'package:solh/ui/screens/products/features/cart/ui/views/widgets/empty_cart_widget.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/sheet_cart_item.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/default_org.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../../../../../../../../routes/routes.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({super.key, required Map<String, dynamic> args})
      : onDecreaseCartCount = args['onDecrease'],
        onIncreaseCartCount = args['onIncrease'];

  final Function(int index, String id, int quantity) onIncreaseCartCount;
  final Function(int index, String id, int quantity) onDecreaseCartCount;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return Scaffold(
        appBar: SolhAppBar(
          isLandingScreen: false,
          title: const Text(
            'Your Cart',
            style: SolhTextStyles.QS_body_1_bold,
          ),
        ),
        body: Obx(() => cartController.cartEntity.value.cartList != null
            ? cartController.cartEntity.value.cartList!.items!.isNotEmpty
                ? Stack(
                    children: [
                      ListView(
                        children: [
                          const CartAddress(),
                          const GetHelpDivider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${cartController.cartEntity.value.cartList!.items!.length} Items in your cart",
                                  style: SolhTextStyles.QS_body_2_semi,
                                )
                              ],
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: cartController
                                .cartEntity.value.cartList!.items!.length,
                            separatorBuilder: (context, index) {
                              return const GetHelpDivider();
                            },
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: SheetCartItem(
                                    image: cartController
                                            .cartEntity
                                            .value
                                            .cartList!
                                            .items![index]
                                            .productId!
                                            .defaultImage ??
                                        '',
                                    id: cartController
                                            .cartEntity
                                            .value
                                            .cartList!
                                            .items![index]
                                            .productId!
                                            .id ??
                                        '',
                                    discountedPrice: cartController
                                        .cartEntity
                                        .value
                                        .cartList!
                                        .items![index]
                                        .productId!
                                        .afterDiscountPrice,
                                    currency: cartController
                                        .cartEntity
                                        .value
                                        .cartList!
                                        .items![index]
                                        .productId!
                                        .currency,
                                    inCartNo: cartController.cartEntity.value
                                        .cartList!.items![index].quantity,
                                    itemPrice: cartController
                                        .cartEntity
                                        .value
                                        .cartList!
                                        .items![index]
                                        .productId!
                                        .price,
                                    productName: cartController
                                        .cartEntity
                                        .value
                                        .cartList!
                                        .items![index]
                                        .productId!
                                        .productName,
                                    onIncreaseCartCount: () {
                                      widget.onIncreaseCartCount(
                                          index,
                                          cartController
                                              .cartEntity
                                              .value
                                              .cartList!
                                              .items![index]
                                              .productId!
                                              .id!,
                                          cartController
                                              .cartEntity
                                              .value
                                              .cartList!
                                              .items![index]
                                              .quantity!);
                                    },
                                    onDecreaseCartCount: () {
                                      widget.onDecreaseCartCount(
                                          index,
                                          cartController
                                              .cartEntity
                                              .value
                                              .cartList!
                                              .items![index]
                                              .productId!
                                              .id!,
                                          cartController
                                              .cartEntity
                                              .value
                                              .cartList!
                                              .items![index]
                                              .quantity!);
                                    },
                                    onDeleteItem: () {
                                      widget.onDecreaseCartCount(
                                          index,
                                          cartController
                                              .cartEntity
                                              .value
                                              .cartList!
                                              .items![index]
                                              .productId!
                                              .id!,
                                          1);
                                    },
                                  ));
                            },
                          ),
                          const GetHelpDivider(),
                          const PaymentSummarySection(),
                          const SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                      const Positioned(
                          bottom: 0, right: 0, left: 0, child: CheckoutButton())
                    ],
                  )
                : const EmptyCartWidget()
            : const EmptyCartWidget()));
  }
}

class PaymentSummarySection extends StatelessWidget {
  const PaymentSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment Summary',
              style: SolhTextStyles.QS_body_semi_1.copyWith(
                  color: SolhColors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Total',
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.dark_grey),
                ),
                Text(
                  "${cartController.cartEntity.value.currency} ${cartController.totalPayblePrice}",
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.dark_grey),
                )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Items Discount',
                    style: SolhTextStyles.QS_body_semi_1.copyWith(
                        color: SolhColors.dark_grey)),
                Text(
                  '- ${cartController.cartEntity.value.currency} ${cartController.cartEntity.value.discount}',
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.dark_grey),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping Charge',
                    style: SolhTextStyles.QS_body_semi_1.copyWith(
                        color: SolhColors.dark_grey)),
                Text(
                    '${cartController.cartEntity.value.currency} ${cartController.cartEntity.value.shippingAmount}',
                    style: SolhTextStyles.QS_body_semi_1.copyWith(
                        color: SolhColors.dark_grey)),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price',
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.black),
                ),
                Text(
                  '${cartController.cartEntity.value.currency} ${(cartController.totalPayblePrice.value) + (cartController.cartEntity.value.shippingAmount!) - (cartController.cartEntity.value.discount!)}',
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: SolhColors.black),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    final AddressController addressController = Get.find();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      height: 80,
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(8), topLeft: Radius.circular(8)),
          color: SolhColors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(blurRadius: 2, spreadRadius: 2, color: Colors.black26)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Total Price",
                style: SolhTextStyles.QS_body_semi_1,
              ),
              Obx(() => Text(
                    "${cartController.cartEntity.value.currency} ${(cartController.totalPayblePrice.value) + (cartController.cartEntity.value.shippingAmount!) - (cartController.cartEntity.value.discount!)}",
                    style: SolhTextStyles.QS_head_5.copyWith(
                        color: SolhColors.black),
                  )),
            ],
          ),
          SolhGreenMiniButton(
            onPressed: () {
              if (addressController.addressEntity.value.addressList == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please add your address")));
                return;
              }
              if (addressController.addressEntity.value.addressList!.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please choose your address")));
                return;
              }
              Navigator.pushNamed(context, AppRoutes.productPaymentPage,
                  arguments: {
                    "totalPrice": cartController.totalPayblePrice.value,
                    "shipping": cartController.cartEntity.value.shippingAmount,
                    "discount": cartController.cartEntity.value.discount,
                    "feeCurrency": cartController.cartEntity.value.symbol,
                    "appointmentId": null,
                    "inhouseOrderId": null,
                    "marketplaceType": "Allied",
                    'organisation': DefaultOrg.defaultOrg ?? '',
                    "paymentGateway": "Stripe",
                    "paymentSource": "App",
                    "feeCode": cartController.cartEntity.value.code
                  });
            },
            child: Text(
              'Checkout',
              style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
            ),
          )
        ],
      ),
    );
  }
}
