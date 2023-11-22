import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/entity/order_detail_entity.dart';
import 'package:solh/ui/screens/products/features/order_summary/ui/controller/order_detail_controller.dart';
import 'package:solh/ui/screens/products/features/order_summary/ui/view/widgets/order_detail_shimmer.dart';
import 'package:solh/ui/screens/products/features/order_summary/ui/view/widgets/order_tracking_widget.dart';
import 'package:solh/ui/screens/products/features/order_summary/ui/view/widgets/other_order_items_widget.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';

import '../../../../../../../../widgets_constants/constants/textstyles.dart';
import '../widgets/order_product_detail_widget.dart';

class OrderDetailPage extends StatefulWidget {
  OrderDetailPage({super.key, required Map<String, dynamic> args})
      : orderId = args['orderId'],
        refId = args['refId'];
  final String orderId;
  final String refId;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final OrderDetailController orderDetailController = Get.find();
  bool isLoading = true;
  late OrderDetailEntity orderDetailEntity;
  String error = '';

  Future<void> getOrderDetails() async {
    try {
      await orderDetailController
          .getOrderDetails(id: widget.orderId, refId: widget.refId)
          .onError((error, stackTrace) => throw Exception());
      orderDetailEntity = orderDetailController.orderDetailEntity.value;
      isLoading = false;
      setState(() {});
    } on Exception catch (e) {
      isLoading = false;
      setState(() {
        error = e.toString();
      });
    }
  }

  @override
  void initState() {
    getOrderDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
            title: const Text(
              "Order Detail",
              style: SolhTextStyles.QS_body_1_bold,
            ),
            isLandingScreen: false),
        body: isLoading
            ? const OrderDetailShimmer()
            : error.isEmpty
                ? orderDetailWidget()
                : const SizedBox());
  }

  Widget orderDetailWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          orderDetails(),
          const SizedBox(height: 10),
          const GetHelpDivider(),
          const SizedBox(height: 10),
          OrderProductDetailsWidget(orderDetailEntity),
          OrderTrackingWidget(orderDetailEntity),
          const GetHelpDivider(),
          otherItemsWidget(orderDetailEntity),
        ],
      ),
    );
  }

  Widget orderDetails() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("Order Placed", style: SolhTextStyles.QS_body_semi_1),
            Text(
                DateFormat('dd-MMM-yyyy').format(DateTime.tryParse(
                    orderDetailEntity.userOrderDetails!.createdAt!)!),
                style: SolhTextStyles.QS_body_semi_1)
          ]),
          const Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("OrderId", style: SolhTextStyles.QS_body_semi_1),
            Text(orderDetailEntity.userOrderDetails!.orderId ?? '',
                style: SolhTextStyles.QS_body_semi_1)
          ]),
          const Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("Payment Mode", style: SolhTextStyles.QS_body_semi_1),
            Text(orderDetailEntity.userOrderDetails!.paymentGateway ?? '',
                style: SolhTextStyles.QS_body_semi_1)
          ])
        ],
      ),
    );
  }

  Widget otherItemsWidget(OrderDetailEntity orderDetailEntity) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(
            'Other Item in This Order',
            style: SolhTextStyles.QS_body_semi_1.copyWith(color: Colors.black),
          ),
          ...orderDetailController.orderDetailEntity.value.otherItems!
              .map((e) => InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.orderdetails,
                        arguments: {
                          'orderId': orderDetailEntity.userOrderDetails!.id,
                          'refId': e.refId
                        });
                  },
                  child: OtherOrderItemsWidget(otherItems: e)))
        ],
      ),
    );
  }
}
