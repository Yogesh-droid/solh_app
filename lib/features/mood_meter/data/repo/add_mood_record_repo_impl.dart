import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/mood_meter/domain/repo/add_mood_record_repo.dart';
import 'package:solh/services/network/network.dart';

class AddMoodRecordRepoImpl implements AddMoodRecordRepo {
  @override
  Future<DataState<Map<String, dynamic>>> addMoodRecord(
      RequestParams requestParams) async {
    try {
      Map<String, dynamic> map = await Network.makePostRequestWithToken(
          url: requestParams.url, body: requestParams.body!, isEncoded: true);
      if (map.isNotEmpty) {
        if (map['success']) {
          return DataSuccess(data: map);
        } else {
          return DataError(
              exception: Exception("Mood is Not added, Some Error Occured"));
        }
      } else {
        return DataError(
            exception: Exception("Mood is Not added, Some Error Occured"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
