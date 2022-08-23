class UserAppointmentModel {
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

  ScheduldAppointments(
      {this.doctor, this.patient, this.scheduledOn, this.scheduleTime});

  ScheduldAppointments.fromJson(Map<String, dynamic> json) {
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
