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

class Banners {
  String? routeKey;
  String? sId;
  String? bannerImage;
  String? routeName;

  Banners({this.routeKey, this.sId, this.bannerImage, this.routeName});

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
