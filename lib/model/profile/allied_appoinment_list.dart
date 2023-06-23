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
  String? appointmentId;
  String? status;
  List<PackageVideoSessions>? packageVideoSessions;
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
  String? createdAt;
  String? updatedAt;
  String? carouselName;
  int? iV;
  List<Provider>? provider;
  String? id;
  String? createdBy;
  String? updatedBy;
  List<Transaction>? transaction;
  String? feeCode;

  UserPackageOrders(
      {this.packagePaymentType,
      this.packagePaymentStatus,
      this.sId,
      this.appointmentId,
      this.status,
      this.packageVideoSessions,
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
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.carouselName,
      this.provider,
      this.id,
      this.createdBy,
      this.feeCode,
      this.updatedBy});

  UserPackageOrders.fromJson(Map<String, dynamic> json) {
    packagePaymentType = json['packagePaymentType'];
    packagePaymentStatus = json['packagePaymentStatus'];
    sId = json['_id'];
    appointmentId = json['appointmentId'];
    status = json['status'];
    if (json['packageVideoSessions'] != null) {
      packageVideoSessions = <PackageVideoSessions>[];
      json['packageVideoSessions'].forEach((v) {
        packageVideoSessions!.add(new PackageVideoSessions.fromJson(v));
      });
    }
    packageName = json['packageName'];
    if (json['Transaction'] != null) {
      transaction = <Transaction>[];
      json['Transaction'].forEach((v) {
        transaction!.add(new Transaction.fromJson(v));
      });
    }
    packageSlug = json['packageSlug'];
    packageDuration = json['packageDuration'];
    packageUnitDuration = json['packageUnitDuration'];
    packageAboutPackage = json['packageAboutPackage'];
    carouselName = json['carouselName'];
    packageBenefits = json['packageBenefits'];
    packageEquipment = json['packageEquipment'];
    packageCurrency = json['packageCurrency'];
    packageAmount = json['packageAmount'];
    userId = json['userId'];
    packageOwner = json['packageOwner'];
    packageType = json['packageType'];
    packageCategory = json['packageCategory'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    feeCode = json["feeCode"];
    iV = json['__v'];
    if (json['provider'] != null) {
      provider = <Provider>[];
      json['provider'].forEach((v) {
        provider!.add(new Provider.fromJson(v));
      });
    }
    id = json['id'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['packagePaymentType'] = this.packagePaymentType;
    data['packagePaymentStatus'] = this.packagePaymentStatus;
    data['_id'] = this.sId;
    data['appointmentId'] = this.appointmentId;
    data['status'] = this.status;
    if (this.packageVideoSessions != null) {
      data['packageVideoSessions'] =
          this.packageVideoSessions!.map((v) => v.toJson()).toList();
    }
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.provider != null) {
      data['provider'] = this.provider!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
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
  String? appointmentId;
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
  String? carouselName;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? packagePaymentType;
  String? packagePaymentStatus;
  List<Transaction>? transaction;

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
      this.carouselName,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.packagePaymentType,
      this.packagePaymentStatus});

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
    if (json['Transaction'] != null) {
      transaction = <Transaction>[];
      json['Transaction'].forEach((v) {
        transaction!.add(new Transaction.fromJson(v));
      });
    }
    packageOwner = json['packageOwner'] != null
        ? new PackageOwner.fromJson(json['packageOwner'])
        : null;
    packageType = json['packageType'];
    mainCategory = json['mainCategory'];
    carouselName = json['carouselName'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    packagePaymentType = json['packagePaymentType'];
    packagePaymentStatus = json['packagePaymentStatus'];
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
    data['carouselName'] = this.carouselName;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['packagePaymentType'] = this.packagePaymentType;
    data['packagePaymentStatus'] = this.packagePaymentStatus;
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

class Transaction {
  String? sId;
  String? inhouseOrderId;
  String? currency;
  String? amount;
  String? status;
  String? pgTransactionId;

  Transaction(
      {this.sId,
      this.inhouseOrderId,
      this.currency,
      this.amount,
      this.status,
      this.pgTransactionId});

  Transaction.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    inhouseOrderId = json['inhouseOrderId'];
    currency = json['currency'];
    amount = json['amount'];
    status = json['status'];
    pgTransactionId = json['pgTransactionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['inhouseOrderId'] = this.inhouseOrderId;
    data['currency'] = this.currency;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['pgTransactionId'] = this.pgTransactionId;
    return data;
  }
}
