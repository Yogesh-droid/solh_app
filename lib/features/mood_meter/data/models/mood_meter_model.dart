import 'package:solh/features/mood_meter/domain/entities/mood_meter_entity.dart';

class MoodMeterModel {
  bool? success;
  List<MoodList>? moodList;

  MoodMeterModel({this.success, this.moodList});

  MoodMeterModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    moodList = json["moodList"] == null
        ? null
        : (json["moodList"] as List).map((e) => MoodList.fromJson(e)).toList();
  }
}

class MoodList extends MoodMeterEntity {
  MoodList(
      {String? id,
      String? name,
      int? energyLevel,
      String? media,
      String? hexCode})
      : super(
            energyLevel: energyLevel,
            hexCode: hexCode,
            id: id,
            media: media,
            name: name);

  factory MoodList.fromJson(Map<String, dynamic> json) {
    return MoodList(
        id: json["_id"],
        name: json["name"],
        energyLevel: json["energyLevel"],
        media: json["media"],
        hexCode: json["hexCode"]);
  }
}
