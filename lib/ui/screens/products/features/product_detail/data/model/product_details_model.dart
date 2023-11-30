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
        json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    totalReview = json['totalReview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    data['totalReview'] = totalReview;
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
  int? inCartCount;
  bool? isWishlisted;

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
      this.inCartCount,
      this.isWishlisted,
      this.skuOrIsbn});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    productImage = json['productImage'].cast<String>();
    productCategory = json['productCategory'] != null
        ? ProductCategory.fromJson(json['productCategory'])
        : null;
    if (json['productSubCategory'] != null) {
      productSubCategory = <ProductSubCategory>[];
      json['productSubCategory'].forEach((v) {
        productSubCategory!.add(ProductSubCategory.fromJson(v));
      });
    }
    if (json['relatedProducts'] != null) {
      relatedProducts = <RelatedProducts>[];
      json['relatedProducts'].forEach((v) {
        relatedProducts!.add(RelatedProducts.fromJson(v));
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
        specification!.add(Specification.fromJson(v));
      });
    }
    iV = json['__v'];
    skuOrIsbn = json['sku_or_isbn'];
    isWishlisted = json['isWishlisted'];
    inCartCount = json['inCartCount'];
    overAllRating = json['overAllRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['productName'] = productName;
    data['productImage'] = productImage;
    if (productCategory != null) {
      data['productCategory'] = productCategory!.toJson();
    }
    if (productSubCategory != null) {
      data['productSubCategory'] =
          productSubCategory!.map((v) => v.toJson()).toList();
    }
    if (relatedProducts != null) {
      data['relatedProducts'] =
          relatedProducts!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['afterDiscountPrice'] = afterDiscountPrice;
    data['language'] = language;
    data['rating'] = rating;
    data['currency'] = currency;
    data['stockAvailable'] = stockAvailable;
    data['description'] = description;
    data['medicineType'] = medicineType;
    data['productQuantity'] = productQuantity;
    if (specification != null) {
      data['specification'] = specification!.map((v) => v.toJson()).toList();
    }
    data['__v'] = iV;
    data['sku_or_isbn'] = skuOrIsbn;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['categoryName'] = categoryName;
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
  int? inCartCount;
  bool? isWishlisted;
  String? currency;
  String? shortDescription;

  RelatedProducts({
    this.sId,
    this.productName,
    this.productImage,
    this.price,
    this.afterDiscountPrice,
    this.stockAvailable,
    this.description,
    this.inCartCount,
    this.isWishlisted,
    this.productQuantity,
    this.currency,
    this.shortDescription,
  });

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    productImage = json['productImage'].cast<String>();
    price = json['price'];
    afterDiscountPrice = json['afterDiscountPrice'];
    stockAvailable = json['stockAvailable'];
    description = json['description'];
    productQuantity = json['productQuantity'];
    isWishlisted = json['isWishlisted'];
    inCartCount = json['inCartCount'];
    currency = json['currency'];
    shortDescription = json['shortDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['productName'] = productName;
    data['productImage'] = productImage;
    data['price'] = price;
    data['afterDiscountPrice'] = afterDiscountPrice;
    data['stockAvailable'] = stockAvailable;
    data['productQuantity'] = productQuantity;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    data['_id'] = sId;
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
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['review'] = review;
    data['rating'] = rating;
    if (userId != null) {
      data['userId'] = userId!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['profilePicture'] = profilePicture;
    data['id'] = id;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['categoryName'] = categoryName;
    return data;
  }
}
