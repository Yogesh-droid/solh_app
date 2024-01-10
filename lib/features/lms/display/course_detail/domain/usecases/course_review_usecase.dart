import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/lms/display/course_detail/domain/entities/course_review_entity.dart';
import 'package:solh/features/lms/display/course_detail/domain/repo/course_review_repo.dart';

class CourseReviewUsecase extends Usecase {
  final CourseReviewRepo courseReviewRepo;

  CourseReviewUsecase({required this.courseReviewRepo});
  @override
  Future<DataState<CourseReviewEntity>> call(params) async {
    return await courseReviewRepo.getCourseReviews(params);
  }
}
