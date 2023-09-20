import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/features/mood_meter/data/models/sub_mood_list_model.dart';
import 'package:solh/features/mood_meter/domain/entities/sub_mood_entity.dart';
import 'package:solh/features/mood_meter/domain/usecases/sub_mood_list_usecase.dart';

class SubMoodController extends GetxController {
  // di
  final SubMoodListUsecase subMoodListUsecase;

  SubMoodController({required this.subMoodListUsecase});

  // State variable
  var isLoading = false.obs;
  var subMoodList = SubMoodEntity().obs;
  var error = ''.obs;
  var selectedSubMood = <SubMoodList>[].obs;
  var commentText = ''.obs;
  var isCommentRequired = false.obs;

  Future<void> getSubMoodList(String id) async {
    try {
      isLoading.value = true;
      error.value = '';
      selectedSubMood.value = [];
      final DataState<SubMoodEntity> dataState = await subMoodListUsecase.call(
          RequestParams(url: "${APIConstants.api}/api/sub-mood-list/$id"));
      if (dataState.data != null) {
        subMoodList.value = dataState.data!;
      } else {
        error.value = dataState.exception.toString();
      }
    } on Exception catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }
}
