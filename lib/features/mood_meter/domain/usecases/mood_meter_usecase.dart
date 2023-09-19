import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/mood_meter/domain/entities/mood_meter_entity.dart';
import 'package:solh/features/mood_meter/domain/repo/mood_meter_repo.dart';

import '../../../../core/data_state/data_state.dart';

class MoodMeterUsecase extends Usecase {
  final MoodMeterRepo moodMeterRepo;

  MoodMeterUsecase({required this.moodMeterRepo});
  @override
  Future<DataState<List<MoodMeterEntity>>> call(params) {
    return moodMeterRepo.getMoodList(params);
  }
}
