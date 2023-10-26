import 'package:solh/ui/screens/products/features/products_list/domain/entities/featuredProduct_list_entity.dart';

class FeaturedProductListModel extends FeaturedProductListEntity {
  FeaturedProductListModel(
      {bool? success,
      List<FeaturedProducts>? featuredProducts,
      Pages? pages,
      int? totalProduct})
      : super(
            featuredProducts: featuredProducts,
            pages: pages,
            success: success,
            totalProduct: totalProduct);

  factory FeaturedProductListModel.fromJson(Map<String, dynamic> json) {
    return FeaturedProductListModel(
        success: json["success"],
        featuredProducts: json["products"] == null
            ? null
            : (json["products"] as List)
                .map((e) => FeaturedProducts.fromJson(e))
                .toList(),
        pages: json["pages"] == null ? null : Pages.fromJson(json["pages"]),
        totalProduct: json["totalProduct"]);
  }
}

class Pages {
  int? prev;
  dynamic next;

  Pages({this.prev, this.next});

  Pages.fromJson(Map<String, dynamic> json) {
    prev = json["prev"];
    next = json["next"];
  }
}

class FeaturedProducts {
  String? id;
  String? productName;
  List<String>? productImage;
  int? price;
  int? afterDiscountPrice;
  int? stockAvailable;
  String? productQuantity;

  FeaturedProducts(
      {this.id,
      this.productName,
      this.productImage,
      this.price,
      this.afterDiscountPrice,
      this.stockAvailable,
      this.productQuantity});

  FeaturedProducts.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    productName = json["productName"];
    productImage = json["productImage"] == null
        ? null
        : List<String>.from(json["productImage"]);
    price = json["price"];
    afterDiscountPrice = json["afterDiscountPrice"];
    stockAvailable = json["stockAvailable"];
    productQuantity = json["productQuantity"];
  }
}
