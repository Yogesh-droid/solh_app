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
  SeekerTime? seekerTime;
  SeekerTime? providerTime;
  String? sId;
  Provider? provider;
  String? status;
  Provider? patientId;
  String? startDate;
  String? id;

  ScheduldAppointments(
      {this.seekerTime,
      this.providerTime,
      this.sId,
      this.provider,
      this.status,
      this.patientId,
      this.startDate,
      this.id});

  ScheduldAppointments.fromJson(Map<String, dynamic> json) {
    seekerTime = json['seekerTime'] != null
        ? new SeekerTime.fromJson(json['seekerTime'])
        : null;
    providerTime = json['providerTime'] != null
        ? new SeekerTime.fromJson(json['providerTime'])
        : null;
    sId = json['_id'];
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    status = json['status'];
    patientId = json['patientId'] != null
        ? new Provider.fromJson(json['patientId'])
        : null;
    startDate = json['startDate'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seekerTime != null) {
      data['seekerTime'] = this.seekerTime!.toJson();
    }
    if (this.providerTime != null) {
      data['providerTime'] = this.providerTime!.toJson();
    }
    data['_id'] = this.sId;
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    data['status'] = this.status;
    if (this.patientId != null) {
      data['patientId'] = this.patientId!.toJson();
    }
    data['startDate'] = this.startDate;
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

class CompletedAppointments {
  SeekerTime? seekerTime;
  SeekerTime? providerTime;
  String? sId;
  Provider? provider;
  String? status;
  Provider? patientId;
  String? startDate;
  String? id;

  CompletedAppointments(
      {this.seekerTime,
      this.providerTime,
      this.sId,
      this.provider,
      this.status,
      this.patientId,
      this.startDate,
      this.id});

  CompletedAppointments.fromJson(Map<String, dynamic> json) {
    seekerTime = json['seekerTime'] != null
        ? new SeekerTime.fromJson(json['seekerTime'])
        : null;
    providerTime = json['providerTime'] != null
        ? new SeekerTime.fromJson(json['providerTime'])
        : null;
    sId = json['_id'];
    provider = json['provider'] != null
        ? new Provider.fromJson(json['provider'])
        : null;
    status = json['status'];
    patientId = json['patientId'] != null
        ? new Provider.fromJson(json['patientId'])
        : null;
    startDate = json['startDate'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.seekerTime != null) {
      data['seekerTime'] = this.seekerTime!.toJson();
    }
    if (this.providerTime != null) {
      data['providerTime'] = this.providerTime!.toJson();
    }
    data['_id'] = this.sId;
    if (this.provider != null) {
      data['provider'] = this.provider!.toJson();
    }
    data['status'] = this.status;
    if (this.patientId != null) {
      data['patientId'] = this.patientId!.toJson();
    }
    data['startDate'] = this.startDate;
    data['id'] = this.id;
    return data;
  }
}
