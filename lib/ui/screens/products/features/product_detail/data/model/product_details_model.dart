import 'package:solh/ui/screens/products/features/home/domain/entities/product_category_entity.dart';
import 'package:solh/ui/screens/products/features/product_detail/domain/entities/product_detail_entity.dart';

class ProductDetailsModel {
  bool? success;
  Product? product;
  List<Reviews>? reviews;
  int? totalReview;

  ProductDetailsModel(
      {this.success, this.product, this.reviews, this.totalReview});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    totalReview = json['totalReview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['totalReview'] = this.totalReview;
    return data;
  }
}

class Product {
  String? sId;
  String? productName;
  List<String>? productImage;
  ProductCategory? productCategory;
  List<ProductSubCategory>? productSubCategory;
  List<RelatedProducts>? relatedProducts;
  int? price;
  int? afterDiscountPrice;
  String? language;
  double? rating;
  String? currency;
  int? stockAvailable;
  String? description;
  String? medicineType;
  String? productQuantity;
  List<Specification>? specification;
  int? iV;
  String? skuOrIsbn;
  int? overAllRating;

  Product(
      {this.sId,
      this.productName,
      this.productImage,
      this.productCategory,
      this.productSubCategory,
      this.relatedProducts,
      this.price,
      this.afterDiscountPrice,
      this.language,
      this.rating,
      this.currency,
      this.stockAvailable,
      this.description,
      this.medicineType,
      this.productQuantity,
      this.specification,
      this.iV,
      this.overAllRating,
      this.skuOrIsbn});

  Product.fromJson(Map<String, dynamic> json) {
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
    if (json['relatedProducts'] != null) {
      relatedProducts = <RelatedProducts>[];
      json['relatedProducts'].forEach((v) {
        relatedProducts!.add(new RelatedProducts.fromJson(v));
      });
    }
    price = json['price'];
    afterDiscountPrice = json['afterDiscountPrice'];
    language = json['language'];

    currency = json['currency'];
    stockAvailable = json['stockAvailable'];
    description = json['description'];
    medicineType = json['medicineType'];
    productQuantity = json['productQuantity'];
    if (json['specification'] != null) {
      specification = <Specification>[];
      json['specification'].forEach((v) {
        specification!.add(new Specification.fromJson(v));
      });
    }
    iV = json['__v'];
    skuOrIsbn = json['sku_or_isbn'];
    overAllRating = json['overAllRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['productName'] = this.productName;
    data['productImage'] = this.productImage;
    if (this.productCategory != null) {
      data['productCategory'] = this.productCategory!.toJson();
    }
    if (this.productSubCategory != null) {
      data['productSubCategory'] =
          this.productSubCategory!.map((v) => v.toJson()).toList();
    }
    if (this.relatedProducts != null) {
      data['relatedProducts'] =
          this.relatedProducts!.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    data['afterDiscountPrice'] = this.afterDiscountPrice;
    data['language'] = this.language;
    data['rating'] = this.rating;
    data['currency'] = this.currency;
    data['stockAvailable'] = this.stockAvailable;
    data['description'] = this.description;
    data['medicineType'] = this.medicineType;
    data['productQuantity'] = this.productQuantity;
    if (this.specification != null) {
      data['specification'] =
          this.specification!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    data['sku_or_isbn'] = this.skuOrIsbn;
    return data;
  }
}

class ProductCategory {
  String? sId;
  String? categoryName;

  ProductCategory({this.sId, this.categoryName});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['categoryName'] = this.categoryName;
    return data;
  }
}

class RelatedProducts {
  String? sId;
  String? productName;
  List<String>? productImage;
  int? price;
  int? afterDiscountPrice;
  int? stockAvailable;
  String? productQuantity;
  String? description;

  RelatedProducts(
      {this.sId,
      this.productName,
      this.productImage,
      this.price,
      this.afterDiscountPrice,
      this.stockAvailable,
      this.description,
      this.productQuantity});

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    productImage = json['productImage'].cast<String>();
    price = json['price'];
    afterDiscountPrice = json['afterDiscountPrice'];
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
    data['stockAvailable'] = this.stockAvailable;
    data['productQuantity'] = this.productQuantity;
    return data;
  }
}

class Specification {
  String? label;
  String? value;
  String? sId;

  Specification({this.label, this.value, this.sId});

  Specification.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    data['_id'] = this.sId;
    return data;
  }
}

class Reviews {
  String? sId;
  String? review;
  int? rating;
  UserId? userId;
  String? createdAt;

  Reviews({this.sId, this.review, this.rating, this.userId, this.createdAt});

  Reviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    review = json['review'];
    rating = json['rating'];
    createdAt = json['createdAt'];
    userId =
        json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['review'] = this.review;
    data['rating'] = this.rating;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    return data;
  }
}

class UserId {
  String? sId;
  String? name;
  String? profilePicture;
  String? id;

  UserId({this.sId, this.name, this.profilePicture, this.id});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    profilePicture = json['profilePicture'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    data['id'] = this.id;
    return data;
  }
}

class ProductSubCategory {
  String? id;
  String? categoryName;

  ProductSubCategory({this.id, this.categoryName});

  ProductSubCategory.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = id;
    data['categoryName'] = categoryName;
    return data;
  }
}
