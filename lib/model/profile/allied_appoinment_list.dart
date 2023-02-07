class AlliedAppoinmentModel {
  bool? success;
  List<UserPackageOrders>? userPackageOrders;

  AlliedAppoinmentModel({this.success, this.userPackageOrders});

  AlliedAppoinmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['userPackageOrders'] != null) {
      userPackageOrders = <UserPackageOrders>[];
      json['userPackageOrders'].forEach((v) {
        userPackageOrders!.add(new UserPackageOrders.fromJson(v));
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
    return data;
  }
}

class UserPackageOrders {
  String? packagePaymentType;
  String? packagePaymentStatus;
  String? sId;
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
