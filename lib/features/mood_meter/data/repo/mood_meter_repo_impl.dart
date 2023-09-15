import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/mood_meter/data/models/mood_meter_model.dart';
import 'package:solh/features/mood_meter/domain/entities/mood_meter_entity.dart';
import 'package:solh/features/mood_meter/domain/repo/mood_meter_repo.dart';
import 'package:solh/services/network/network.dart';

class MoodMeterRepoImpl implements MoodMeterRepo {
  @override
  Future<DataState<List<MoodMeterEntity>>> getMoodList(
      RequestParams requestParams) async {
    try {
      final Map<String, dynamic> map =
          await Network.makeGetRequestWithToken(requestParams.url);
      if (map.isNotEmpty) {
        final value = MoodMeterModel.fromJson(map);
        if (value.success!) {
          return DataSuccess(data: value.moodList);
        } else {
          return DataError(exception: Exception("Some issue in parsing value"));
        }
      } else {
        return DataError(exception: Exception("No Mood List found"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
