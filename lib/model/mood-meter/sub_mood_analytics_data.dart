class SubMoodAnlyticsModel {
  bool? success;
  String? message;
  List<Data>? data;
  Mood? mood;

  SubMoodAnlyticsModel({this.success, this.message, this.data});

  SubMoodAnlyticsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }

    mood = json['mood'] != null ? new Mood.fromJson(json['mood']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? parentId;
  int? moodCount;

  Data({this.sId, this.name, this.parentId, this.moodCount});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    parentId = json['parentId'];
    moodCount = json['moodCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['parentId'] = this.parentId;
    data['moodCount'] = this.moodCount;
    return data;
  }
}

class Mood {
  String? sId;
  String? name;

  Mood({this.sId, this.name});

  Mood.fromJson(Map<String, dynamic> json) {
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
