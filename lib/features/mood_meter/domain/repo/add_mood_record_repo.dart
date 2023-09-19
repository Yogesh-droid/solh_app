import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';

abstract class AddMoodRecordRepo {
  Future<DataState<Map<String, dynamic>>> addMoodRecord(
      RequestParams requestParams);
}
