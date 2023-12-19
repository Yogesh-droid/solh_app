import 'package:solh/features/lms/display/course_home/domain/entities/course_banner_entity.dart';

class CourseHomeBannerModel extends CourseBannerEntity {
  CourseHomeBannerModel({super.success, super.bannerList});

  factory CourseHomeBannerModel.fromJson(Map<String, dynamic> json) {
    return CourseHomeBannerModel(
        success: json["success"],
        bannerList: json["bannerList"] == null
            ? null
            : (json["bannerList"] as List)
                .map((e) => BannerList.fromJson(e))
                .toList());
  }
}

class BannerList {
  String? routeKey;
  String? id;
  String? bannerImage;
  String? routeName;

  BannerList({this.routeKey, this.id, this.bannerImage, this.routeName});

  BannerList.fromJson(Map<String, dynamic> json) {
    routeKey = json["routeKey"];
    id = json["_id"];
    bannerImage = json["bannerImage"];
    routeName = json["routeName"];
  }
}
