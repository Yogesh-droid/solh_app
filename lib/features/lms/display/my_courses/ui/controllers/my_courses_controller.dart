import 'dart:developer';

import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/features/lms/display/my_courses/data/model/my_courses_model.dart';
import 'package:solh/features/lms/display/my_courses/domain/usecases/my_courses_usecase.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';

class MyCoursesController extends GetxController {
  final MyCourseUseCase myCourseUseCase;
  var myCoursesModel = MyCoursesModel().obs;
  var selectedStatus = 'all'.obs;
  var isEnd = false.obs;
  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  int nextPage = 1;

  var err = ''.obs;

  MyCoursesController({required this.myCourseUseCase});

  Future<void> getCourseMyCources() async {
    try {
      nextPage > 1 ? isMoreLoading.value = true : isLoading.value = true;
      final DataState<MyCoursesModel> dataState = await myCourseUseCase.call(
          RequestParams(
              url:
                  "${APIConstants.api}/api/lms/user/my-courses?status=${selectedStatus.value}&page=$nextPage&limit=6"));
      if (dataState.data != null) {
        if (nextPage == 1) {
          myCoursesModel.value = dataState.data!;
        } else {
          myCoursesModel.value.myCourseList!
              .addAll(dataState.data!.myCourseList!.toList());
          myCoursesModel.refresh();
        }
        log(dataState.data!.pages!.next.toString(),
            name: "myCoursesModel.value.pages!.next");
        if (dataState.data!.pages!.next != null) {
          nextPage = dataState.data!.pages!.next!;
        } else {
          isEnd.value = true;
        }
        isLoading.value = false;
        isMoreLoading.value = false;
      } else {
        err.value = dataState.exception.toString();
        isLoading.value = false;
        isMoreLoading.value = false;
      }
    } on Exception catch (e) {
      err.value = e.toString();
      isLoading.value = false;
    }
  }
}
