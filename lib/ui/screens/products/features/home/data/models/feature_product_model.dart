import 'package:solh/ui/screens/products/features/home/domain/entities/feature_product_entity.dart';

class FeatureProductsModel {
  bool? success;
  List<Products>? products;
  Pages? pages;
  int? totalProduct;

  FeatureProductsModel(
      {this.success, this.products, this.pages, this.totalProduct});

  FeatureProductsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    pages = json['pages'] != null ? new Pages.fromJson(json['pages']) : null;
    totalProduct = json['totalProduct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.pages != null) {
      data['pages'] = this.pages!.toJson();
    }
    data['totalProduct'] = this.totalProduct;
    return data;
  }
}

class Products extends FeatureProductsEntity {
  String? sId;
  String? productName;
  List<String>? productImage;
  int? price;
  int? afterDiscountPrice;
  int? stockAvailable;
  String? description;
  String? productQuantity;
  bool? isWishlisted;
  int? inCartCount;

  Products(
      {this.sId,
      this.productName,
      this.productImage,
      this.price,
      this.afterDiscountPrice,
      this.stockAvailable,
      this.description,
      this.isWishlisted,
      this.inCartCount,
      this.productQuantity})
      : super(
          afterDiscountPrice: afterDiscountPrice,
          description: description,
          price: price,
          productImage: productImage,
          productName: productName,
          productQuantity: productQuantity,
          sId: sId,
          isWishlisted: isWishlisted,
          inCartCount: inCartCount,
          stockAvailable: stockAvailable,
        );

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    productImage = json['productImage'].cast<String>();
    price = json['price'];
    afterDiscountPrice = json['afterDiscountPrice'];
    stockAvailable = json['stockAvailable'];
    description = json['description'];
    productQuantity = json['productQuantity'];
    inCartCount = json['inCartCount'];
    isWishlisted = json['isWishlisted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productName'] = this.productName;
    data['productImage'] = this.productImage;
    data['price'] = this.price;
    data['afterDiscountPrice'] = this.afterDiscountPrice;
    data['stockAvailable'] = this.stockAvailable;
    data['description'] = this.description;
    data['productQuantity'] = this.productQuantity;
    return data;
  }
}

class Pages {
  int? prev;
  int? next;

  Pages({this.prev, this.next});

  Pages.fromJson(Map<String, dynamic> json) {
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}
