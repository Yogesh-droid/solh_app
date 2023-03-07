class UserAppointmentModel {
  bool? success;
  List<ScheduldAppointments>? scheduldAppointments;
  List<ScheduldAppointments>? completedAppointments;
  List<InHousePackageOrders>? inHousePackageOrders;

  UserAppointmentModel(
      {this.success, this.scheduldAppointments, this.completedAppointments});

  UserAppointmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['scheduldAppointments'] != null) {
      scheduldAppointments = <ScheduldAppointments>[];
      json['scheduldAppointments'].forEach((v) {
        scheduldAppointments!.add(new ScheduldAppointments.fromJson(v));
      });
    }
    if (json['completedAppointments'] != null) {
      completedAppointments = <ScheduldAppointments>[];
      json['completedAppointments'].forEach((v) {
        completedAppointments!.add(new ScheduldAppointments.fromJson(v));
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

    return data;
  }
}

class ScheduldAppointments {
  Patient? patient;
  String? appointmentId;
  SeekerTime? seekerTime;
  Doctor? doctor;
  String? apptFor;

  ScheduldAppointments(
      {this.patient,
      this.appointmentId,
      this.seekerTime,
      this.doctor,
      this.apptFor});

  ScheduldAppointments.fromJson(Map<String, dynamic> json) {
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
  String? carouselName;
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
      this.carouselName,
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
    carouselName = json['carouselName'];
    packageAboutPackage = json['packageAboutPackage'];
    packageBenefits = json['packageBenefits'];
    packageEquipment = json['packageEquipment'];
    packageCurrency = json['packageCurrency'];
    packageAmount = json['packageAmount'];
    userId = json['userId'];
    if (this.packageOwner != null) {
      json['packageOwner'] = this.packageOwner!.toJson();
    }
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
    data['packageOwner'] = this.packageOwner;
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




/* class UserAppointmentModel {
  bool? success;
  List<ScheduldAppointments>? scheduldAppointments;
  List<CompletedAppointments>? completedAppointments;

  UserAppointmentModel(
      {this.success, this.scheduldAppointments, this.completedAppointments});

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
    return data;
  }
}

class ScheduldAppointments {
  Doctor? doctor;
  Patient? patient;
  String? scheduledOn;
  String? scheduleTime;
  String? apptFor;

  ScheduldAppointments(
      {this.doctor,
      this.patient,
      this.scheduledOn,
      this.scheduleTime,
      this.apptFor});

  ScheduldAppointments.fromJson(Map<String, dynamic> json) {
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    scheduledOn = json['scheduledOn'];
    scheduleTime = json['scheduleTime'];
    apptFor = json['apptFor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    data['scheduledOn'] = this.scheduledOn;
    data['scheduleTime'] = this.scheduleTime;
    data['apptFor'] = this.apptFor;
    return data;
  }
}

class CompletedAppointments {
  Doctor? doctor;
  Patient? patient;
  String? scheduledOn;
  String? scheduleTime;

  CompletedAppointments(
      {this.doctor, this.patient, this.scheduledOn, this.scheduleTime});

  CompletedAppointments.fromJson(Map<String, dynamic> json) {
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    patient =
        json['patient'] != null ? new Patient.fromJson(json['patient']) : null;
    scheduledOn = json['scheduledOn'];
    scheduleTime = json['scheduleTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    data['scheduledOn'] = this.scheduledOn;
    data['scheduleTime'] = this.scheduleTime;
    return data;
  }
}

class Doctor {
  String? sId;
  String? name;
  String? profilePicture;

  Doctor({this.sId, this.name, this.profilePicture});

  Doctor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}

class Patient {
  String? sId;
  String? profilePicture;
  String? name;
  String? id;

  Patient({this.sId, this.profilePicture, this.name, this.id});

  Patient.fromJson(Map<String, dynamic> json) {
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
 */