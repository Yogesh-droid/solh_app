import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/group/get_group_response_model.dart';
import 'package:solh/services/network/network.dart';

class DiscoverGroupController extends GetxController {
  var createdGroupModel = GetGroupResponseModel().obs;
  var joinedGroupModel = GetGroupResponseModel().obs;
  var discoveredGroupModel = GetGroupResponseModel().obs;

  @override
  void onInit() {
    getCreatedGroups();
    getJoinedGroups();
    getDiscoverGroups();
    super.onInit();
  }

  Future<void> getCreatedGroups() async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/created-groups');
    if (map['success']) {
      createdGroupModel.value = GetGroupResponseModel.fromJson(map);
    }
  }

  Future<void> getJoinedGroups() async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/joined-groups');
    if (map['success']) {
      joinedGroupModel.value = GetGroupResponseModel.fromJson(map);
    }
  }

  Future<void> getDiscoverGroups() async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        '${APIConstants.api}/api/discover-groups');
    if (map['success']) {
      discoveredGroupModel.value = GetGroupResponseModel.fromJson(map);
    }
  }
}
