import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/allChat/all_chat_model.dart';
import 'package:solh/services/network/network.dart';

class ChatListController extends GetxController {
  var isLoading = false.obs;

  var chatList = <ChatList>[].obs;

  @override
  void onInit() {
    chatListController();

    super.onInit();
  }

  Future chatListController() async {
    isLoading(true);
    var response = await getAllChat();
    isLoading(false);

    if (response.chatList != null) {
      chatList.value = response.chatList!;
    } else {
      print(response);
    }
  }

  Future getAllChat() async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/chat/v1/chatList')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    if (map.isNotEmpty) {
      return ChatListModel.fromJson(map);
    }
  }
}
