import 'package:solh/ui/screens/products/features/product_detail/domain/entities/product_detail_entity.dart';

class ProductDetailsModel {
  bool? success;
  Product? product;
  List<Reviews>? reviews;
  int? overAllRating;

  ProductDetailsModel(
      {this.success, this.product, this.reviews, this.overAllRating});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    product =
        json["product"] == null ? null : Product.fromJson(json["product"]);
    reviews = json["reviews"] == null
        ? null
        : (json["reviews"] as List).map((e) => Reviews.fromJson(e)).toList();
    overAllRating = json["overAllRating"];
  }
}

class Reviews {
  String? id;
  String? review;
  int? rating;
  UserId? userId;

  Reviews({this.id, this.review, this.rating, this.userId});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    review = json["review"];
    rating = json["rating"];
    userId = json["userId"] == null ? null : UserId.fromJson(json["userId"]);
  }
}

class UserId {
  String? sId;
  String? name;
  String? profilePicture;
  String? id;

  UserId({this.id, this.name, this.profilePicture, this.sId});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json["_id"];
    name = json["name"];
    profilePicture = json["profilePicture"];
    id = json["id"];
  }
}

class Product extends ProductDetailEntity {
  Product(
      {String? id,
      String? productName,
      List<String>? productImage,
      ProductCategory? productCategory,
      List<ProductSubCategory>? productSubCategory,
      List<RelatedProducts>? relatedProducts,
      int? price,
      int? afterDiscountPrice,
      String? slug,
      String? authorName,
      String? publisherName,
      String? language,
      String? isbn,
      int? rating,
      String? currency,
      int? stockAvailable,
      String? description,
      String? medicineType,
      String? productQuantity,
      int? v})
      : super(
            afterDiscountPrice: afterDiscountPrice,
            authorName: authorName,
            currency: currency,
            description: description,
            id: id,
            isbn: isbn,
            language: language,
            medicineType: medicineType,
            price: price,
            productCategory: productCategory,
            productImage: productImage,
            productName: productName,
            productQuantity: productQuantity,
            productSubCategory: productSubCategory,
            publisherName: publisherName,
            rating: rating,
            relatedProducts: relatedProducts,
            slug: slug,
            stockAvailable: stockAvailable,
            v: v);

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
      relatedProducts: json["relatedProducts"] == null
          ? null
          : (json["relatedProducts"] as List)
              .map((e) => RelatedProducts.fromJson(e))
              .toList(),
      price: json["price"],
      afterDiscountPrice: json["afterDiscountPrice"],
      slug: json["slug"],
      authorName: json["authorName"],
      publisherName: json["publisherName"],
      language: json["language"],
      isbn: json["isbn"],
      rating: json["rating"],
      currency: json["currency"],
      stockAvailable: json["stockAvailable"],
      description: json["description"],
      medicineType: json["medicineType"],
      productQuantity: json["productQuantity"],
    );
  }
}

class RelatedProducts {
  String? id;
  String? productName;
  List<String>? productImage;
  int? price;
  int? afterDiscountPrice;
  int? stockAvailable;

  RelatedProducts(
      {this.id,
      this.productName,
      this.productImage,
      this.price,
      this.afterDiscountPrice,
      this.stockAvailable});

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    productName = json["productName"];
    productImage = json["productImage"] == null
        ? null
        : List<String>.from(json["productImage"]);
    price = json["price"];
    afterDiscountPrice = json["afterDiscountPrice"];
    stockAvailable = json["stockAvailable"];
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
