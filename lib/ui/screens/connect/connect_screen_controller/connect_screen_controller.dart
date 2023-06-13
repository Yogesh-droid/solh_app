import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/model/get_all_connection_model.dart';
import 'package:solh/model/my_connection_model.dart';
import 'package:solh/services/connection/connection_services.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/connect/connect_sceen_model/connect_screen_model.dart';
import 'package:solh/ui/screens/connect/connect_screen_services/connect_screen_services.dart';

class ConnectScreenController extends GetxController {
  ConnectionController connectionController = Get.put(ConnectionController());
  ConnectScreenServices connectScreenServices = ConnectScreenServices();
  ConnectionServices connectionServices = ConnectionServices();
  var isConnectScreenDataLoading = false.obs;
  var connectScreenModel = ConnectScreenModel().obs;
  var isMyConnection = false.obs;
  var isInSentRequest = false.obs;
  var isInRecivedRequest = false.obs;
  var connectionErrorStatus = 0.obs;
  var sendingRequest = false.obs;
  var sendingConnectionRequest = false.obs;

  Future<void> getProfileDetailsController(String sId) async {
    try {
      isConnectScreenDataLoading(true);
      var response = await connectScreenServices.getProfileDetails(sId);
      connectScreenModel.value = response;
      isConnectScreenDataLoading(false);
    } catch (e) {
      debugPrint('error ' + e.toString());
      // connectionErrorStatus.value = e as int;
    }
  }

  Future<void> getProfileDetailsFromUserNameController(String userName) async {
    try {
      isConnectScreenDataLoading(true);
      var response =
          await connectScreenServices.getProfileDetailsFromUserName(userName);
      print('it ran');
      connectScreenModel.value = response;
      isConnectScreenDataLoading(false);
    } catch (e) {
      debugPrint('error ' + e.toString());
      // connectionErrorStatus.value = e as int;

    }
  }

  bool isMyConnectionController(String sid) {
    isMyConnection.value =
        connectScreenModel.value.user!.connectionsList!.contains(sid);
    return isMyConnection.value;
  }

  bool checkIfAlreadyInSendConnection(String sId) {
    isInSentRequest.value = false;

    connectionController.sentConnections.value.forEach((element) {
      if (sId == element.sId) {
        isInSentRequest.value = true;
      }
    });

    return isInSentRequest.value;
  }

  bool checkIfAlreadyInRecivedConnection(String sId) {
    connectionController.receivedConnections.value.forEach((element) {
      if (sId == element.sId) {
        isInRecivedRequest.value = true;
      }
    });
    return isInRecivedRequest.value;
  }

  void sendConnectionRequest(String sId) async {
    try {
      sendingConnectionRequest(true);
      var response = await connectionServices.addConnectionService(sId);
      Utility.showToast(response['message']);
      isInSentRequest.value = true;
      print(response["connectionDetails"]);
      connectionController.allConnectionModel.value.connections!
          .add(Connections.fromJson(response["connectionDetails"]));
      sendingConnectionRequest(false);
    } catch (e) {
      debugPrint('error ' + e.toString());
      connectionErrorStatus.value = e as int;
    }
  }

  void removeConnection(String sId) async {
    try {
      sendingRequest(true);
      var response = await connectionServices.removeConnectionService(sId);

      if (response["success"] == true) {
        isMyConnection(false);
        connectionController.allConnectionModel.value.connections!
            .forEach((element) {
          if (element.sId == sId) {
            connectionController.allConnectionModel.value.connections!
                .remove(element);
          }
        });
        Utility.showToast('Successfully removed from connection');
      }

      sendingRequest(false);
    } catch (e) {}
  }

  void removeConnectionRequest(String sId) async {
    try {
      sendingRequest(true);
      var response = await connectionServices
          .removeConnectionRequestService(getConnectionIdBySId(sId));

      if (response["success"] == true) {
        isInSentRequest(false);

        Utility.showToast('Successfully removed from connection');
      } else {
        Utility.showToast(response["message"]);
      }
      sendingRequest(false);
    } catch (e) {}
  }

  void acceptConnectionRequest(String sId) async {
    try {
      sendingRequest(true);
      print(sId);
      var response = await connectionServices
          .acceptConnectionRequest(getRecivedConnectionIdBySId(sId));

      if (response["success"] == true) {
        isInSentRequest(false);
        isMyConnection(true);
        connectionController.myConnectionModel.value.myConnections!
            .add(MyConnections(sId: sId));
        Utility.showToast('Successfully added to connection');
      } else {
        Utility.showToast(response["message"]);
      }
      sendingRequest(false);
    } catch (e) {}
  }

  String getConnectionIdBySId(String sId) {
    String connectionId = '';
    connectionController.allConnectionModel.value.connections!
        .forEach((element) {
      print('${element.sId} $sId');
      if (element.sId == sId && element.flag == 'sent') {
        connectionId = element.connectionId!;
      }
    });

    return connectionId;
  }

  String getRecivedConnectionIdBySId(String sId) {
    String connectionId = '';
    connectionController.allConnectionModel.value.connections!
        .forEach((element) {
      if (element.sId == sId && element.flag == 'received') {
        connectionId = element.connectionId!;
      }
    });

    return connectionId;
  }
}
