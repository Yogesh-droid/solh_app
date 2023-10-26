import '../../data/models/featured_product_list_model.dart';

class FeaturedProductListEntity {
  final bool? success;
  final List<FeaturedProducts>? featuredProducts;
  final Pages? pages;
  final int? totalProduct;

  FeaturedProductListEntity(
      {this.success, this.featuredProducts, this.pages, this.totalProduct});
}
