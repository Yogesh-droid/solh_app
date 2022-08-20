class DoctorsAppointmentModel {
  bool? success;
  List<ScheduldAppointments>? scheduldAppointments;
  List<CompletedAppointments>? completedAppointments;

  DoctorsAppointmentModel(
      {this.success, this.scheduldAppointments, this.completedAppointments});

  DoctorsAppointmentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['scheduldAppointments'] != null) {
      scheduldAppointments = <ScheduldAppointments>[];
      json['scheduldAppointments'].forEach((v) {
        scheduldAppointments!.add(new ScheduldAppointments.fromJson(v));
      });
    }
    if (json['complete0dAppointments'] != null) {
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
      data['complete0dAppointments'] =
          this.completedAppointments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScheduldAppointments {
  Provider? provider;
  Provider? patient;
  String? scheduledOn;
  String? scheduleTime;

  ScheduldAppointments(
      {this.provider, this.patient, this.scheduledOn, this.scheduleTime});

  ScheduldAppointments.fromJson(Map<String, dynamic> json) {
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    patient =
        json['patient'] != null ? new Provider.fromJson(json['patient']) : null;
    scheduledOn = json['scheduledOn'];
    scheduleTime = json['scheduleTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
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
  Provider? provider;
  Provider? patient;
  String? scheduledOn;
  String? scheduleTime;

  CompletedAppointments(
      {this.provider, this.patient, this.scheduledOn, this.scheduleTime});

  CompletedAppointments.fromJson(Map<String, dynamic> json) {
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    patient =
        json['patient'] != null ? new Provider.fromJson(json['patient']) : null;
    scheduledOn = json['scheduledOn'];
    scheduleTime = json['scheduleTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    if (this.patient != null) {
      data['patient'] = this.patient!.toJson();
    }
    data['scheduledOn'] = this.scheduledOn;
    data['scheduleTime'] = this.scheduleTime;
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
