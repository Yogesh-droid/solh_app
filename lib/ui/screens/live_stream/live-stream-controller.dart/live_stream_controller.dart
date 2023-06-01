import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/live_stream/live-stream-model/live_stream_for_user_model.dart';

class LiveStreamController extends GetxController {
  var isMuted = false.obs;
  var isCameraOff = false.obs;

  var liveStreamForUserModel = LiveStreamForUserModel().obs;

  var isgettingStreamData = false.obs;

  getLiveStreamForUserData() async {
    isgettingStreamData(true);
    try {
      var response = await Network.makeGetRequestWithToken(
          '${APIConstants.api}/api/agora/webinar-details-for-user');

      if (response['success'] && response["webinar"] != null) {
        liveStreamForUserModel.value =
            LiveStreamForUserModel.fromJson(response);
      }
      isgettingStreamData(false);
    } catch (e) {
      isgettingStreamData(false);
      throw (e);
    }
  }
}
