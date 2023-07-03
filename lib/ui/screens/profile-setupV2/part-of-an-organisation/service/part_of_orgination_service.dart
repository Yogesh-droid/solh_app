import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class PartOfAnOrganisationService {
  Future<Map<String, dynamic>> getOrganisationList() async {
    try {
      final response = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/app/organisation/v1/get-organisation-list");
      if (response['success']) {
        return response;
      } else {
        throw (response);
      }
    } catch (e) {
      throw (e);
    }
  }
}
