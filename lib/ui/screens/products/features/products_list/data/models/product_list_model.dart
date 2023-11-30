import 'package:solh/ui/screens/products/features/products_list/domain/entities/product_list_entity.dart';

class ProductListModel extends ProductListEntity {
  ProductListModel(
      {bool? success,
      List<Products>? products,
      Pages? pages,
      int? totalProduct})
      : super(
            pages: pages,
            products: products,
            success: success,
            totalProduct: totalProduct);

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
        success: json["success"],
        products: json["products"] == null
            ? null
            : (json["products"] as List)
                .map((e) => Products.fromJson(e))
                .toList(),
        pages: json["pages"] == null ? null : Pages.fromJson(json["pages"]),
        totalProduct: json["totalProduct"]);
  }
}

class Pages {
  dynamic prev;
  dynamic next;

  Pages({this.prev, this.next});

  Pages.fromJson(Map<String, dynamic> json) {
    prev = json["prev"];
    next = json["next"];
  }
}

class Products {
  String? id;
  String? productName;
  List<String>? productImage;
  int? price;
  int? afterDiscountPrice;
  int? stockAvailable;
  String? productQuantity;
  bool? isWishlisted;
  int? inCartCount;
  String? currency;
  String? description;
  String? shortDescription;
  String? defaultImage;

  Products(
      {this.id,
      this.productName,
      this.productImage,
      this.price,
      this.afterDiscountPrice,
      this.stockAvailable,
      this.isWishlisted,
      this.inCartCount,
      this.currency,
      this.description,
      this.shortDescription,
      this.defaultImage,
      this.productQuantity});

  Products.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    productName = json["productName"];
    productImage = json["productImage"] == null
        ? null
        : List<String>.from(json["productImage"]);
    price = json["price"];
    afterDiscountPrice = json["afterDiscountPrice"];
    stockAvailable = json["stockAvailable"];
    productQuantity = json["productQuantity"];
    inCartCount = json['inCartCount'];
    isWishlisted = json['isWishlisted'];
    currency = json['currency'];
    defaultImage = json['defaultImage'];
    description = json['description'];
    shortDescription = json['shortDescription'];
  }
}
