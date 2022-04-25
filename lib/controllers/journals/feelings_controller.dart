import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/services/network/network.dart';

class FeelingsController extends GetxController {
  var feelingsList = <Feelings>[].obs;
  var selectedFeelingsId = ''.obs;

  Future<void> fetchFeeligs() async {
    try {
      Map<String, dynamic> response =
          await Network.makeGetRequest(APIConstants.api + '/api/default')
              .onError((error, stackTrace) {
        print(error);
        return {};
      });

      response['feelings'].forEach((element) {
        feelingsList.add(Feelings.fromJson(element));
      });
      if (feelingsList.isNotEmpty) {
        selectedFeelingsId.value = feelingsList.first.sId!;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchFeeligs();
  }
}
