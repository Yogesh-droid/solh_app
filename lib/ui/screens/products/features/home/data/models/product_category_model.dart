import 'package:solh/ui/screens/products/features/home/domain/entities/product_category_entity.dart';

class ProductCategoryModel {
  bool? success;
  List<SubCategory>? subCategory;

  ProductCategoryModel({this.success, this.subCategory});

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    subCategory = json["subCategory"] == null
        ? null
        : (json["subCategory"] as List)
            .map((e) => SubCategory.fromJson(e))
            .toList();
  }
}

class SubCategory extends ProductCategoryEntity {
  SubCategory({String? id, String? categoryName, String? categoryImage})
      : super(categoryImage: categoryImage, categoryName: categoryName, id: id);

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
        id: json["_id"],
        categoryName: json["categoryName"],
        categoryImage: json["categoryImage"]);
  }
}
