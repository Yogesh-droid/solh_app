import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/lms/display/course_detail/domain/entities/course_details_entity.dart';
import 'package:solh/features/lms/display/course_detail/domain/repo/course_detail_repo.dart';

class CourseDetailUsecase extends Usecase {
  final CourseDetailRepo courseDetailRepo;

  CourseDetailUsecase({required this.courseDetailRepo});
  @override
  Future<DataState<CourseDetailsEntity>> call(params) async {
    return await courseDetailRepo.getCourseDetails(params);
  }
}
