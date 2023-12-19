import 'package:solh/features/lms/display/course_home/domain/entities/course_cat_entity.dart';

class CourseCatModel extends CourseCatEntity {
  CourseCatModel({super.success, super.categoryList});

  factory CourseCatModel.fromJson(Map<String, dynamic> json) {
    return CourseCatModel(
        success: json["success"],
        categoryList: json["categoryList"] == null
            ? null
            : (json["categoryList"] as List)
                .map((e) => CategoryList.fromJson(e))
                .toList());
  }
}

class CategoryList {
  String? id;
  String? name;
  String? slug;
  String? displayImage;
  int? displayOrder;

  CategoryList(
      {this.id, this.name, this.slug, this.displayImage, this.displayOrder});

  CategoryList.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    slug = json["slug"];
    displayImage = json["displayImage"];
    displayOrder = json["displayOrder"];
  }
}
