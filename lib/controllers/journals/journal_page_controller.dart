import 'package:get/get.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/services/network/error_handling.dart';
import 'package:solh/services/network/network.dart';
import '../../constants/api.dart';

class JournalPageController extends GetxController {
  var journalsResponseModel = JournalsResponseModel().obs;

  var journalsList = <Journals>[].obs;

  var isLoading = false.obs;
  int endPageLimit = 1;
  int pageNo = 1;

  Future<void> getAllJournals(int pageNo) async {
    print('started gettting all journals');
    try {
      if (pageNo == 1) {
        isLoading.value = true;
      }
      if (pageNo <= endPageLimit) {
        print('trying to get all journals');
        Map<String, dynamic> map = await Network.makeHttpGetRequestWithToken(
            "${APIConstants.api}/api/get-journals?page=$pageNo");

        print('map: ' + map.toString());

        journalsResponseModel.value = JournalsResponseModel.fromJson(map);
        journalsList.value.addAll(journalsResponseModel.value.journals ?? []);
        endPageLimit = journalsResponseModel.value.totalPages!;
        this.pageNo = pageNo;
        print("journals response: " +
            map.toString() +
            " page no: " +
            pageNo.toString());
      }
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    getAllJournals(1);

    super.onInit();
  }
}
