import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class AppointmentServices {
  static Future<Map<String, dynamic>> getTransferProfileList() async {
    try {
      var response = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/transfer-list-user");

      return response;
    } catch (e) {
      throw (e);
    }
  }

  static Future<Map<String, dynamic>> getTransferProfileDetail(
      String transferId) async {
    try {
      var response = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/transfer-list-user/$transferId");
      return response;
    } catch (e) {
      throw (e);
    }
  }

  static Future<Map<String, dynamic>> updateTransferStatus(
      {required String transferId, required String status}) async {
    try {
      var response = await Network.makePutRequestWithToken(
          url: "${APIConstants.api}/api/transfer-profile-user-status",
          body: {
            "transferId": transferId,
            "status": status,
          });

      return response;
    } catch (e) {
      throw (e);
    }
  }
}
