import 'package:solh/features/mood_meter/domain/entities/sub_mood_entity.dart';

class SubMoodListModel {
  bool? success;
  List<SubMoodList>? subMoodList;

  SubMoodListModel({this.success, this.subMoodList});

  SubMoodListModel.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    subMoodList = json["subMoodList"] == null
        ? null
        : (json["subMoodList"] as List)
            .map((e) => SubMoodList.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["success"] = success;
    if (subMoodList != null) {
      _data["subMoodList"] = subMoodList?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class SubMoodList extends SubMoodEntity {
  SubMoodList({String? id, dynamic media, String? name, int? energyLevel})
      : super(energyLevel: energyLevel, id: id, media: media, name: name);

  factory SubMoodList.fromJson(Map<String, dynamic> json) {
    return SubMoodList(
        id: json["_id"],
        media: json["media"],
        name: json["name"],
        energyLevel: json["energyLevel"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["_id"] = id;
    _data["media"] = media;
    _data["name"] = name;
    _data["energyLevel"] = energyLevel;
    return _data;
  }
}
