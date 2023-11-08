import 'package:solh/ui/screens/products/features/wishlist/domain/entity/product_wishlist_items_entity.dart';

class ProductWishlistModel {
  bool? success;
  List<Wishlist>? wishlist;

  ProductWishlistModel({this.success, this.wishlist});

  ProductWishlistModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['wishlist'] != null) {
      wishlist = <Wishlist>[];
      json['wishlist'].forEach((v) {
        wishlist!.add(new Wishlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.wishlist != null) {
      data['wishlist'] = this.wishlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wishlist extends ProductWishlistEntity {
  String? sId;
  String? productName;
  List<String>? productImage;
  int? price;
  int? afterDiscountPrice;
  String? currency;
  int? stockAvailable;
  String? description;
  String? productQuantity;

  Wishlist(
      {this.sId,
      this.productName,
      this.productImage,
      this.price,
      this.afterDiscountPrice,
      this.currency,
      this.stockAvailable,
      this.description,
      this.productQuantity})
      : super(
          afterDiscountPrice: afterDiscountPrice,
          currency: currency,
          description: description,
          price: price,
          productImage: productImage,
          productName: productName,
          productQuantity: productQuantity,
          sId: sId,
          stockAvailable: stockAvailable,
        );

  Wishlist.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    productImage = json['productImage'].cast<String>();
    price = json['price'];
    afterDiscountPrice = json['afterDiscountPrice'];
    currency = json['currency'];
    stockAvailable = json['stockAvailable'];
    description = json['description'];
    productQuantity = json['productQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productName'] = this.productName;
    data['productImage'] = this.productImage;
    data['price'] = this.price;
    data['afterDiscountPrice'] = this.afterDiscountPrice;
    data['currency'] = this.currency;
    data['stockAvailable'] = this.stockAvailable;
    data['description'] = this.description;
    data['productQuantity'] = this.productQuantity;
    return data;
  }
}
