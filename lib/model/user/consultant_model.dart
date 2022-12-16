class ConsultantModel {
  bool? success;
  Provder? provder;

  ConsultantModel({this.success, this.provder});

  ConsultantModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    provder =
        json['provder'] != null ? new Provder.fromJson(json['provder']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.provder != null) {
      data['provder'] = this.provder!.toJson();
    }
    return data;
  }
}

class Provder {
  String? contactNumber;
  String? email;
  bool? offlineSession;
  String? name;
  String? locality;
  String? city;
  String? pinCode;
  String? bio;
  String? specialization;
  String? education;
  String? country;
  int? experience;
  String? profilePicture;
  String? sId;
  String? type;
  String? feeCurrency;
  String? fee;
  int? fee_amount;
  int? apptCount;
  int? postCount;
  int? likeCount;
  int? ratingCount;
  String? prefix;
  String? profession;

  Provder(
      {this.contactNumber,
      this.email,
      this.offlineSession,
      this.name,
      this.locality,
      this.city,
      this.pinCode,
      this.bio,
      this.specialization,
      this.education,
      this.country,
      this.experience,
      this.profilePicture,
      this.sId,
      this.type,
      this.feeCurrency,
      this.fee,
      this.fee_amount,
      this.apptCount,
      this.postCount,
      this.likeCount,
      this.ratingCount,
      this.profession,
      this.prefix});

  Provder.fromJson(Map<String, dynamic> json) {
    contactNumber = json['contactNumber'];
    email = json['email'];
    offlineSession = json['offlineSession'];
    name = json['name'];
    locality = json['locality'];
    city = json['city'];
    pinCode = json['pinCode'];
    bio = json['bio'];
    specialization = json['specialization'];
    education = json['education'];
    country = json['country'];
    experience = json['experience'];
    profilePicture = json['profilePicture'];
    sId = json['_id'];
    type = json['type'];
    feeCurrency = json['feeCurrency'];
    fee = json['fee'];
    fee_amount = json['fee_amount'];
    apptCount = json['apptCount'];
    postCount = json['postCount'];
    likeCount = json['likeCount'];
    ratingCount = json['ratingCount'];
    // prefix = json['prefix'];
    profession = json['profession'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactNumber'] = this.contactNumber;
    data['email'] = this.email;
    data['offlineSession'] = this.offlineSession;
    data['name'] = this.name;
    data['locality'] = this.locality;
    data['city'] = this.city;
    data['pinCode'] = this.pinCode;
    data['bio'] = this.bio;
    data['specialization'] = this.specialization;
    data['education'] = this.education;
    data['country'] = this.country;
    data['experience'] = this.experience;
    data['profilePicture'] = this.profilePicture;
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['feeCurrency'] = this.feeCurrency;
    data['fee'] = this.fee;
    data['fee_amount'] = this.fee_amount;
    data['apptCount'] = this.apptCount;
    data['postCount'] = this.postCount;
    data['likeCount'] = this.likeCount;
    data['ratingCount'] = this.ratingCount;
    // data['prefix'] = this.prefix;
    data['profession'] = this.profession;
    return data;
  }
}


/* class ConsultantModel {
  bool? success;
  Provder? provder;

  ConsultantModel({this.success, this.provder});

  ConsultantModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    provder =
        json['provder'] != null ? new Provder.fromJson(json['provder']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.provder != null) {
      data['provder'] = this.provder!.toJson();
    }
    return data;
  }
}

class Provder {
  bool? offlineSession;
  String? name;
  String? bio;
  String? specialization;
  String? contactNumber;
  String? email;
  String? country;
  int? experience;
  String? fee;
  int? fee_amount;
  String? feeCurrency;
  String? profilePicture;
  bool? solhCertified;
  String? sId;
  String? uid;
  int? prefix;
  String? type;

  Provder(
      {this.offlineSession,
      this.name,
      this.bio,
      this.specialization,
      this.contactNumber,
      this.email,
      this.country,
      this.experience,
      this.profilePicture,
      this.solhCertified,
      this.fee,
      this.feeCurrency,
      this.sId,
      this.uid,
      this.fee_amount,
      this.prefix,
      this.type});

  Provder.fromJson(Map<String, dynamic> json) {
    offlineSession = json['offlineSession'];
    name = json['name'];
    bio = json['bio'];
    fee_amount = json['fee_amount'];
    specialization = json['specialization'];
    contactNumber = json['contactNumber'];
    email = json['email'];
    country = json['country'];
    experience = json['experience'];
    profilePicture = json['profilePicture'];
    solhCertified = json['solhCertified'];
    fee = json['fee'];
    feeCurrency = json['feeCurrency'];
    sId = json['_id'];
    uid = json['uid'];
    prefix = json['prefix'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offlineSession'] = this.offlineSession;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['specialization'] = this.specialization;
    data['contactNumber'] = this.contactNumber;
    data['email'] = this.email;
    data['country'] = this.country;
    data['experience'] = this.experience;
    data['profilePicture'] = this.profilePicture;
    data['solhCertified'] = this.solhCertified;
    data['_id'] = this.sId;
    data['fee'] = this.fee;
    data['feeCurrency'] = this.feeCurrency;
    data['uid'] = this.uid;
    data['prefix'] = this.prefix;
    data['type'] = this.type;
    return data;
  }
}
 */