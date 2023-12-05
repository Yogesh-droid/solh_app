class FeatureProductsEntity {
  String? sId;
  String? productName;
  List<String>? productImage;
  int? price;
  int? afterDiscountPrice;
  int? stockAvailable;
  String? description;
  String? productQuantity;
  int? inCartCount;
  bool? isWishlisted;
  String? currency;
  String? shortDescription;

  FeatureProductsEntity(
      {this.sId,
      this.afterDiscountPrice,
      this.description,
      this.price,
      this.productImage,
      this.productName,
      this.productQuantity,
      this.inCartCount,
      this.isWishlisted,
      this.stockAvailable,
      this.shortDescription,
      this.currency});
}
