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
  bool? offlineSession;
  String? name;
  String? bio;
  String? specialization;
  String? contactNumber;
  String? email;
  String? country;
  int? experience;
  String? profilePicture;
  bool? solhCertified;
  String? sId;
  String? uid;
  int? prefix;

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
      this.sId,
      this.uid,
      this.prefix});

  Provder.fromJson(Map<String, dynamic> json) {
    offlineSession = json['offlineSession'];
    name = json['name'];
    bio = json['bio'];
    specialization = json['specialization'];
    contactNumber = json['contactNumber'];
    email = json['email'];
    country = json['country'];
    experience = json['experience'];
    profilePicture = json['profilePicture'];
    solhCertified = json['solhCertified'];
    sId = json['_id'];
    uid = json['uid'];
    prefix = json['prefix'];
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
    data['uid'] = this.uid;
    data['prefix'] = this.prefix;
    return data;
  }
}
