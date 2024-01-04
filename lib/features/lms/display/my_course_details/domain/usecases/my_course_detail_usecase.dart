import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/lms/display/my_course_details/domain/entities/my_course_detail_entity.dart';
import 'package:solh/features/lms/display/my_course_details/domain/repo/my_course_detail_repo.dart';

class MyCourseDetailUsecase extends Usecase {
  final MyCourseDetailRepo myCourseDetailRepo;

  MyCourseDetailUsecase({required this.myCourseDetailRepo});
  @override
  Future<DataState<MyCourseDetailEntity>> call(params) async {
    return await myCourseDetailRepo.getMyCourseDetail(params);
  }
}
