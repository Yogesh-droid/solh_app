class MoodAnalyticsModel {
  bool? success;
  List<MoodAnalytic>? moodAnalytic;
  int? avgMood;
  AvgFeeling? avgFeeling;

  MoodAnalyticsModel(
      {this.success, this.moodAnalytic, this.avgMood, this.avgFeeling});

  MoodAnalyticsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['moodAnalytic'] != null) {
      moodAnalytic = <MoodAnalytic>[];
      json['moodAnalytic'].forEach((v) {
        moodAnalytic!.add(new MoodAnalytic.fromJson(v));
      });
    }
    avgMood = json['avgMood'];
    avgFeeling = json['avgFeeling'] != null
        ? new AvgFeeling.fromJson(json['avgFeeling'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.moodAnalytic != null) {
      data['moodAnalytic'] = this.moodAnalytic!.map((v) => v.toJson()).toList();
    }
    data['avgMood'] = this.avgMood;
    if (this.avgFeeling != null) {
      data['avgFeeling'] = this.avgFeeling!.toJson();
    }
    return data;
  }
}

class MoodAnalytic {
  String? sId;
  String? name;
  String? hexCode;
  int? energyLevel;
  String? media;
  int? moodCount;

  MoodAnalytic(
      {this.sId,
      this.name,
      this.hexCode,
      this.energyLevel,
      this.media,
      this.moodCount});

  MoodAnalytic.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    hexCode = json['hexCode'];
    energyLevel = json['energyLevel'];
    media = json['media'];
    moodCount = json['moodCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['hexCode'] = this.hexCode;
    data['energyLevel'] = this.energyLevel;
    data['media'] = this.media;
    data['moodCount'] = this.moodCount;
    return data;
  }
}

class AvgFeeling {
  String? sId;
  String? name;
  int? energyLevel;
  String? media;
  String? hexCode;

  AvgFeeling({this.sId, this.name, this.energyLevel, this.media, this.hexCode});

  AvgFeeling.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    energyLevel = json['energyLevel'];
    media = json['media'];
    hexCode = json['hexCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['energyLevel'] = this.energyLevel;
    data['media'] = this.media;
    data['hexCode'] = this.hexCode;
    return data;
  }
}
