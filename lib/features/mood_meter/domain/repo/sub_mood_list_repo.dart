import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/features/mood_meter/domain/entities/sub_mood_entity.dart';

import '../../../../core/request_params/request_params.dart';

abstract class SubMoodListRepo {
  Future<DataState<List<SubMoodEntity>>> getSubMoodList(
      RequestParams requestParams);
}
