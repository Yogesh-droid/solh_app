import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/home/chat-anonymously/chat-anon-model/chat_anon_model.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';

class ChatAnonService {
  Future<ChatAnonModel> getVolunteer() async {
    try {
      var response = await Network.makeGetRequestWithToken(
          '${APIConstants.api}/api/anonymousChat/v1/sos/chatSupport');
      return ChatAnonModel.fromJson(response);
    } catch (e) {
      SolhSnackbar.error('Error', 'Something went wrong');
      throw e;
    }
  }

  Future<Map<String, dynamic>> postFeedback(Map<String, dynamic> body) async {
    try {
      Map<String, dynamic> response = await Network.makePostRequestWithToken(
          url: '${APIConstants.api}/api/anonymousChat/v1/feedback', body: body);
      return response;
    } catch (e) {
      SolhSnackbar.error('Error', 'Something went wrong');
      throw e;
    }
  }
}
