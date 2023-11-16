class ProductWishlistEntity {
  String? sId;
  String? productName;
  List<String>? productImage;
  int? price;
  int? afterDiscountPrice;
  String? currency;
  int? stockAvailable;
  String? description;
  String? productQuantity;
  int? inCartCount;

  ProductWishlistEntity({
    this.sId,
    this.productName,
    this.productImage,
    this.price,
    this.afterDiscountPrice,
    this.currency,
    this.stockAvailable,
    this.description,
    this.inCartCount,
    this.productQuantity,
  });
}
