import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/mood_meter/domain/entities/mood_meter_entity.dart';

abstract class MoodMeterRepo {
  Future<DataState<List<MoodMeterEntity>>> getMoodList(
      RequestParams requestParams);
}
