import 'package:solh/ui/screens/products/features/products_list/data/models/product_list_model.dart';

class ProductListEntity {
  final bool? success;
  final List<Products>? products;
  final Pages? pages;
  final int? totalProduct;

  ProductListEntity(
      {this.success, this.products, this.pages, this.totalProduct});
}
