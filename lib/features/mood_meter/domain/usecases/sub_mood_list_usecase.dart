import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/features/mood_meter/domain/entities/sub_mood_entity.dart';
import 'package:solh/features/mood_meter/domain/repo/sub_mood_list_repo.dart';

import '../../../../core/usecase/usecase.dart';

class SubMoodListUsecase extends Usecase {
  final SubMoodListRepo subMoodListRepo;

  SubMoodListUsecase({required this.subMoodListRepo});
  @override
  Future<DataState<List<SubMoodEntity>>> call(params) async {
    return subMoodListRepo.getSubMoodList(params);
  }
}
