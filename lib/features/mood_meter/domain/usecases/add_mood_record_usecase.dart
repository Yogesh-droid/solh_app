import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/mood_meter/domain/repo/add_mood_record_repo.dart';

class AddMoodRecordUsecase extends Usecase {
  final AddMoodRecordRepo addMoodRecordRepo;

  AddMoodRecordUsecase({required this.addMoodRecordRepo});
  @override
  Future<DataState<Map<String, dynamic>>> call(params) async {
    return addMoodRecordRepo.addMoodRecord(params);
  }
}
