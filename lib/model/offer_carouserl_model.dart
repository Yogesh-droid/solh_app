class OfferCarouselModel {
  bool? success;
  String? message;
  List<Data>? data;

  OfferCarouselModel({this.success, this.message, this.data});

  OfferCarouselModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? title;
  String? description;
  String? image;
  String? routeKey;
  String? routeValue;
  String? status;

  Data(
      {this.sId,
      this.title,
      this.description,
      this.image,
      this.routeKey,
      this.routeValue,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    routeKey = json['routeKey'];
    routeValue = json['routeValue'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['routeKey'] = this.routeKey;
    data['routeValue'] = this.routeValue;
    data['status'] = this.status;
    return data;
  }
}
