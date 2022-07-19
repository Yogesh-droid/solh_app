import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/allChat/all_chat_model.dart';
import 'package:solh/services/network/network.dart';

class ChatListController extends GetxController {
  Future getAllChat() async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/chatList')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    if (map.isNotEmpty) {
      return ChatListModel.fromJson(map);
    }
  }
}
