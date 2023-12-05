import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/products/features/order_summary/data/model/order_detail_model.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/entity/order_detail_entity.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class OrderTrackingWidget extends StatelessWidget {
  const OrderTrackingWidget(this.orderEntity, {super.key});
  final OrderDetailEntity orderEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order Tracking",
              style:
                  SolhTextStyles.QS_body_semi_1.copyWith(color: Colors.black)),
          const SizedBox(height: 20),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                orderEntity.userOrderDetails!.orderItems!.tracker!.length,
            itemBuilder: (context, index) {
              return step(
                  e: orderEntity.userOrderDetails!.orderItems!.tracker![index],
                  isLast: index ==
                      orderEntity
                              .userOrderDetails!.orderItems!.tracker!.length -
                          1);
            },
          ),
          const SizedBox(height: 10),
          if (orderEntity.canCancel != null && orderEntity.canCancel!)
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.cancelOrderPage,
                    arguments: {"orderDetailEntity": orderEntity});
              },
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
              title: Text("Cancel Order",
                  style: SolhTextStyles.QS_body_semi_1.copyWith(
                      color: Colors.black)),
              trailing: const Icon(
                Icons.keyboard_arrow_right_rounded,
                color: SolhColors.primary_green,
              ),
            )
        ],
      ),
    );
  }

  Widget step({required Tracker e, required bool isLast}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(height: 5),
            Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: e.isShow!
                        ? SolhColors.primary_green
                        : SolhColors.grey)),
            if (!isLast)
              Container(
                height: 60,
                width: 3,
                color: e.isShow! ? SolhColors.primary_green : SolhColors.grey,
              )
          ],
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              e.status ?? '',
              style:
                  SolhTextStyles.QS_body_2_semi.copyWith(color: Colors.black),
            ),
            if (e.createdAt != null)
              Text(DateFormat('hh:mm a, dd MMMM, yyyy').format(
                  DateTime.tryParse(e.createdAt ?? '') ?? DateTime.now())),
          ],
        )
      ],
    );
  }
}
