class FeatureProductsEntity {
  String? sId;
  String? productName;
  List<String>? productImage;
  int? price;
  int? afterDiscountPrice;
  int? stockAvailable;
  String? description;
  String? productQuantity;

  FeatureProductsEntity({
    this.sId,
    this.afterDiscountPrice,
    this.description,
    this.price,
    this.productImage,
    this.productName,
    this.productQuantity,
    this.stockAvailable,
  });
}
