class AlliedAppoinmentModel {
  bool? success;
  List<UserPackageOrders>? userPackageOrders;
  List<InHousePackageOrders>? inHousePackageOrders;

  AlliedAppoinmentModel(
      {this.success, this.userPackageOrders, this.inHousePackageOrders});

  AlliedAppoinmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['userPackageOrders'] != null) {
      userPackageOrders = <UserPackageOrders>[];
      json['userPackageOrders'].forEach((v) {
        userPackageOrders!.add(new UserPackageOrders.fromJson(v));
      });
    }
    if (json['inHousePackageOrders'] != null) {
      inHousePackageOrders = <InHousePackageOrders>[];
      json['inHousePackageOrders'].forEach((v) {
        inHousePackageOrders!.add(new InHousePackageOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.userPackageOrders != null) {
      data['userPackageOrders'] =
          this.userPackageOrders!.map((v) => v.toJson()).toList();
    }
    if (this.inHousePackageOrders != null) {
      data['inHousePackageOrders'] =
          this.inHousePackageOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserPackageOrders {
  String? packagePaymentType;
  String? packagePaymentStatus;
  String? sId;
  Null? appointmentId;
  String? status;
  List<Null>? videoSessions;
  String? packageName;
  String? packageSlug;
  String? packageDuration;
  String? packageUnitDuration;
  String? packageAboutPackage;
  String? packageBenefits;
  String? packageEquipment;
  String? packageCurrency;
  int? packageAmount;
  String? userId;
  String? packageOwner;
  String? packageType;
  String? packageCategory;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<PackageVideoSessions>? packageVideoSessions;
  List<Provider>? provider;
  String? id;

  UserPackageOrders(
      {this.packagePaymentType,
      this.packagePaymentStatus,
      this.sId,
      this.appointmentId,
      this.status,
      this.videoSessions,
      this.packageName,
      this.packageSlug,
      this.packageDuration,
      this.packageUnitDuration,
      this.packageAboutPackage,
      this.packageBenefits,
      this.packageEquipment,
      this.packageCurrency,
      this.packageAmount,
      this.userId,
      this.packageOwner,
      this.packageType,
      this.packageCategory,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.packageVideoSessions,
      this.provider,
      this.id});

  UserPackageOrders.fromJson(Map<String, dynamic> json) {
    packagePaymentType = json['packagePaymentType'];
    packagePaymentStatus = json['packagePaymentStatus'];
    sId = json['_id'];
    appointmentId = json['appointmentId'];
    status = json['status'];
    if (json['videoSessions'] != null) {
      videoSessions = <Null>[];
      json['videoSessions'].forEach((v) {
        videoSessions!.add(v);
      });
    }
    packageName = json['packageName'];
    packageSlug = json['packageSlug'];
    packageDuration = json['packageDuration'];
    packageUnitDuration = json['packageUnitDuration'];
    packageAboutPackage = json['packageAboutPackage'];
    packageBenefits = json['packageBenefits'];
    packageEquipment = json['packageEquipment'];
    packageCurrency = json['packageCurrency'];
    packageAmount = json['packageAmount'];
    userId = json['userId'];
    packageOwner = json['packageOwner'];
    packageType = json['packageType'];
    packageCategory = json['packageCategory'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['packageVideoSessions'] != null) {
      packageVideoSessions = <PackageVideoSessions>[];
      json['packageVideoSessions'].forEach((v) {
        packageVideoSessions!.add(new PackageVideoSessions.fromJson(v));
      });
    }
    if (json['provider'] != null) {
      provider = <Provider>[];
      json['provider'].forEach((v) {
        provider!.add(new Provider.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packagePaymentType'] = this.packagePaymentType;
    data['packagePaymentStatus'] = this.packagePaymentStatus;
    data['_id'] = this.sId;
    data['appointmentId'] = this.appointmentId;
    data['status'] = this.status;
    // if (this.videoSessions != null) {
    //   data['videoSessions'] =
    //       this.videoSessions!.map((v) => v?.toJson()).toList();
    // }
    data['packageName'] = this.packageName;
    data['packageSlug'] = this.packageSlug;
    data['packageDuration'] = this.packageDuration;
    data['packageUnitDuration'] = this.packageUnitDuration;
    data['packageAboutPackage'] = this.packageAboutPackage;
    data['packageBenefits'] = this.packageBenefits;
    data['packageEquipment'] = this.packageEquipment;
    data['packageCurrency'] = this.packageCurrency;
    data['packageAmount'] = this.packageAmount;
    data['userId'] = this.userId;
    data['packageOwner'] = this.packageOwner;
    data['packageType'] = this.packageType;
    data['packageCategory'] = this.packageCategory;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.packageVideoSessions != null) {
      data['packageVideoSessions'] =
          this.packageVideoSessions!.map((v) => v.toJson()).toList();
    }
    if (this.provider != null) {
      data['provider'] = this.provider!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
}

class PackageVideoSessions {
  String? vName;
  String? vDescription;
  String? sId;

  PackageVideoSessions({this.vName, this.vDescription, this.sId});

  PackageVideoSessions.fromJson(Map<String, dynamic> json) {
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

class Provider {
  String? sId;
  String? profilePicture;
  String? name;
  String? id;

  Provider({this.sId, this.profilePicture, this.name, this.id});

  Provider.fromJson(Map<String, dynamic> json) {
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

class InHousePackageOrders {
  String? sId;
  Null? appointmentId;
  String? status;
  String? packageName;
  String? packageSlug;
  String? packageDuration;
  String? packageUnitDuration;
  String? packageAboutPackage;
  String? packageBenefits;
  String? packageEquipment;
  String? packageCurrency;
  int? packageAmount;
  String? userId;
  PackageOwner? packageOwner;
  String? packageType;
  String? mainCategory;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? iV;

  InHousePackageOrders(
      {this.sId,
      this.appointmentId,
      this.status,
      this.packageName,
      this.packageSlug,
      this.packageDuration,
      this.packageUnitDuration,
      this.packageAboutPackage,
      this.packageBenefits,
      this.packageEquipment,
      this.packageCurrency,
      this.packageAmount,
      this.userId,
      this.packageOwner,
      this.packageType,
      this.mainCategory,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.iV});

  InHousePackageOrders.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    appointmentId = json['appointmentId'];
    status = json['status'];
    packageName = json['packageName'];
    packageSlug = json['packageSlug'];
    packageDuration = json['packageDuration'];
    packageUnitDuration = json['packageUnitDuration'];
    packageAboutPackage = json['packageAboutPackage'];
    packageBenefits = json['packageBenefits'];
    packageEquipment = json['packageEquipment'];
    packageCurrency = json['packageCurrency'];
    packageAmount = json['packageAmount'];
    userId = json['userId'];
    packageOwner = json['packageOwner'] != null
        ? new PackageOwner.fromJson(json['packageOwner'])
        : null;
    packageType = json['packageType'];
    mainCategory = json['mainCategory'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['appointmentId'] = this.appointmentId;
    data['status'] = this.status;
    data['packageName'] = this.packageName;
    data['packageSlug'] = this.packageSlug;
    data['packageDuration'] = this.packageDuration;
    data['packageUnitDuration'] = this.packageUnitDuration;
    data['packageAboutPackage'] = this.packageAboutPackage;
    data['packageBenefits'] = this.packageBenefits;
    data['packageEquipment'] = this.packageEquipment;
    data['packageCurrency'] = this.packageCurrency;
    data['packageAmount'] = this.packageAmount;
    data['userId'] = this.userId;
    if (this.packageOwner != null) {
      data['packageOwner'] = this.packageOwner!.toJson();
    }
    data['packageType'] = this.packageType;
    data['mainCategory'] = this.mainCategory;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class PackageOwner {
  String? sId;
  String? name;

  PackageOwner({this.sId, this.name});

  PackageOwner.fromJson(Map<String, dynamic> json) {
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
