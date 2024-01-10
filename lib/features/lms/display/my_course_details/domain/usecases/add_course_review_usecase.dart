import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';

import '../repo/add_course_review_repo.dart';

class AddCourseReviewUsecase extends Usecase {
  final AddCourseReviewRepo addCourseReviewRepo;

  AddCourseReviewUsecase({required this.addCourseReviewRepo});
  @override
  Future<DataState<Map<String, dynamic>>> call(params) async {
    return await addCourseReviewRepo.addReview(params);
  }
}
