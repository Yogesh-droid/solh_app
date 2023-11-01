import '../../data/models/cart_model.dart';

class CartEntity {
  final bool? success;
  final CartList? cartList;
  final int? totalPrice;
  final int? discount;
  final int? shippingAmount;
  final int? finalPrice;

  CartEntity(
      {this.success,
      this.cartList,
      this.totalPrice,
      this.discount,
      this.shippingAmount,
      this.finalPrice});
}
