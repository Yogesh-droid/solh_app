import '../../domain/entities/filter_entity.dart';

class FilterModel {
  bool? success;
  List<SubCategory>? subCategory;

  FilterModel({this.success, this.subCategory});

  FilterModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    subCategory = json["subCategory"] == null
        ? null
        : (json["subCategory"] as List)
            .map((e) => SubCategory.fromJson(e))
            .toList();
  }
}

class SubCategory extends FilterEntity {
  SubCategory({String? id, String? categoryName, String? categoryImage})
      : super(categoryImage: categoryImage, categoryName: categoryName, id: id);

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
        id: json["_id"],
        categoryName: json["categoryName"],
        categoryImage: json["categoryImage"]);
  }
}
