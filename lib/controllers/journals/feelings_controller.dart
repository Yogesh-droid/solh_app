import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/services/network/network.dart';

class FeelingsController extends GetxController {
  var feelingsList = <Feelings>[].obs;
  var selectedFeelingsId = [].obs;
  var isCreatingCustomFeeling = false.obs;
  var isSearching = false.obs;

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
        selectedFeelingsId.value[0] = feelingsList.first.sId!;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> createCustomFeeling(String feelingName) async {
    try {
      Map<String, dynamic> response = await Network.makePostRequestWithToken(
          url: APIConstants.api + '/api/feelings',
          body: {'feelingName': feelingName}).onError((error, stackTrace) {
        print(error);
        return {};
      });

      if (response['status'] == 'success') {
        feelingsList.add(Feelings.fromJson(response['data']));
        selectedFeelingsId.value[0] = feelingsList.first.sId!;
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
