class SearchMarketModel {
  int? code;
  bool? success;
  List<Provider>? provider;
  List<Doctors>? doctors;

  SearchMarketModel({this.code, this.success, this.provider, this.doctors});

  SearchMarketModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    if (json['provider'] != null) {
      provider = <Provider>[];
      json['provider'].forEach((v) {
        provider!.add(new Provider.fromJson(v));
      });
    }
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(new Doctors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    if (this.provider != null) {
      data['provider'] = this.provider!.map((v) => v.toJson()).toList();
    }
    if (this.doctors != null) {
      data['doctors'] = this.doctors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctors {
  bool? offlineSession;
  String? name;
  String? organisation;
  String? addressLineOne;
  String? addressLineTwo;
  String? addressLineThree;
  String? addressLineFour;
  String? bio;
  String? contactNumber;
  String? email;
  String? sId;

  Doctors(
      {this.offlineSession,
      this.name,
      this.organisation,
      this.addressLineOne,
      this.addressLineTwo,
      this.addressLineThree,
      this.addressLineFour,
      this.bio,
      this.contactNumber,
      this.email,
      this.sId});

  Doctors.fromJson(Map<String, dynamic> json) {
    offlineSession = json['offlineSession'];
    name = json['name'];
    organisation = json['organisation'];
    addressLineOne = json['addressLineOne'];
    addressLineTwo = json['addressLineTwo'];
    addressLineThree = json['addressLineThree'];
    addressLineFour = json['addressLineFour'];
    bio = json['bio'];
    contactNumber = json['contactNumber'];
    email = json['email'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offlineSession'] = this.offlineSession;
    data['name'] = this.name;
    data['organisation'] = this.organisation;
    data['addressLineOne'] = this.addressLineOne;
    data['addressLineTwo'] = this.addressLineTwo;
    data['addressLineThree'] = this.addressLineThree;
    data['addressLineFour'] = this.addressLineFour;
    data['bio'] = this.bio;
    data['contactNumber'] = this.contactNumber;
    data['email'] = this.email;
    data['_id'] = this.sId;
    return data;
  }
}

class Provider {
  String? sId;
  String? gender;
  List<String>? language;
  bool? offlineSession;
  List<String>? education;
  List<String>? specialization;
  String? contactNumber;
  String? country;
  String? uid;
  String? token;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? addressLineFour;
  String? addressLineOne;
  String? addressLineThree;
  String? addressLineTwo;
  String? email;
  String? name;
  String? bio;
  int? experience;
  String? profession;
  double? score;
  String? id;

  Provider(
      {this.sId,
      this.gender,
      this.language,
      this.offlineSession,
      this.education,
      this.specialization,
      this.contactNumber,
      this.country,
      this.uid,
      this.token,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.addressLineFour,
      this.addressLineOne,
      this.addressLineThree,
      this.addressLineTwo,
      this.email,
      this.name,
      this.bio,
      this.experience,
      this.profession,
      this.score,
      this.id});

  Provider.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    gender = json['gender'];
    language = json['language'].cast<String>();
    offlineSession = json['offlineSession'];
    education = json['education'].cast<String>();
    specialization = json['specialization'].cast<String>();
    contactNumber = json['contactNumber'];
    country = json['country'];
    uid = json['uid'];
    token = json['token'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    addressLineFour = json['addressLineFour'];
    addressLineOne = json['addressLineOne'];
    addressLineThree = json['addressLineThree'];
    addressLineTwo = json['addressLineTwo'];
    email = json['email'];
    name = json['name'];
    bio = json['bio'];
    experience = json['experience'];
    profession = json['profession'];
    score = json['score'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['gender'] = this.gender;
    data['language'] = this.language;
    data['offlineSession'] = this.offlineSession;
    data['education'] = this.education;
    data['specialization'] = this.specialization;
    data['contactNumber'] = this.contactNumber;
    data['country'] = this.country;
    data['uid'] = this.uid;
    data['token'] = this.token;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['addressLineFour'] = this.addressLineFour;
    data['addressLineOne'] = this.addressLineOne;
    data['addressLineThree'] = this.addressLineThree;
    data['addressLineTwo'] = this.addressLineTwo;
    data['email'] = this.email;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['experience'] = this.experience;
    data['profession'] = this.profession;
    data['score'] = this.score;
    data['id'] = this.id;
    return data;
  }
}
