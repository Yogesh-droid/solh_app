import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/order_summary/ui/controller/order_list_controller.dart';
import 'package:solh/ui/screens/products/features/order_summary/ui/view/widgets/order_list_card.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
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
    // TODO: implement initState
    orderListController.getOrderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
          title: Text(
            'My Order',
            style: SolhTextStyles.QS_body_1_bold,
          ),
          isLandingScreen: false,
        ),
        body: Stack(
          children: [
            Obx(() {
              return orderListController.isLoading.value
                  ? Center(
                      child: MyLoader(),
                    )
                  : OrderList();
            }),
            OrderSearchBar(),
          ],
        ));
  }
}

class OrderSearchBar extends StatelessWidget {
  OrderSearchBar({super.key});
  OrderListController orderListController = Get.find();
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
                    label: Text('All'),
                  ),
                ),
                SizedBox(
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
                    label: Text('Ordered'),
                  ),
                ),
                SizedBox(
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
                    label: Text('Delivered'),
                  ),
                ),
                SizedBox(
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
                    label: Text('Cancelled'),
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
  OrderListController orderListController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 50),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return OrderListCard(
          expectedDeliveryDate: orderListController.orderListModel.value
              .userOrderList![index].orderItems!.expectedDeliveryDate!,
          image: orderListController
              .orderListModel.value.userOrderList![index].orderItems!.image!,
          name: orderListController
              .orderListModel.value.userOrderList![index].orderItems!.name!,
          originalPrice: orderListController.orderListModel.value
              .userOrderList![index].orderItems!.originalPrice!,
          quantity: orderListController
              .orderListModel.value.userOrderList![index].orderItems!.quantity!,
          refId: orderListController
              .orderListModel.value.userOrderList![index].orderItems!.refId!,
          salePrice: orderListController.orderListModel.value
              .userOrderList![index].orderItems!.salePrice!,
          status: orderListController
              .orderListModel.value.userOrderList![index].orderItems!.status!,
        );
      },
      separatorBuilder: (context, index) {
        return GetHelpDivider();
      },
      itemCount: orderListController.orderListModel.value.userOrderList!.length,
    );
  }
}
