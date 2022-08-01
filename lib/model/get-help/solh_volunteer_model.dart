class SolhVolunteerModel {
  bool? success;
  List<Provider>? provider;

  SolhVolunteerModel({this.success, this.provider});

  SolhVolunteerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['provider'] != null) {
      provider = <Provider>[];
      json['provider'].forEach((v) {
        provider!.add(new Provider.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.provider != null) {
      data['provider'] = this.provider!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Provider {
  String? name;
  String? bio;
  String? contactNumber;
  String? email;
  String? profilePicture;
  String? sId;
  String? uid;
  int? likesCount;
  int? commentCount;
  int? connectionsCount;
  String userType = 'volunteer';

  Provider({
    this.name,
    this.bio,
    this.contactNumber,
    this.email,
    this.profilePicture,
    this.sId,
    this.uid,
    this.likesCount,
    this.commentCount,
    this.connectionsCount,
  });

  Provider.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bio = json['bio'];
    contactNumber = json['contactNumber'];
    email = json['email'];
    profilePicture = json['profilePicture'];
    sId = json['_id'];
    uid = json['uid'];
    likesCount = json['likesCount'];
    commentCount = json['commentCount'];
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
    data['connectionsCount'] = this.connectionsCount;
    return data;
  }
}
