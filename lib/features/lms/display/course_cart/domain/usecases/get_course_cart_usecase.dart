import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/features/lms/display/course_cart/domain/entities/get_course_cart_entity.dart';
import 'package:solh/features/lms/display/course_cart/domain/repo/get_course_cart_repo.dart';

class GetCourseCartUsecase extends Usecase {
  final GetCourseCartRepo getCourseCartRepo;

  GetCourseCartUsecase({required this.getCourseCartRepo});
  @override
  Future<DataState<GetCourseCartEntity>> call(params) async {
    return await getCourseCartRepo.getCourseCart(params);
  }
}
