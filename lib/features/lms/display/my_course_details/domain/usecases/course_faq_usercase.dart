import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/lms/display/my_course_details/domain/entities/course_faq_entity.dart';
import 'package:solh/features/lms/display/my_course_details/domain/repo/course_faq_repo.dart';

class CourseFaqUsecase extends Usecase {
  final CourseFaqRepo courseFaqRepo;

  CourseFaqUsecase({required this.courseFaqRepo});
  @override
  Future<DataState<CourseFaqEntity>> call(params) async {
    return await courseFaqRepo.getCourseFaq(params);
  }
}
