import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/features/lms/display/my_courses/data/model/my_courses_model.dart';
import 'package:solh/features/lms/display/my_courses/domain/usecases/my_courses_usecase.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';

class MyCoursesController extends GetxController {
  final MyCourseUseCase myCourseUseCase;
  var myCoursesModel = MyCoursesModel().obs;
  var isEnd = false.obs;
  var isLoading = false.obs;
  var err = ''.obs;

  MyCoursesController({required this.myCourseUseCase});

  Future<void> getCourseMyCources() async {
    try {
      isLoading.value = true;
      final DataState<MyCoursesModel> dataState = await myCourseUseCase.call(
          RequestParams(
              url:
                  "${APIConstants.api}/api/lms/user/my-courses?page=1&limit=10"));
      if (dataState.data != null) {
        myCoursesModel.value = dataState.data!;
        isLoading.value = false;
      } else {
        err.value = dataState.exception.toString();
        isLoading.value = false;
      }
    } on Exception catch (e) {
      err.value = e.toString();
      isLoading.value = false;
    }
  }
}
