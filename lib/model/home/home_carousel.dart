class HomePageCarouselModel {
  bool? success;
  List<FinalResult>? finalResult;

  HomePageCarouselModel({this.success, this.finalResult});

  HomePageCarouselModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['finalResult'] != null) {
      finalResult = <FinalResult>[];
      json['finalResult'].forEach((v) {
        finalResult!.add(new FinalResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.finalResult != null) {
      data['finalResult'] = this.finalResult!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FinalResult {
  String? bannerImageUrl;
  String? bannerRouteName;
  String? bannerRouteKey;

  FinalResult({this.bannerImageUrl, this.bannerRouteName, this.bannerRouteKey});

  FinalResult.fromJson(Map<String, dynamic> json) {
    bannerImageUrl = json['bannerImageUrl'];
    bannerRouteName = json['bannerRouteName'];
    bannerRouteKey = json['bannerRouteKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerImageUrl'] = this.bannerImageUrl;
    data['bannerRouteName'] = this.bannerRouteName;
    data['bannerRouteKey'] = this.bannerRouteKey;
    return data;
  }
}
