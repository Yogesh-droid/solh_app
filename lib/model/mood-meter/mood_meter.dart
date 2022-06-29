class MoodMeterModel {
  bool? success;
  List<MoodList>? moodList;

  MoodMeterModel({this.success, this.moodList});

  MoodMeterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['moodList'] != null) {
      moodList = <MoodList>[];
      json['moodList'].forEach((v) {
        moodList!.add(new MoodList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.moodList != null) {
      data['moodList'] = this.moodList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MoodList {
  String? sId;
  String? name;
  int? energyLevel;
  String? media;

  MoodList({this.sId, this.name, this.energyLevel, this.media});

  MoodList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    energyLevel = json['energyLevel'];
    media = json['media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['energyLevel'] = this.energyLevel;
    data['media'] = this.media;
    return data;
  }
}
