import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/network/networkV2.dart';
import 'package:solh/ui/screens/chat/chat_model/chat_model.dart';

class ChatServices {
  Future getChat(userId) async {
    Map<String, dynamic> map = await NetworkV2.makeHttpGetRequestWithTokenV2(
            APIConstants.api + '/api/chat?connection=' + userId)
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    print('message' + map.toString());
    if (map.isNotEmpty) {
      print('it ran');
      return MessageModel.fromJson(map);
    }
  }

  Future getSosChat(userId) async {
    Map<String, dynamic> map = await NetworkV2.makeHttpGetRequestWithTokenV2(
            APIConstants.api + '/api/sosChat?connection=' + userId)
        .onError((error, stackTrace) {
      print(error);
      return {};
    });
    print('message' + map.toString());
    if (map.isNotEmpty) {
      print('it ran');
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
            url: APIConstants.api + '/api/agora/sendNotification', body: body)
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    return response;
  }
}
