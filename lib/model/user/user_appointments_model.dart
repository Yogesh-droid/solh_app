class UserAppointmentModel {
  bool? success;
  List<ScheduldAppointments>? scheduldAppointments;
  List<CompletedAppointments>? completedAppointments;
  List<InHousePackageOrders>? inHousePackageOrders;

  UserAppointmentModel(
      {this.success,
      this.scheduldAppointments,
      this.completedAppointments,
      this.inHousePackageOrders});

  UserAppointmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['scheduldAppointments'] != null) {
      scheduldAppointments = <ScheduldAppointments>[];
      json['scheduldAppointments'].forEach((v) {
        scheduldAppointments!.add(new ScheduldAppointments.fromJson(v));
      });
    }
    if (json['completedAppointments'] != null) {
      completedAppointments = <CompletedAppointments>[];
      json['completedAppointments'].forEach((v) {
        completedAppointments!.add(new CompletedAppointments.fromJson(v));
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
    if (this.scheduldAppointments != null) {
      data['scheduldAppointments'] =
          this.scheduldAppointments!.map((v) => v.toJson()).toList();
    }
    if (this.completedAppointments != null) {
      data['completedAppointments'] =
          this.completedAppointments!.map((v) => v.toJson()).toList();
    }
    if (this.inHousePackageOrders != null) {
      data['inHousePackageOrders'] =
          this.inHousePackageOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScheduldAppointments {
  Patient? patient;
  String? appointmentId;
  int? amount;
  String? currency;
  String? status;
  SeekerTime? seekerTime;
  Doctor? doctor;
  String? apptFor;
  List<Transaction>? transaction;
  String? feeCode;
  ScheduldAppointments(
      {this.patient,
      this.appointmentId,
      this.amount,
      this.currency,
      this.status,
      this.seekerTime,
      this.transaction,
      this.doctor,
      this.apptFor,
      this.feeCode});

  ScheduldAppointments.fromJson(Map<String, dynamic> json) {
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    appointmentId = json['appointmentId'];
    amount = json['amount'];
    currency = json['currency'];
    status = json['status'];
    if (json['Transaction'] != null) {
      transaction = <Transaction>[];
      json['Transaction'].forEach((v) {
        transaction!.add(new Transaction.fromJson(v));
      });
    }
    seekerTime = json['seekerTime'] != null
        ? new SeekerTime.fromJson(json['seekerTime'])
        : null;
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    apptFor = json['apptFor'];
    feeCode = json['feeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    data['appointmentId'] = this.appointmentId;
    if (this.seekerTime != null) {
      data['seekerTime'] = this.seekerTime!.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    data['apptFor'] = this.apptFor;
    return data;
  }
}

class Patient {
  String? sId;
  String? name;
  String? profilePicture;
  String? id;

  Patient({this.sId, this.name, this.profilePicture, this.id});

  Patient.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    profilePicture = json['profilePicture'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    data['id'] = this.id;
    return data;
  }
}

class CompletedAppointments {
  Patient? patient;
  String? appointmentId;
  SeekerTime? seekerTime;
  Doctor? doctor;
  String? apptFor;

  CompletedAppointments(
      {this.patient,
      this.appointmentId,
      this.seekerTime,
      this.doctor,
      this.apptFor});

  CompletedAppointments.fromJson(Map<String, dynamic> json) {
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    appointmentId = json['appointmentId'];
    seekerTime = json['seekerTime'] != null
        ? new SeekerTime.fromJson(json['seekerTime'])
        : null;
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    apptFor = json['apptFor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    data['appointmentId'] = this.appointmentId;
    if (this.seekerTime != null) {
      data['seekerTime'] = this.seekerTime!.toJson();
    }
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    data['apptFor'] = this.apptFor;
    return data;
  }
}

class SeekerTime {
  String? zone;
  String? offset;
  String? time;

  SeekerTime({this.zone, this.offset, this.time});

  SeekerTime.fromJson(Map<String, dynamic> json) {
    zone = json['zone'];
    offset = json['offset'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zone'] = this.zone;
    data['offset'] = this.offset;
    data['time'] = this.time;
    return data;
  }
}

class Doctor {
  String? sId;
  String? profilePicture;
  List<Specialization>? specialization;
  String? name;
  String? id;

  Doctor(
      {this.sId, this.profilePicture, this.specialization, this.name, this.id});

  Doctor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profilePicture = json['profilePicture'];
    if (json['specialization'] != null) {
      specialization = <Specialization>[];
      json['specialization'].forEach((v) {
        specialization!.add(new Specialization.fromJson(v));
      });
    }
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profilePicture'] = this.profilePicture;
    if (this.specialization != null) {
      data['specialization'] =
          this.specialization!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
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

class InHousePackageOrders {
  String? sId;
  String? appointmentId;
  String? status;
  String? packagePaymentType;
  String? packagePaymentStatus;
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
  List<Transaction>? transaction;

  InHousePackageOrders(
      {this.sId,
      this.appointmentId,
      this.status,
      this.packagePaymentType,
      this.packagePaymentStatus,
      this.packageName,
      this.packageSlug,
      this.packageDuration,
      this.packageUnitDuration,
      this.packageAboutPackage,
      this.packageBenefits,
      this.packageEquipment,
      this.packageCurrency,
      this.transaction,
      this.packageAmount,
      this.userId,
      this.packageOwner,
      this.packageType,
      this.mainCategory,
      this.carouselName,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.iV});

  InHousePackageOrders.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    appointmentId = json['appointmentId'];
    status = json['status'];
    packagePaymentType = json['packagePaymentType'];
    packagePaymentStatus = json['packagePaymentStatus'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['appointmentId'] = this.appointmentId;
    data['status'] = this.status;
    data['packagePaymentType'] = this.packagePaymentType;
    data['packagePaymentStatus'] = this.packagePaymentStatus;
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
