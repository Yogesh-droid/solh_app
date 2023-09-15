import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/mood_meter/data/models/sub_mood_list_model.dart';
import 'package:solh/features/mood_meter/domain/entities/sub_mood_entity.dart';
import 'package:solh/features/mood_meter/domain/repo/sub_mood_list_repo.dart';
import 'package:solh/services/network/network.dart';

class SubMoodListRepoImpl implements SubMoodListRepo {
  @override
  Future<DataState<List<SubMoodEntity>>> getSubMoodList(
      RequestParams requestParams) async {
    try {
      Map<String, dynamic> map =
          await Network.makeGetRequestWithToken(requestParams.url);
      if (map.isNotEmpty) {
        final value = SubMoodListModel.fromJson(map);
        if (value.success!) {
          return DataSuccess(data: value.subMoodList);
        } else {
          return DataError(exception: Exception("Data parsing issue"));
        }
      } else {
        return DataError(exception: Exception("No Submood Found"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
