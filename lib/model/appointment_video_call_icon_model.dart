class AppointmentVideoCallIconModel {
  bool? success;
  Data? data;

  AppointmentVideoCallIconModel({this.success, this.data});

  AppointmentVideoCallIconModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? sId;
  String? token;
  String? channelName;

  Data({this.sId, this.token, this.channelName});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    token = json['token'];
    channelName = json['channelName'];
  }
}
