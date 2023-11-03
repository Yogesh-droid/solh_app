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
        banners!.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners extends ProductHomeCarouselEntity {
  String? routeKey;
  String? sId;
  String? bannerImage;
  String? routeName;

  Banners({this.routeKey, this.sId, this.bannerImage, this.routeName})
      : super(
          bannerImage: bannerImage,
          routeKey: routeKey,
          routeName: routeName,
          sId: sId,
        );

  Banners.fromJson(Map<String, dynamic> json) {
    routeKey = json['routeKey'];
    sId = json['_id'];
    bannerImage = json['bannerImage'];
    routeName = json['routeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['routeKey'] = this.routeKey;
    data['_id'] = this.sId;
    data['bannerImage'] = this.bannerImage;
    data['routeName'] = this.routeName;
    return data;
  }
}
