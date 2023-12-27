import 'dart:developer';

import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/features/lms/display/course_wishlist/domain/entities/course_wishlist_entity.dart';
import 'package:solh/features/lms/display/course_wishlist/domain/repo/course_wishlist_repo.dart';
import 'package:solh/ui/screens/products/core/usecase/usecase.dart';

class CourseWishlistUseCase extends Usecase {
  CourseWishlistRepo courseWishlistRepo;
  CourseWishlistUseCase({required this.courseWishlistRepo});
  @override
  Future<DataState<CourseWishlistEntity>> call(params) async {
    return await courseWishlistRepo.getCourseWishList(params);
  }
}
