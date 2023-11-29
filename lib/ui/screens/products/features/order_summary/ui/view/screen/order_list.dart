import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/order_summary/ui/controller/order_list_controller.dart';
import 'package:solh/ui/screens/products/features/order_summary/ui/view/widgets/order_list_card.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  OrderListController orderListController = Get.find();

  @override
  void initState() {
    orderListController.getOrderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
          isVideoCallScreen: true,
          title: const Text(
            'My Orders',
            style: SolhTextStyles.QS_body_1_bold,
          ),
          isLandingScreen: false,
        ),
        body: Obx(() {
          return orderListController.isLoading.value
              ? Center(
                  child: MyLoader(),
                )
              : (orderListController
                          .orderListModel.value.userOrderList!.length ==
                      0
                  ? EmptyOrderList()
                  : Stack(
                      children: [
                        OrderList(),
                        OrderSearchBar(),
                      ],
                    ));
        }));
  }
}

class EmptyOrderList extends StatelessWidget {
  const EmptyOrderList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/empty_order_list.png'),
        Text(
          "No order placed yet.",
          style: SolhTextStyles.QS_body_1_bold,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'You have not placed an order yet. Please add items to your cart and checkout when you are ready',
            style: SolhTextStyles.QS_caption,
            textAlign: TextAlign.center,
          ),
        ),
        SolhGreenMiniButton(
            onPressed: () => Navigator.of(context).pop(),
            height: 40,
            child: Text(
              'Shop Now',
              style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
            ))
      ],
    );
  }
}

class OrderSearchBar extends StatelessWidget {
  OrderSearchBar({super.key});
  final OrderListController orderListController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(
        //   height: 15,
        // ),
        // Text(
        //   'Your Order',
        //   style: SolhTextStyles.QS_body_1_bold,
        // ),
        // SizedBox(
        //   height: 15,
        // ),
        // SearchBar(
        //   elevation: MaterialStateProperty.resolveWith((states) => 0),
        //   backgroundColor: MaterialStateColor.resolveWith(
        //       (states) => Colors.grey.shade100),
        //   hintText: 'Search for Orders',
        //   hintStyle: MaterialStateProperty.resolveWith((states) =>
        //       SolhTextStyles.QS_cap_semi.copyWith(color: SolhColors.grey_2)),
        // ),
        Container(
          height: 50,
          width: double.infinity,
          color: Colors.white,
          child: Obx(() {
            return ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                  onTap: () {
                    orderListController.orderFilterStatus.value = '';
                    orderListController.getOrderList();
                  },
                  child: Chip(
                    backgroundColor:
                        orderListController.orderFilterStatus.value == ''
                            ? SolhColors.primary_green
                            : Colors.grey.shade300,
                    label: Text('All',
                        style: SolhTextStyles.CTA.copyWith(
                          color:
                              orderListController.orderFilterStatus.value == ''
                                  ? SolhColors.white
                                  : Colors.black,
                        )),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    orderListController.orderFilterStatus.value = 'placed';
                    orderListController.getOrderList(
                        status: orderListController.orderFilterStatus.value);
                  },
                  child: Chip(
                    backgroundColor:
                        orderListController.orderFilterStatus.value == 'placed'
                            ? SolhColors.primary_green
                            : Colors.grey.shade300,
                    label: Text(
                      'Ordered',
                      style: SolhTextStyles.CTA.copyWith(
                        color: orderListController.orderFilterStatus.value ==
                                'placed'
                            ? SolhColors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    orderListController.orderFilterStatus.value = 'delivered';
                    orderListController.getOrderList(
                        status: orderListController.orderFilterStatus.value);
                  },
                  child: Chip(
                    backgroundColor:
                        orderListController.orderFilterStatus.value ==
                                'delivered'
                            ? SolhColors.primary_green
                            : Colors.grey.shade300,
                    label: Text('Delivered',
                        style: SolhTextStyles.CTA.copyWith(
                          color: orderListController.orderFilterStatus.value ==
                                  'delivered'
                              ? SolhColors.white
                              : Colors.black,
                        )),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    orderListController.orderFilterStatus.value = 'cancelled';
                    orderListController.getOrderList(
                        status: orderListController.orderFilterStatus.value);
                  },
                  child: Chip(
                    backgroundColor:
                        orderListController.orderFilterStatus.value ==
                                'cancelled'
                            ? SolhColors.primary_green
                            : Colors.grey.shade300,
                    label: Text('Cancelled',
                        style: SolhTextStyles.CTA.copyWith(
                          color: orderListController.orderFilterStatus.value ==
                                  'cancelled'
                              ? SolhColors.white
                              : Colors.black,
                        )),
                  ),
                ),
              ],
            );
          }),
        )
      ],
    );
  }
}

class OrderList extends StatelessWidget {
  OrderList({super.key});
  final OrderListController orderListController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 50),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.orderdetails, arguments: {
              'orderId': orderListController
                  .orderListModel.value.userOrderList![index].sId,
              'refId': orderListController
                  .orderListModel.value.userOrderList![index].orderItems!.refId
            });
          },
          child: OrderListCard(
            expectedDeliveryDate: orderListController.orderListModel.value
                .userOrderList![index].orderItems!.expectedDeliveryDate!,
            image: orderListController
                .orderListModel.value.userOrderList![index].orderItems!.image!,
            name: orderListController
                .orderListModel.value.userOrderList![index].orderItems!.name!,
            originalPrice: orderListController.orderListModel.value
                .userOrderList![index].orderItems!.originalPrice!,
            quantity: orderListController.orderListModel.value
                .userOrderList![index].orderItems!.quantity!,
            refId: orderListController
                .orderListModel.value.userOrderList![index].orderItems!.refId!,
            salePrice: orderListController.orderListModel.value
                .userOrderList![index].orderItems!.salePrice!,
            status: orderListController
                .orderListModel.value.userOrderList![index].orderItems!.status!,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const GetHelpDivider();
      },
      itemCount: orderListController.orderListModel.value.userOrderList!.length,
    );
  }
}
