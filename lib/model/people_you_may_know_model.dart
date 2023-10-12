class PeopleYouMayKnowModel {
  bool? success;
  List<Recommendation>? recommendation;

  PeopleYouMayKnowModel({this.success, this.recommendation});

  PeopleYouMayKnowModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['recommendation'] != null) {
      recommendation = <Recommendation>[];
      json['recommendation'].forEach((v) {
        recommendation!.add(new Recommendation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.recommendation != null) {
      data['recommendation'] =
          this.recommendation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recommendation {
  String? sId;
  Connection? connection;

  Recommendation({this.sId, this.connection});

  Recommendation.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    connection = json['connection'] != null
        ? new Connection.fromJson(json['connection'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.connection != null) {
      data['connection'] = this.connection!.toJson();
    }
    return data;
  }
}

class Connection {
  String? sId;
  String? name;
  String? profilePicture;
  String? bio;
  bool? featured;
  String? uid;
  String? email;
  int? likesCount;
  int? postCount;
  int? connectionsCount;

  Connection(
      {this.sId,
      this.name,
      this.profilePicture,
      this.bio,
      this.featured,
      this.uid,
      this.email,
      this.likesCount,
      this.postCount,
      this.connectionsCount});

  Connection.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    profilePicture = json['profilePicture'];
    bio = json['bio'];
    featured = json['featured'];
    uid = json['uid'];
    email = json['email'];
    likesCount = json['likesCount'];
    postCount = json['postCount'];
    connectionsCount = json['connectionsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    data['bio'] = this.bio;
    data['featured'] = this.featured;
    data['uid'] = this.uid;
    data['email'] = this.email;
    data['likesCount'] = this.likesCount;
    data['postCount'] = this.postCount;
    data['connectionsCount'] = this.connectionsCount;
    return data;
  }
}
