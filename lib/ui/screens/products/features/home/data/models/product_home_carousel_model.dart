import 'package:solh/ui/screens/products/features/home/domain/entities/product_home_carousel_entity.dart';

class HomeProductCarouselModel {
  bool? success;
  List<Banners>? banners;

  HomeProductCarouselModel({this.success, this.banners});

  HomeProductCarouselModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
  }
}

class Banners extends ProductHomeCarouselEntity {
  Banners(
      {super.routeKey,
      String? sId,
      String? bannerImage,
      String? routeName,
      String? bannerName});
  Banners.fromJson(Map<String, dynamic> json) {
    routeKey = json['routeKey'];
    sId = json['_id'];
    bannerImage = json['bannerImage'];
    routeName = json['routeName'];
    bannerName = json['bannerName'];
  }
}
