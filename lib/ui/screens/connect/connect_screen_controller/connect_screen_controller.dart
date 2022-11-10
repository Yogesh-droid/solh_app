import 'package:get/get.dart';
import 'package:solh/ui/screens/connect/connect_sceen_model/connect_screen_model.dart';
import 'package:solh/ui/screens/connect/connect_screen_services/connect_screen_services.dart';

class ConnectScreenController extends GetxController {
  ConnectScreenServices connectScreenServices = ConnectScreenServices();
  var isConnectScreenDataLoading = false.obs;
  var connectScreenModel = ConnectScreenModel().obs;

  void getProfileDetailsController() {
    isConnectScreenDataLoading(true);
  }
}
