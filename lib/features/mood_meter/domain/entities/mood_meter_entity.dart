import '../../data/models/mood_meter_model.dart';

class MoodMeterEntity {
  final bool? success;
  final List<MoodList>? moodList;
  final int? defaultIndex;
  MoodMeterEntity({this.defaultIndex, this.moodList, this.success});
}
