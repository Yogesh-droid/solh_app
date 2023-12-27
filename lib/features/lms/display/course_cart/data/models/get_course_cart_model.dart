import 'package:solh/features/lms/display/course_cart/domain/entities/get_course_cart_entity.dart';

class GetCourseCartModel extends GetCourseCartEntity {
  GetCourseCartModel(
      {super.success,
      super.cartList,
      super.savings,
      super.totalPrice,
      super.grandTotal});

  factory GetCourseCartModel.fromJson(Map<String, dynamic> json) {
    return GetCourseCartModel(
        success: json["success"],
        cartList: json["cartList"] == null
            ? null
            : (json["cartList"] as List)
                .map((e) => CartList.fromJson(e))
                .toList(),
        savings: json["savings"],
        totalPrice: json["totalPrice"],
        grandTotal: json["grandTotal"]);
  }
}

class CartList {
  String? id;
  String? title;
  String? thumbnail;
  int? price;
  String? currency;
  int? salePrice;

  CartList(
      {this.id,
      this.title,
      this.thumbnail,
      this.price,
      this.currency,
      this.salePrice});

  CartList.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    title = json["title"];
    thumbnail = json["thumbnail"];
    price = json["price"];
    currency = json["currency"];
    salePrice = json["salePrice"];
  }
}
