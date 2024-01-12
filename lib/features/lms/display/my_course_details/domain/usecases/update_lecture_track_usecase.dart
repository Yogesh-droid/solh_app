import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/lms/display/my_course_details/domain/repo/udpate_lecture_track_repo.dart';

class UpdateLectureTrackUsecase extends Usecase {
  final UpdateLectureTrackRepo updateLectureTrackRepo;

  UpdateLectureTrackUsecase({required this.updateLectureTrackRepo});
  @override
  Future<DataState<Map<String, dynamic>>> call(params) async {
    return await updateLectureTrackRepo.updateLecture(params);
  }
}
