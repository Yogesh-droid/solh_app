import '../../domain/entities/product_sub_cat_entity.dart';

class ProductSubCatModel extends ProductSubCatEntity {
  ProductSubCatModel({super.success, super.subCategory});

  factory ProductSubCatModel.fromJson(Map<String, dynamic> json) {
    return ProductSubCatModel(
        success: json["success"],
        subCategory: json["subCategory"] == null
            ? null
            : (json["subCategory"] as List)
                .map((e) => SubCategory.fromJson(e))
                .toList());
  }
}

class SubCategory {
  String? id;
  String? categoryName;
  String? categoryImage;

  SubCategory({this.id, this.categoryName, this.categoryImage});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    categoryName = json["categoryName"];
    categoryImage = json["categoryImage"];
  }
}
