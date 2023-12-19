import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/lms/display/course_home/domain/entities/featured_course_entity.dart';
import 'package:solh/features/lms/display/course_home/domain/repo/featured_course_repo.dart';

class FeaturedCourseUsecase extends Usecase {
  final FeaturedCourseRepo featuredCourseRepo;

  FeaturedCourseUsecase({required this.featuredCourseRepo});

  @override
  Future<DataState<FeaturedCourseEntity>> call(params) async {
    return await featuredCourseRepo.getFeaturedCourse(params);
  }
}
