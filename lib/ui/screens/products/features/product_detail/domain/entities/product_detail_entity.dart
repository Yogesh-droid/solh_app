import '../../data/model/product_detail_model.dart';

class ProductDetailEntity {
  final String? id;
  final String? productName;
  final List<String>? productImage;
  final ProductCategory? productCategory;
  final List<ProductSubCategory>? productSubCategory;
  final int? price;
  final String? authorName;
  final String? publisherName;
  final String? language;
  final String? isbn;
  final double? rating;
  final String? currency;
  final int? stockAvailable;
  final String? description;
  final String? productQuantity;
  final int? v;
  final List<dynamic>? reviews;
  final List<dynamic>? releatedProduct;

  ProductDetailEntity(
      {this.id,
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
      this.productQuantity,
      this.v,
      this.reviews,
      this.releatedProduct});
}
