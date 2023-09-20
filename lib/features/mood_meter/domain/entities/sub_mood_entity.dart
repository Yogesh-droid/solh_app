import '../../data/models/sub_mood_list_model.dart';

class SubMoodEntity {
  final bool? success;
  final int? defaultIndex;
  final List<SubMoodList>? subMoodList;

  SubMoodEntity({this.success, this.defaultIndex, this.subMoodList});
}
