import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/search/global_search_model.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/utility.dart';

class GlobalSearchController extends GetxController {
  var isSearching = false.obs;
  var globalSearchModel = GlobalSearchModel().obs;

  Future<void> getTexSearch(String text) async {
    isSearching.value = true;
    Map<String, dynamic>? map;
    try {
      map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/global-search?text=$text");
    } on Exception catch (e) {
      print(e.toString());
      Utility.showToast('Something went wrong');
    }
    if (map != null) {
      globalSearchModel.value = GlobalSearchModel.fromJson(map);
    } else {
      Utility.showToast('No result found');
    }
    isSearching.value = false;
  }
}
