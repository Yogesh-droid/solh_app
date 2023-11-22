import '../../data/model/order_detail_model.dart';

class OrderDetailEntity {
  final bool? success;
  final String? message;
  final UserOrderDetails? userOrderDetails;
  final List<OtherItems>? otherItems;

  OrderDetailEntity(
      {this.success, this.message, this.userOrderDetails, this.otherItems});
}
