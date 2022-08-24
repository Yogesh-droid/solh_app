class PeopleYouMayKnowModel {
  bool? success;
  int? count;
  List<Reccomendation>? reccomendation;

  PeopleYouMayKnowModel({this.success, this.count, this.reccomendation});

  PeopleYouMayKnowModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    count = json['count'];
    if (json['reccomendation'] != null) {
      reccomendation = <Reccomendation>[];
      json['reccomendation'].forEach((v) {
        reccomendation!.add(new Reccomendation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['count'] = this.count;
    if (this.reccomendation != null) {
      data['reccomendation'] =
          this.reccomendation!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reccomendation {
  String? name;
  String? bio;
  String? contactNumber;
  String? email;
  String? profilePicture;
  String? sId;
  String? uid;
  int? likesCount;
  int? commentCount;
  bool? featured;
  int? connectionsCount;

  Reccomendation(
      {this.name,
      this.bio,
      this.contactNumber,
      this.email,
      this.profilePicture,
      this.sId,
      this.uid,
      this.likesCount,
      this.commentCount,
      this.featured,
      this.connectionsCount});

  Reccomendation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bio = json['bio'];
    contactNumber = json['contactNumber'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    sId = json['_id'];
    uid = json['uid'];
    likesCount = json['likesCount'];
    commentCount = json['commentCount'];
    featured = json['featured'];
    connectionsCount = json['connectionsCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['contactNumber'] = this.contactNumber;
    data['email'] = this.email;
    data['profilePicture'] = this.profilePicture;
    data['_id'] = this.sId;
    data['uid'] = this.uid;
    data['likesCount'] = this.likesCount;
    data['commentCount'] = this.commentCount;
    data['featured'] = this.featured;
    data['connectionsCount'] = this.connectionsCount;
    return data;
  }
}
