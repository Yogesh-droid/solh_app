import 'package:solh/ui/screens/products/features/order_summary/data/model/order_list_model.dart';

class UserOrderListEntity {
  String? sId;
  String? orderId;
  OrderItems? orderItem;

  UserOrderListEntity({
    this.sId,
    this.orderId,
    this.orderItem,
  });
}
