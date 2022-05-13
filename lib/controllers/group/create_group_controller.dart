import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../constants/api.dart';
import '../../services/network/network.dart';

class CreateGroupController extends GetxController {
  var path = ''.obs;
  var tagList = [].obs;
  var selectedMembersIndex = [].obs;

  Future<Map<String, dynamic>> createGroup(
      {required String groupName,
      required String desc,
      required String groupType,
      String? img,
      String? imgType}) async {
    Map<String, dynamic> map = await Network.makePostRequestWithToken(
            url: APIConstants.api + '/api/group',
            body: img != null
                ? {
                    'groupName': groupName,
                    'groupDescription': desc,
                    'groupType': groupType,
                    'groupMediaUrl': img,
                    'groupMediaType': imgType
                  }
                : {
                    'groupName': groupName,
                    'groupDescription': desc,
                    'groupType': groupType,
                  })
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    return map;
  }
}
