import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/lms/display/course_cart/domain/repo/add_course_to_cart_repo.dart';

class AddCourseToCartUsecase extends Usecase {
  final AddCourseToCartRepo addCourseToCartRepo;

  AddCourseToCartUsecase({required this.addCourseToCartRepo});
  @override
  Future<DataState<Map<String, dynamic>>> call(params) async {
    return await addCourseToCartRepo.addToCart(params);
  }
}
