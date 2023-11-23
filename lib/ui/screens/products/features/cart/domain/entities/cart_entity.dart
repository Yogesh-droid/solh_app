import '../../data/models/cart_model.dart';

class CartEntity {
  final bool? success;
  final CartList? cartList;
  final int? totalPrice;
  final int? discount;
  final int? shippingAmount;
  final int? finalPrice;
  final String? currency;
  final String? code;
  final String? symbol;

  CartEntity(
      {this.success,
      this.code,
      this.symbol,
      this.cartList,
      this.totalPrice,
      this.discount,
      this.shippingAmount,
      this.finalPrice,
      this.currency});
}
