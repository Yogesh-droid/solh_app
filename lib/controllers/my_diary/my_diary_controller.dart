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
  var pageNo = 1;

  Future<void> getMyJournals(int pageNo) async {
    myJournalsList.clear();
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/v1/get-my-diary?pageNumber=$pageNo");

      myJournalResponseModel.value =
          JournalsResponseModel.fromJson(map['data']);
      myJournalsList.addAll(myJournalResponseModel.value.journals ?? []);
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
