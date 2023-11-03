class ProductsHomeCarousel {
  bool? success;
  List<Banner>? banner;

  ProductsHomeCarousel({this.success, this.banner});

  ProductsHomeCarousel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['banner'] != null) {
      banner = <Banner>[];
      json['banner'].forEach((v) {
        banner!.add(new Banner.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.banner != null) {
      data['banner'] = this.banner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banner {
  String? sId;
  String? bannerImage;
  String? routeName;
  String? routeKey;

  Banner({this.sId, this.bannerImage, this.routeName, this.routeKey});

  Banner.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    bannerImage = json['bannerImage'];
    routeName = json['routeName'];
    routeKey = json['routeKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['bannerImage'] = this.bannerImage;
    data['routeName'] = this.routeName;
    data['routeKey'] = this.routeKey;
    return data;
  }
}
