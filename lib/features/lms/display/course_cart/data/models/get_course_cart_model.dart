import 'package:solh/features/lms/display/course_cart/domain/entities/get_course_cart_entity.dart';
import 'package:solh/features/lms/display/course_detail/data/models/course_details_model.dart';

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
  TotalDuration? totalDuration;

  CartList(
      {this.id,
      this.title,
      this.thumbnail,
      this.price,
      this.currency,
      this.salePrice,
      this.totalDuration});

  CartList.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    title = json["title"];
    thumbnail = json["thumbnail"];
    price = json["price"];
    currency = json["currency"];
    salePrice = json["salePrice"];
    totalDuration = json["totalDuration"] == null
        ? null
        : TotalDuration.fromJson(json["totalDuration"]);
  }
}
