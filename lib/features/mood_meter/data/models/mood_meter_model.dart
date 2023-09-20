import 'package:solh/features/mood_meter/domain/entities/mood_meter_entity.dart';

class MoodMeterModel extends MoodMeterEntity {
  MoodMeterModel({bool? success, List<MoodList>? moodList, int? defaultIndex})
      : super(defaultIndex: defaultIndex, moodList: moodList, success: success);

  factory MoodMeterModel.fromJson(Map<String, dynamic> json) {
    return MoodMeterModel(
        success: json["success"],
        moodList: json["moodList"] == null
            ? null
            : (json["moodList"] as List)
                .map((e) => MoodList.fromJson(e))
                .toList(),
        defaultIndex: json['defaultIndex']);
  }
}

class MoodList {
  String? id;
  String? name;
  int? energyLevel;
  String? media;
  String? hexCode;
  MoodList({this.id, this.name, this.energyLevel, this.media, this.hexCode});

  MoodList.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    name = json["name"];
    energyLevel = json["energyLevel"];
    media = json["media"];
    hexCode = json["hexCode"];
  }
}
