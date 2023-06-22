class PackagesResponseModel {
  bool? success;
  FinalResult? finalResult;

  PackagesResponseModel({this.success, this.finalResult});

  PackagesResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    finalResult = json['finalResult'] != null
        ? new FinalResult.fromJson(json['finalResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.finalResult != null) {
      data['finalResult'] = this.finalResult!.toJson();
    }
    return data;
  }
}

class FinalResult {
  String? name;
  String? id;
  String? profession;
  int? experience;
  int? numberOfConsultations;
  String? rating;
  String? posts;
  String? prefix;
  String? bio;
  String? previewVideo;
  String? isVerified;
  String? profilePicture;
  List<Packages>? packages;

  FinalResult(
      {this.name,
      this.id,
      this.profession,
      this.prefix,
      this.experience,
      this.numberOfConsultations,
      this.rating,
      this.posts,
      this.bio,
      this.previewVideo,
      this.isVerified,
      this.profilePicture,
      this.packages});

  FinalResult.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['ownerId'];
    profession = json['profession'];
    experience = json['experience'];
    prefix = json['prefix'];
    numberOfConsultations = json['numberOfConsultations'];
    rating = json['rating'];
    posts = json['posts'];
    bio = json['bio'];
    previewVideo = json['previewVideo'];
    isVerified = json['isVerified'];
    profilePicture = json['profilePicture'];
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(new Packages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data["ownerId"] = this.id;
    data['profession'] = this.profession;
    data['experience'] = this.experience;
    data['numberOfConsultations'] = this.numberOfConsultations;
    data['rating'] = this.rating;
    data['posts'] = this.posts;
    data['bio'] = this.bio;
    data['previewVideo'] = this.previewVideo;
    data['isVerified'] = this.isVerified;
    data['profilePicture'] = this.profilePicture;
    if (this.packages != null) {
      data['packages'] = this.packages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Packages {
  String? sId;
  List<VideoSessions>? videoSessions;
  String? name;
  String? slug;
  String? duration;
  String? unitDuration;
  String? aboutPackage;
  String? benefits;
  String? equipment;
  String? currency;
  int? amount;
  String? packageOwner;
  String? packageType;
  String? packageCategory;
  String? feeCode;

  Packages(
      {this.sId,
      this.videoSessions,
      this.name,
      this.slug,
      this.duration,
      this.unitDuration,
      this.aboutPackage,
      this.benefits,
      this.equipment,
      this.currency,
      this.amount,
      this.packageCategory,
      this.packageType,
      this.packageOwner,
      this.feeCode});

  Packages.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['videoSessions'] != null) {
      videoSessions = <VideoSessions>[];
      json['videoSessions'].forEach((v) {
        videoSessions!.add(new VideoSessions.fromJson(v));
      });
    }
    name = json['name'];
    slug = json['slug'];
    duration = json['duration'];
    unitDuration = json['unitDuration'];
    aboutPackage = json['aboutPackage'];
    benefits = json['benefits'];
    equipment = json['equipment'];
    currency = json['currency'];
    amount = json['amount'];
    packageOwner = json['packageOwner'];
    packageType = json['packageType'];
    packageCategory = json['packageCategory'];
    feeCode = json["feeCode"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.videoSessions != null) {
      data['videoSessions'] =
          this.videoSessions!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['duration'] = this.duration;
    data['unitDuration'] = this.unitDuration;
    data['aboutPackage'] = this.aboutPackage;
    data['benefits'] = this.benefits;
    data['equipment'] = this.equipment;
    data['currency'] = this.currency;
    data['amount'] = this.amount;
    data['packageOwner'] = this.packageOwner;
    data['packageType'] = this.packageType;
    data['packageCategory'] = this.packageCategory;
    return data;
  }
}

class VideoSessions {
  String? vName;
  String? vDescription;
  String? sId;

  VideoSessions({this.vName, this.vDescription, this.sId});

  VideoSessions.fromJson(Map<String, dynamic> json) {
    vName = json['vName'];
    vDescription = json['vDescription'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vName'] = this.vName;
    data['vDescription'] = this.vDescription;
    data['_id'] = this.sId;
    return data;
  }
}
