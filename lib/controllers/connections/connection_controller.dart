import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/model/get_all_connection_model.dart';
import 'package:solh/model/my_connection_model.dart';
import 'package:solh/model/people_you_may_know_model.dart';
import 'package:solh/model/user/user.dart';
import 'package:solh/model/user/user_analitics_model.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/utility.dart';

class ConnectionController extends GetxController {
  var myConnectionModel = MyConnectionModel().obs;
  var allConnectionModel = GetConnectionResponse().obs;
  var peopleYouMayKnow = PeopleYouMayKnowModel().obs;
  var receivedConnections = <Connections>[].obs;
  var sentConnections = <Connections>[].obs;
  var userAnalyticsModel = UserAnalyticModel().obs;
  var groupInvites = <Group>[].obs;
  var isAddingConnection = false.obs;
  var isDecliningConnection = false.obs;
  var declinedConnectionId = ''.obs;
  var isCancelingConnection = false.obs;
  var isLoading = false.obs;
  var isRecommnedationLoading = false.obs;

  /// for canceling connection
  var canceledConnectionId = ''.obs;

  /// for canceling connection
  var addingConnectionId = "".obs;

  /// for adding connection
  var userModel = UserModel().obs;
  DiscoverGroupController discoverGroupController = Get.find();

  Future<void> getMyConnection() async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/my-connection')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    if (map.isNotEmpty) {
      myConnectionModel.value = MyConnectionModel.fromJson(map);
    }
  }

  Future<void> getAllConnection() async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/connection')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    if (map.isNotEmpty) {
      sentConnections.clear();
      receivedConnections.clear();
      allConnectionModel.value = GetConnectionResponse.fromJson(map);
      allConnectionModel.value.connections!.forEach((element) {
        if (element.flag == 'sent') {
          sentConnections.value.add(element);
        } else {
          receivedConnections.value.add(element);
        }
      });
      groupInvites.value.clear();
      allConnectionModel.value.group!.forEach((element) {
        groupInvites.value.add(element);
      });
    }
  }

  Future<void> acceptConnection(String connection_id, String response) async {
    await Network.makePutRequestWithToken(
            url: APIConstants.api + '/api/connection',
            body: {'connection_id': connection_id, 'response': response})
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    await getMyConnection();
    await getAllConnection();
    discoverGroupController.getJoinedGroups();
  }

  Future<void> acceptConnectionFromGroup(String connection_id) async {
    await Network.makePostRequestWithToken(
        url: APIConstants.api + '/api/accept?id=${connection_id}',
        body: {}).onError((error, stackTrace) {
      print(error);
      return {};
    });
    await getMyConnection();
    await getAllConnection();
  }

  Future<void> deleteConnectionRequest(String connectionId) async {
    await Network.makePutRequestWithToken(
        url: APIConstants.api + '/api/sender-res-connection',
        body: {
          'connection_id': connectionId,
        }).onError((error, stackTrace) {
      print(error);
      return {};
    });
    await getMyConnection();
    await getAllConnection();
  }

  Future<void> addConnection(String uid) async {
    await Network.makePostRequestWithToken(
        url: APIConstants.api + '/api/connection',
        body: {'receiver_id': uid}).onError((error, stackTrace) {
      print(error);

      return {};
    }).then((value) => Utility.showToast(value['message']));
    getMyConnection();
    getAllConnection();
  }

  Future<void> deleteConnection(String uid) async {
    await Network.makeHttpDeleteRequestWithToken(
        url: APIConstants.api + '/api/connection?userId=${uid}',
        body: {}).onError((error, stackTrace) {
      print(error);
      return {};
    });
    getMyConnection();
    getAllConnection();
  }

  Future<void> getUserAnalytics(String uid) async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/analytics/$uid')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    if (map.isNotEmpty) {
      userAnalyticsModel.value = UserAnalyticModel.fromJson(map);
    }
  }

  Future getUserprofileData(String user) async {
    isLoading(true);
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/user-profile' + '?user=' + user)
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    isLoading(false);

    if (map.containsKey('connections')) {
      if (map['connections'] == null) {
        print("map1" + map.toString());
        print("null type");

        userModel.value.lastName = null;
        update();
        return;
      }
    }

    if (map.isNotEmpty) {
      print("map" + map.toString());

      userModel.value = UserModel.fromJson(map['connections']);
      update();
    }
  }

  Future<void> getPeopleYouMayKnow() async {
    isRecommnedationLoading.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/connection-recommendation')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    if (map.isNotEmpty) {
      peopleYouMayKnow.value = PeopleYouMayKnowModel.fromJson(map);
      print("peopleYouMayKnow" +
          peopleYouMayKnow.value.reccomendation!.length.toString());
    }
    isRecommnedationLoading.value = false;
  }

  @override
  void onInit() {
    getMyConnection();
    getAllConnection();
    getPeopleYouMayKnow();
    super.onInit();
  }
}
