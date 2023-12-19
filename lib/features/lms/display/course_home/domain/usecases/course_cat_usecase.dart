import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/lms/display/course_home/domain/entities/course_cat_entity.dart';
import 'package:solh/features/lms/display/course_home/domain/repo/course_cat_repo.dart';

class CourseCatUsecase extends Usecase {
  final CourseCatRepo courseCatRepo;

  CourseCatUsecase({required this.courseCatRepo});
  @override
  Future<DataState<CourseCatEntity>> call(params) async {
    return await courseCatRepo.getCourseCat(params);
  }
}
