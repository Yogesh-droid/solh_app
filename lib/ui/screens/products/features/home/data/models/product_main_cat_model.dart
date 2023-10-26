import 'package:solh/ui/screens/products/features/home/domain/entities/product_mainCat_entity.dart';

class ProductMainCatModel {
  bool? success;
  List<MainCategory>? mainCategory;

  ProductMainCatModel({this.success, this.mainCategory});

  ProductMainCatModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    mainCategory = json["mainCategory"] == null
        ? null
        : (json["mainCategory"] as List)
            .map((e) => MainCategory.fromJson(e))
            .toList();
  }
}

class MainCategory extends ProductMainCatEntity {
  MainCategory({String? id, String? categoryName, String? categoryImage})
      : super(categoryImage: categoryImage, categoryName: categoryName, id: id);

  factory MainCategory.fromJson(Map<String, dynamic> json) {
    return MainCategory(
        id: json["_id"],
        categoryName: json["categoryName"],
        categoryImage: json["categoryImage"]);
  }
}
