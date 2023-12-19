import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/lms/display/course_home/data/model/course_home_banner_model.dart';
import 'package:solh/features/lms/display/course_home/domain/entities/course_banner_entity.dart';
import 'package:solh/features/lms/display/course_home/domain/usecases/course_banner_usecase.dart';

class CourseBannerController extends GetxController {
  final CourseBannerUsecase courseBannerUsecase;
  var bannerList = <BannerList>[].obs;
  var isLoading = false.obs;
  var err = ''.obs;

  CourseBannerController({required this.courseBannerUsecase});

  Future<void> getCourseHomeBanner() async {
    try {
      isLoading.value = true;
      final DataState<CourseBannerEntity> dataState =
          await courseBannerUsecase.call(RequestParams(
              url: "${APIConstants.api}/api/lms/user/get-banner"));
      if (dataState.data != null) {
        bannerList.value = dataState.data!.bannerList ?? [];
      } else {
        err.value = dataState.exception.toString();
      }
    } on Exception catch (e) {
      err.value = e.toString();
      isLoading.value = false;
    }
  }
}
