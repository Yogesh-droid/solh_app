import '../../data/models/get_course_cart_model.dart';

class GetCourseCartEntity {
  final bool? success;
  final List<CartList>? cartList;
  final int? savings;
  final int? totalPrice;
  final int? grandTotal;

  GetCourseCartEntity(
      {this.success,
      this.cartList,
      this.savings,
      this.totalPrice,
      this.grandTotal});
}
