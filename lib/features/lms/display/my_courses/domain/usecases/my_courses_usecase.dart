import 'package:solh/features/lms/display/my_courses/domain/repo/my_courses_repo.dart';
import 'package:solh/ui/screens/products/core/usecase/usecase.dart';

class MyCourseUseCase extends Usecase {
  MyCourseRepo myCourseRepo;

  MyCourseUseCase({required this.myCourseRepo});
  @override
  Future call(params) async {
    return await myCourseRepo.getMyCourses(requestParams: params);
  }
}
