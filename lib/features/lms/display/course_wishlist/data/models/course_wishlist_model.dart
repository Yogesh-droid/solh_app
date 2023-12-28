import 'package:solh/features/lms/display/course_wishlist/domain/entities/course_wishlist_entity.dart';

class CourseWishlistModel {
  bool? success;
  Wishlist? wishlist;

  CourseWishlistModel({this.success, this.wishlist});

  CourseWishlistModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    wishlist =
        json['wishlist'] != null ? Wishlist.fromJson(json['wishlist']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (wishlist != null) {
      data['wishlist'] = wishlist!.toJson();
    }
    return data;
  }
}

class Wishlist extends CourseWishlistEntity {
  String? sId;
  String? userId;
  List<Courses>? courses;
  String? type;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Wishlist(
      {this.sId,
      this.userId,
      this.courses,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.iV})
      : super(courses: courses, sId: sId, type: type, userId: userId);

  Wishlist.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(Courses.fromJson(v));
      });
    }
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Courses {
  String? sId;
  String? title;
  Instructor? instructor;
  int? price;
  String? currency;
  double? rating;
  int? salePrice;
  bool? inCart;
  String? thumbnail;
  TotalDuration? totalDuration;

  Courses(
      {this.sId,
      this.title,
      this.instructor,
      this.price,
      this.currency,
      this.salePrice,
      this.thumbnail,
      this.totalDuration,
      this.inCart});

  Courses.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    instructor = json['instructor'] != null
        ? Instructor.fromJson(json['instructor'])
        : null;
    price = json['price'];
    currency = json['currency'];
    salePrice = json['salePrice'];
    rating = json['rating'].toDouble() ?? 0.0;
    inCart = json['inCart'];
    thumbnail = json['thumbnail'];
    totalDuration = json['totalDuration'] != null
        ? TotalDuration.fromJson(json['totalDuration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    if (instructor != null) {
      data['instructor'] = instructor!.toJson();
    }
    data['price'] = price;
    data['currency'] = currency;
    data['salePrice'] = salePrice;
    data['inCart'] = inCart;
    return data;
  }
}

class Instructor {
  String? sId;
  String? name;

  Instructor({this.sId, this.name});

  Instructor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}

class TotalDuration {
  int? hours;
  int? minutes;

  TotalDuration({this.hours, this.minutes});

  TotalDuration.fromJson(Map<String, dynamic> json) {
    hours = json['hours'];
    minutes = json['minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hours'] = this.hours;
    data['minutes'] = this.minutes;
    return data;
  }
}
