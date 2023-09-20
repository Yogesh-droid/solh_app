import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/core/data_state/data_state.dart';
import 'package:solh/core/request_params/request_params.dart';

import '../../domain/usecases/add_mood_record_usecase.dart';

class AddMoodRecordController extends GetxController {
  final AddMoodRecordUsecase addMoodRecordUsecase;

  AddMoodRecordController({required this.addMoodRecordUsecase});

  var isLoading = false.obs;
  var message = ''.obs;
  var error = ''.obs;

  Future<void> addMoodRecord(
      {required String moodId, List? submoodList, String? comment}) async {
    print(submoodList.toString());
    try {
      isLoading.value = true;
      error.value = '';
      DataState<Map<String, dynamic>> dataState = await addMoodRecordUsecase
          .call(RequestParams(url: "${APIConstants.api}/api/mood-today", body: {
        "mood": moodId,
        "subMoodId": submoodList ?? [],
        "comment": comment ?? ''
      }));
      if (dataState.data != null) {
        message.value = dataState.data!['message'];
      } else {
        error.value = dataState.exception.toString();
      }
    } on Exception catch (e) {
      error.value = e.toString();
    }
    isLoading.value = false;
  }
}
