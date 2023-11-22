import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/entity/order_detail_entity.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class OrderProductDetailsWidget extends StatelessWidget {
  const OrderProductDetailsWidget(this.orderDetailEntity, {super.key});
  final OrderDetailEntity orderDetailEntity;

  @override
  Widget build(BuildContext context) {
    // final OrderDetailController orderDetailController = Get.find();
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.productDetailScreen, arguments: {
          'id': orderDetailEntity.userOrderDetails!.orderItems!.productId ?? ''
        });
      },
      child: Padding(
          padding: const EdgeInsets.all(12),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Product Details",
                style: SolhTextStyles.QS_body_semi_1.copyWith(
                    color: Colors.black)),
            const SizedBox(height: 10),
            Row(children: [
              CachedNetworkImage(
                imageUrl:
                    orderDetailEntity.userOrderDetails!.orderItems!.image ?? '',
                height: 80,
                width: 80,
                fit: BoxFit.scaleDown,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    orderDetailEntity.userOrderDetails!.orderItems!.name ?? '',
                    style: SolhTextStyles.QS_body_2_bold.copyWith(
                        color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                      "${orderDetailEntity.userOrderDetails!.orderItems!.quantity} item(s)",
                      style: SolhTextStyles.QS_caption)
                ],
              )),
              const Spacer(),
              const Icon(
                Icons.keyboard_arrow_right,
                size: 30,
                color: SolhColors.primary_green,
              )
            ])
          ])),
    );
  }
}
