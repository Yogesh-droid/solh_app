import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/activity-log-and-badge/activity-log/activity-log-model/activity_log_model.dart';

class ActivityLogService {
  Future<ActivityLogModel> getActivityLog(int pageNumber) async {
    try {
      var response = await Network.makeGetRequestWithToken(
          '${APIConstants.api}/api/custom/activity-log?pageNumber=$pageNumber');
      return ActivityLogModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
