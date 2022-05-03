import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class MyJournals {
  Future getMyJournals() async {
    var _response = await Network.makeHttpGetRequestWithToken(
        "${APIConstants.api}/api/get-my-journal");
    print("my-journals: " + _response.toString());
  }
}
