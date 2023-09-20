import 'package:solh/features/mood_meter/domain/entities/sub_mood_entity.dart';

class SubMoodListModel extends SubMoodEntity {
  SubMoodListModel(
      {bool? success, List<SubMoodList>? subMoodList, int? defaultIndex})
      : super(
            defaultIndex: defaultIndex,
            subMoodList: subMoodList,
            success: success);

  factory SubMoodListModel.fromJson(Map<String, dynamic> json) {
    return SubMoodListModel(
        success: json["success"],
        defaultIndex: json['defaultIndex'],
        subMoodList: json["subMoodList"] == null
            ? null
            : (json["subMoodList"] as List)
                .map((e) => SubMoodList.fromJson(e))
                .toList());
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

class SubMoodList {
  String? id;
  String? media;
  String? name;
  int? energyLevel;
  SubMoodList({this.id, this.media, this.name, this.energyLevel});

  SubMoodList.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    media = json["media"];
    name = json["name"];
    energyLevel = json["energyLevel"];
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
