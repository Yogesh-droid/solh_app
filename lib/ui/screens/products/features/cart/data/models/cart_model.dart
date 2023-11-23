import 'package:solh/ui/screens/products/features/cart/domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  CartModel(
      {super.success,
      super.cartList,
      super.totalPrice,
      super.discount,
      super.shippingAmount,
      super.finalPrice,
      super.currency,
      super.code,
      super.symbol});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        success: json["success"],
        cartList: json["cartList"] == null
            ? null
            : CartList.fromJson(json["cartList"]),
        totalPrice: json["totalPrice"],
        discount: json["discount"],
        shippingAmount: json["shippingAmount"],
        finalPrice: json["finalPrice"],
        currency: json["currency"],
        symbol: json['symbol'],
        code: json['code']);
  }
}

class CartList {
  String? id;
  String? userId;
  List<Items>? items;
  String? createdAt;
  String? updatedAt;
  int? v;

  CartList(
      {this.id,
      this.userId,
      this.items,
      this.createdAt,
      this.updatedAt,
      this.v});

  CartList.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    userId = json["userId"];
    items = json["items"] == null
        ? null
        : (json["items"] as List).map((e) => Items.fromJson(e)).toList();
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }
}

class Items {
  ProductId? productId;
  int? quantity;
  String? id;

  Items({this.productId, this.quantity, this.id});

  Items.fromJson(Map<String, dynamic> json) {
    productId = json["productId"] == null
        ? null
        : ProductId.fromJson(json["productId"]);
    quantity = json["quantity"];
    id = json["_id"];
  }
}

class ProductId {
  String? id;
  String? productName;
  List<String>? productImage;
  int? price;
  int? afterDiscountPrice;
  int? stockAvailable;
  String? defaultImage;
  String? currency;

  ProductId(
      {this.id,
      this.productName,
      this.productImage,
      this.price,
      this.afterDiscountPrice,
      this.defaultImage,
      this.currency,
      this.stockAvailable});

  ProductId.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    productName = json["productName"];
    productImage = json["productImage"] == null
        ? null
        : List<String>.from(json["productImage"]);
    price = json["price"];
    afterDiscountPrice = json["afterDiscountPrice"];
    stockAvailable = json["stockAvailable"];
    currency = json["currency"];
    defaultImage = json["defaultImage"];
  }
}
