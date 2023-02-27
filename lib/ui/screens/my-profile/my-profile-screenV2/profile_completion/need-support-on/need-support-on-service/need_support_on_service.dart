import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/profile_completion/need-support-on/need-support-on-model/need_support_on_model.dart';

class NeedSupportOnService {
  Future<NeedSupportOnModel> getSupportIssues() async {
    try {
      var response = await Network.makeGetRequestWithToken(
          '${APIConstants.api}/api/issue');
      return NeedSupportOnModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
