import '../../data/model/product_details_model.dart';

class ProductDetailEntity {
  final String? id;
  final String? productName;
  final List<String>? productImage;
  final ProductCategory? productCategory;
  final List<ProductSubCategory>? productSubCategory;
  final List<RelatedProducts>? relatedProducts;
  final int? price;
  final int? afterDiscountPrice;
  final String? slug;
  final String? authorName;
  final String? publisherName;
  final String? language;
  final String? isbn;
  final int? rating;
  final String? currency;
  final int? stockAvailable;
  final String? description;
  final String? medicineType;
  final String? productQuantity;
  final int? v;

  ProductDetailEntity(
      {this.id,
      this.relatedProducts,
      this.afterDiscountPrice,
      this.slug,
      this.medicineType,
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
      this.v});
}
