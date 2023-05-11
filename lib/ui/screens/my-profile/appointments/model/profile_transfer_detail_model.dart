class ProfileTransferDetailModel {
  bool? success;
  Details? details;

  ProfileTransferDetailModel({this.success, this.details});

  ProfileTransferDetailModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class Details {
  ReferedToStatus? referedToStatus;
  ReferedToStatus? userStatus;
  String? sId;
  String? userId;
  ReferedBy? referedBy;
  ReferedTo? referedTo;
  String? reason;
  String? reportLink;
  String? reportDescription;
  List<PreviousReport>? previousReport;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Details(
      {this.referedToStatus,
      this.userStatus,
      this.sId,
      this.userId,
      this.referedBy,
      this.referedTo,
      this.reason,
      this.reportLink,
      this.reportDescription,
      this.previousReport,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Details.fromJson(Map<String, dynamic> json) {
    referedToStatus = json['referedToStatus'] != null
        ? new ReferedToStatus.fromJson(json['referedToStatus'])
        : null;
    userStatus = json['userStatus'] != null
        ? new ReferedToStatus.fromJson(json['userStatus'])
        : null;
    sId = json['_id'];
    userId = json['userId'];
    referedBy = json['referedBy'] != null
        ? new ReferedBy.fromJson(json['referedBy'])
        : null;
    referedTo = json['referedTo'] != null
        ? new ReferedTo.fromJson(json['referedTo'])
        : null;
    reason = json['reason'];
    reportLink = json['reportLink'];
    reportDescription = json['reportDescription'];
    if (json['previousReport'] != null) {
      previousReport = <PreviousReport>[];
      json['previousReport'].forEach((v) {
        previousReport!.add(new PreviousReport.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.referedToStatus != null) {
      data['referedToStatus'] = this.referedToStatus!.toJson();
    }
    if (this.userStatus != null) {
      data['userStatus'] = this.userStatus!.toJson();
    }
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    if (this.referedBy != null) {
      data['referedBy'] = this.referedBy!.toJson();
    }
    if (this.referedTo != null) {
      data['referedTo'] = this.referedTo!.toJson();
    }
    data['reason'] = this.reason;
    data['reportLink'] = this.reportLink;
    data['reportDescription'] = this.reportDescription;
    if (this.previousReport != null) {
      data['previousReport'] =
          this.previousReport!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ReferedToStatus {
  String? status;
  String? dateTime;

  ReferedToStatus({this.status, this.dateTime});

  ReferedToStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['dateTime'] = this.dateTime;
    return data;
  }
}

class ReferedBy {
  String? sId;
  String? profilePicture;
  String? name;
  int? experience;
  Profession? profession;
  String? id;

  ReferedBy(
      {this.sId,
      this.profilePicture,
      this.name,
      this.experience,
      this.profession,
      this.id});

  ReferedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    name = json['name'];
    experience = json['experience'];
    profession = json['profession'] != null
        ? new Profession.fromJson(json['profession'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profilePicture'] = this.profilePicture;
    data['name'] = this.name;
    data['experience'] = this.experience;
    if (this.profession != null) {
      data['profession'] = this.profession!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Profession {
  String? sId;
  String? name;

  Profession({this.sId, this.name});

  Profession.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class ReferedTo {
  String? sId;
  List<String>? education;
  int? feeAmount;
  String? feeCurrency;
  String? profilePicture;
  List<Specialization>? specialization;
  String? name;
  String? bio;
  int? experience;
  Profession? profession;
  String? id;

  ReferedTo(
      {this.sId,
      this.education,
      this.feeAmount,
      this.feeCurrency,
      this.profilePicture,
      this.specialization,
      this.name,
      this.bio,
      this.experience,
      this.profession,
      this.id});

  ReferedTo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    education = json['education'].cast<String>();
    feeAmount = json['fee_amount'];
    feeCurrency = json['fee_currency'];
    profilePicture = json['profilePicture'];
    if (json['specialization'] != null) {
      specialization = <Specialization>[];
      json['specialization'].forEach((v) {
        specialization!.add(new Specialization.fromJson(v));
      });
    }
    name = json['name'];
    bio = json['bio'];
    experience = json['experience'];
    profession = json['profession'] != null
        ? new Profession.fromJson(json['profession'])
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['education'] = this.education;
    data['fee_amount'] = this.feeAmount;
    data['fee_currency'] = this.feeCurrency;
    data['profilePicture'] = this.profilePicture;
    if (this.specialization != null) {
      data['specialization'] =
          this.specialization!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['experience'] = this.experience;
    if (this.profession != null) {
      data['profession'] = this.profession!.toJson();
    }
    data['id'] = this.id;
    return data;
  }
}

class Specialization {
  String? sId;
  String? name;
  String? id;

  Specialization({this.sId, this.name, this.id});

  Specialization.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class PreviousReport {
  String? sId;
  String? patientId;
  String? providerId;
  String? appointmentId;
  String? reportLink;
  String? reportType;
  String? sessionNotes;
  String? createdAt;
  String? updatedAt;
  int? iV;

  PreviousReport(
      {this.sId,
      this.patientId,
      this.providerId,
      this.appointmentId,
      this.reportLink,
      this.reportType,
      this.sessionNotes,
      this.createdAt,
      this.updatedAt,
      this.iV});

  PreviousReport.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    patientId = json['patientId'];
    providerId = json['providerId'];
    appointmentId = json['appointmentId'];
    reportLink = json['reportLink'];
    reportType = json['reportType'];
    sessionNotes = json['sessionNotes'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['patientId'] = this.patientId;
    data['providerId'] = this.providerId;
    data['appointmentId'] = this.appointmentId;
    data['reportLink'] = this.reportLink;
    data['reportType'] = this.reportType;
    data['sessionNotes'] = this.sessionNotes;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
