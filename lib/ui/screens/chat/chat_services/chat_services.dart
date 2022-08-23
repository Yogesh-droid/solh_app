import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/chat/chat_model/chat_model.dart';

class ChatServices {
  Future getChat(userId) async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/chat?connection=' + userId)
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    print(map);
    if (map.isNotEmpty) {
      return MessageModel.fromJson(map);
    }
  }

  Future postChat(userId) async {
    Map<String, dynamic> map = await Network.makePostRequestWithToken(
        url: APIConstants.api + 'chat?connection=' + userId,
        body: {}).onError((error, stackTrace) {
      print(error);
      return {};
    });

    if (map['success'] == true) {
      return true;
    }
  }

  Future initiateVideo(Map<String, dynamic> body) async {
    Map<String, dynamic> response = await Network.makePostRequestWithToken(
            url: APIConstants.api + '/api/agora/rtc/', body: body)
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    return response;
  }
}
