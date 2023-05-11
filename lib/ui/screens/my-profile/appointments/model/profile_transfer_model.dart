class ProfileTransferModel {
  bool? success;
  List<Details>? details;

  ProfileTransferModel({this.success, this.details});

  ProfileTransferModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? sId;
  ReferedBy? referedBy;
  ReferedBy? referedTo;
  UserStatus? userStatus;
  String? createdAt;

  Details({this.sId, this.referedBy, this.referedTo, this.createdAt});

  Details.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    referedBy = json['referedBy'] != null
        ? new ReferedBy.fromJson(json['referedBy'])
        : null;
    userStatus = json['userStatus'] != null
        ? new UserStatus.fromJson(json['userStatus'])
        : null;
    referedTo = json['referedTo'] != null
        ? new ReferedBy.fromJson(json['referedTo'])
        : null;
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.referedBy != null) {
      data['referedBy'] = this.referedBy!.toJson();
    }
    if (this.referedTo != null) {
      data['referedTo'] = this.referedTo!.toJson();
    }
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class ReferedBy {
  String? sId;
  String? profilePicture;
  String? name;
  String? id;

  ReferedBy({this.sId, this.profilePicture, this.name, this.id});

  ReferedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profilePicture'] = this.profilePicture;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class UserStatus {
  String? status;
  String? dateTime;

  UserStatus({this.status, this.dateTime});

  UserStatus.fromJson(Map<String, dynamic> json) {
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
