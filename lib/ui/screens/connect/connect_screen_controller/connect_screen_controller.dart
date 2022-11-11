import 'package:get/get.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/ui/screens/connect/connect_sceen_model/connect_screen_model.dart';
import 'package:solh/ui/screens/connect/connect_screen_services/connect_screen_services.dart';

class ConnectScreenController extends GetxController {
  ConnectionController connectionController = Get.find();
  ConnectScreenServices connectScreenServices = ConnectScreenServices();
  var isConnectScreenDataLoading = false.obs;
  var connectScreenModel = ConnectScreenModel().obs;
  var isMyConnection = false.obs;
  var isInSentRequest = false.obs;
  var isInRecivedRequest = false.obs;
  var connectionErrorStatus = 0.obs;

  Future<void> getProfileDetailsController(String sId) async {
    try {
      isConnectScreenDataLoading(true);
      var response = await connectScreenServices.getProfileDetails(sId);
      connectScreenModel.value = response;
      isConnectScreenDataLoading(false);
    } catch (e) {
      print('error ' + e.toString());
      connectionErrorStatus.value = e as int;
    }
  }

  bool isMyConnectionController(String sid) {
    isMyConnection.value =
        connectScreenModel.value.user!.connectionsList!.contains(sid);
    return isMyConnection.value;
  }

  bool checkIfAlreadyInSendConnection(String sId) {
    isInSentRequest.value =
        connectionController.sentConnections.value.contains(sId);
    return isInSentRequest.value;
  }

  bool checkIfAlreadyInRecivedConnection(String sId) {
    isInRecivedRequest.value =
        connectionController.receivedConnections.value.contains(sId);
    return isInRecivedRequest.value;
  }
}
