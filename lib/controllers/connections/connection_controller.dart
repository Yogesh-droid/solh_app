import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/get_all_connection_model.dart';
import 'package:solh/model/my_connection_model.dart';
import 'package:solh/model/user/user_analitics_model.dart';
import 'package:solh/services/network/network.dart';

class ConnectionController extends GetxController {
  var myConnectionModel = MyConnectionModel().obs;
  var allConnectionModel = GetConnectionResponse().obs;
  var receivedConnections = <Connections>[].obs;
  var sentConnections = <Connections>[].obs;
  var userAnalyticsModel = UserAnalyticModel().obs;
  var isAddingConnection = false.obs;

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
    }
  }

  Future<void> acceptConnection(String connection_id) async {
    await Network.makePutRequestWithToken(
            url: APIConstants.api + '/api/connection',
            body: {'connection_id': connection_id, 'response': '1'})
        .onError((error, stackTrace) {
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

  @override
  void onInit() {
    getMyConnection();
    getAllConnection();
    super.onInit();
  }
}
