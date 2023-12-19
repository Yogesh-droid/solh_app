import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/lms/display/course_listing/domain/entities/course_list_entity.dart';
import 'package:solh/features/lms/display/course_listing/domain/repo/course_list_repo.dart';

class CourseListUsecase extends Usecase {
  final CourseListRepo courseListRepo;

  CourseListUsecase({required this.courseListRepo});
  @override
  Future<DataState<CourseListEntity>> call(params) async {
    return await courseListRepo.getCourseList(params);
  }
}
