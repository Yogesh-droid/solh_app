import '../../domain/entities/product_detail_entity.dart';

class ProductDetailModel {
  bool? success;
  Product? product;

  ProductDetailModel({this.success, this.product});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    product =
        json["product"] == null ? null : Product.fromJson(json["product"]);
  }
}

class Product extends ProductDetailEntity {
  Product(
      {String? id,
      String? productName,
      List<String>? productImage,
      ProductCategory? productCategory,
      List<ProductSubCategory>? productSubCategory,
      int? price,
      String? authorName,
      String? publisherName,
      String? language,
      String? isbn,
      double? rating,
      String? currency,
      int? stockAvailable,
      String? description,
      String? productQuantity,
      int? v,
      List<dynamic>? reviews,
      List<RelatedProducts>? releatedProduct})
      : super(authorName: authorName);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      productName: json["productName"],
      productImage: json["productImage"] == null
          ? null
          : List<String>.from(json["productImage"]),
      productCategory: json["productCategory"] == null
          ? null
          : ProductCategory.fromJson(json["productCategory"]),
      productSubCategory: json["productSubCategory"] == null
          ? null
          : (json["productSubCategory"] as List)
              .map((e) => ProductSubCategory.fromJson(e))
              .toList(),
      price: json["price"],
      authorName: json["authorName"],
      publisherName: json["publisherName"],
      language: json["language"],
      isbn: json["isbn"],
      rating: json["rating"],
      currency: json["currency"],
      stockAvailable: json["stockAvailable"],
      description: json["description"],
      productQuantity: json["productQuantity"],
      reviews: json["reviews"] ?? [],
      releatedProduct: json["releatedProduct"] == null
          ? null
          : (json["releatedProduct"] as List)
              .map((e) => RelatedProducts.fromJson(e))
              .toList(),
    );
  }
}

class ProductSubCategory {
  String? id;
  String? categoryName;

  ProductSubCategory({this.id, this.categoryName});

  ProductSubCategory.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    categoryName = json["categoryName"];
  }
}

class ProductCategory {
  String? id;
  String? categoryName;

  ProductCategory({this.id, this.categoryName});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    categoryName = json["categoryName"];
  }
}

class RelatedProducts {
  String? sId;
  String? productName;
  List<String>? productImage;
  ProductCategory? productCategory;
  List<ProductSubCategory>? productSubCategory;
  int? price;
  String? authorName;
  String? publisherName;
  String? language;
  String? isbn;
  double? rating;
  String? currency;
  int? stockAvailable;
  String? description;
  String? productQuantity;

  RelatedProducts(
      {this.sId,
      this.productName,
      this.productImage,
      this.productCategory,
      this.productSubCategory,
      this.price,
      this.authorName,
      this.publisherName,
      this.language,
      this.isbn,
      this.rating,
      this.currency,
      this.stockAvailable,
      this.description,
      this.productQuantity});

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    productImage = json['productImage'].cast<String>();
    productCategory = json['productCategory'] != null
        ? new ProductCategory.fromJson(json['productCategory'])
        : null;
    if (json['productSubCategory'] != null) {
      productSubCategory = <ProductSubCategory>[];
      json['productSubCategory'].forEach((v) {
        productSubCategory!.add(new ProductSubCategory.fromJson(v));
      });
    }
    price = json['price'];
    authorName = json['authorName'];
    publisherName = json['publisherName'];
    language = json['language'];
    isbn = json['isbn'];
    rating = json['rating'];
    currency = json['currency'];
    stockAvailable = json['stockAvailable'];
    description = json['description'];
    productQuantity = json['productQuantity'];
  }
}
