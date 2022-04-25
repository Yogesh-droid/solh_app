import 'package:get/get.dart';

import '../../constants/api.dart';
import '../../model/journals/journals_response_model.dart';
import '../../services/network/error_handling.dart';
import '../../services/network/network.dart';

class MyDiaryController extends GetxController {
  var movingUp = false.obs;
  var myJournalResponseModel = JournalsResponseModel().obs;
  var myJournalsList = <Journals>[].obs;
  var selectedElement = 'My Diary'.obs;
  var isPosting = false.obs;

  Future<void> getMyJournals(int pageNo) async {
    myJournalsList.clear();
    //pageNo == 1 ? isLoading.value = true : false;
    try {
      //if (pageNo <= _endPageLimit) {
      Map<String, dynamic> map = await Network.makeHttpGetRequestWithToken(
          "${APIConstants.api}/api/get-my-diary");

      myJournalResponseModel.value = JournalsResponseModel.fromJson(map);
      myJournalsList.value.addAll(myJournalResponseModel.value.journals ?? []);
      // _endPageLimit = myJournalResponseModel.value.totalPages!;
      //this.pageNo = pageNo;
      //}
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
  }

  @override
  void onInit() {
    getMyJournals(1);
    super.onInit();
  }
}
