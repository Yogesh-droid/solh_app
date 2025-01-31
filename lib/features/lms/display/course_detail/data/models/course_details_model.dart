import 'package:solh/features/lms/display/course_detail/domain/entities/course_details_entity.dart';

class CourseDetailsModel extends CourseDetailsEntity {
  CourseDetailsModel(
      {super.success,
      super.courseDetail,
      super.sections,
      super.totalSections,
      super.totalReviews,
      super.reviews});

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    return CourseDetailsModel(
        success: json["success"],
        courseDetail: json["courseDetail"] == null
            ? null
            : CourseDetail.fromJson(json["courseDetail"]),
        sections: json["sections"] == null
            ? null
            : (json["sections"] as List)
                .map((e) => Sections.fromJson(e))
                .toList(),
        reviews: json["reviews"] == null
            ? null
            : (json["reviews"] as List)
                .map((e) => Reviews.fromJson(e))
                .toList(),
        totalSections: json["totalSections"],
        totalReviews: json["totalReviews"]);
  }
}

class Sections {
  String? id;
  String? title;
  String? content;
  String? course;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? v;
  List<Lectures>? lectures;

  Sections(
      {this.id,
      this.title,
      this.content,
      this.course,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.lectures});

  Sections.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    title = json["title"];
    content = json["content"];
    course = json["course"];
    status = json["status"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
    lectures = json["lectures"] == null
        ? null
        : (json["lectures"] as List).map((e) => Lectures.fromJson(e)).toList();
  }
}

class Lectures {
  String? id;
  List<Quiz>? quiz;
  String? title;
  TotalDuration? totalDuration;
  String? contentType;

  Lectures(
      {this.id, this.quiz, this.title, this.contentType, this.totalDuration});

  Lectures.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    quiz = json["quiz"] == null
        ? null
        : (json["quiz"] as List).map((e) => Quiz.fromJson(e)).toList();
    title = json["title"];
    contentType = json["contentType"];
    totalDuration = json["duration"] == null
        ? null
        : TotalDuration.fromJson(json["duration"]);
  }
}

class Quiz {
  String? question;
  List<Options>? options;
  String? id;

  Quiz({this.question, this.options, this.id});

  Quiz.fromJson(Map<String, dynamic> json) {
    question = json["question"];
    options = json["options"] == null
        ? null
        : (json["options"] as List).map((e) => Options.fromJson(e)).toList();
    id = json["_id"];
  }
}

class Options {
  String? title;
  bool? correctAnswer;
  String? id;

  Options({this.title, this.correctAnswer, this.id});

  Options.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    correctAnswer = json["correctAnswer"];
    id = json["_id"];
  }
}

class CourseDetail {
  String? id;
  dynamic rating;
  String? preview;
  TotalDuration? totalDuration;
  List<SubCategory>? subCategory;
  String? courseIncludes;
  String? courseLearning;
  List<RelatedCourses>? relatedCourses;
  bool? isFeatured;
  String? title;
  String? subTitle;
  String? description;
  Instructor? instructor;
  String? thumbnail;
  int? price;
  int? salePrice;
  String? currency;
  Category? category;
  String? language;
  bool? isWishlisted;
  bool? isInCart;
  bool? isEnrolled;
  int? v;

  CourseDetail(
      {this.id,
      this.rating,
      this.preview,
      this.totalDuration,
      this.subCategory,
      this.courseIncludes,
      this.courseLearning,
      this.relatedCourses,
      this.isFeatured,
      this.title,
      this.subTitle,
      this.description,
      this.instructor,
      this.thumbnail,
      this.price,
      this.salePrice,
      this.currency,
      this.category,
      this.isInCart,
      this.isWishlisted,
      this.isEnrolled,
      this.language,
      this.v});

  CourseDetail.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    rating = json['rating'];
    preview = json['preview'];
    totalDuration = json["totalDuration"] == null
        ? null
        : TotalDuration.fromJson(json["totalDuration"]);
    subCategory = json["subCategory"] == null
        ? null
        : (json["subCategory"] as List)
            .map((e) => SubCategory.fromJson(e))
            .toList();
    courseIncludes = json["courseIncludes"];
    courseLearning = json["courseLearning"];
    relatedCourses = json["relatedCourses"] == null
        ? null
        : (json["relatedCourses"] as List)
            .map((e) => RelatedCourses.fromJson(e))
            .toList();
    isFeatured = json["isFeatured"];
    title = json["title"];
    subTitle = json["subTitle"];
    description = json["description"];
    instructor = json["instructor"] == null
        ? null
        : Instructor.fromJson(json["instructor"]);
    thumbnail = json["thumbnail"];
    price = json["price"];
    price = json["salePrice"];
    currency = json["currency"];
    category =
        json["category"] == null ? null : Category.fromJson(json["category"]);
    language = json["language"];
    isInCart = json['inCart'];
    isWishlisted = json['isWishlisted'];
    isEnrolled = json['isEnrolled'];
    v = json["__v"];
  }
}

class Category {
  String? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
  }
}

class Instructor {
  String? id;
  String? profilePicture;
  String? name;
  String? bio;
  MainCategory? mainCategory;

  Instructor(
      {this.id, this.profilePicture, this.name, this.bio, this.mainCategory});

  Instructor.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    profilePicture = json["profilePicture"];
    name = json["name"];
    bio = json["bio"];
    mainCategory = json["mainCategory"] == null
        ? null
        : MainCategory.fromJson(json["mainCategory"]);
  }
}

class MainCategory {
  String? id;
  String? name;

  MainCategory({this.id, this.name});

  MainCategory.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
  }
}

class RelatedCourses {
  String? id;
  String? title;
  String? thumbnail;
  int? price;

  RelatedCourses({this.id, this.title, this.thumbnail, this.price});

  RelatedCourses.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    title = json["title"];
    thumbnail = json["thumbnail"];
    price = json["price"];
  }
}

class SubCategory {
  String? id;
  String? name;

  SubCategory({this.id, this.name});

  SubCategory.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
  }
}

class TotalDuration {
  int? hours;
  int? minutes;

  TotalDuration({this.hours, this.minutes});

  TotalDuration.fromJson(Map<String, dynamic> json) {
    hours = json["hours"];
    minutes = json["minutes"];
  }
}

class Reviews {
  String? sId;
  String? review;
  int? rating;
  UserId? userId;

  Reviews({this.sId, this.review, this.rating, this.userId});

  Reviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    review = json['review'];
    rating = json['rating'];
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
  }
}

class UserId {
  String? sId;
  String? name;
  String? profilePicture;
  String? id;

  UserId({this.sId, this.name, this.profilePicture, this.id});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    profilePicture = json['profilePicture'];
    id = json['id'];
  }
}
