import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/allChat/all_chat_model.dart';
import 'package:solh/services/network/network.dart';

class ChatListController extends GetxController {
  var isLoading = false.obs;

  var chatList = <ChatList>[].obs;
  var sosChatList = <ChatList>[].obs;

  @override
  void onInit() {
    chatListController();
    sosChatListController();
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

  Future sosChatListController() async {
    isLoading(true);
    var response = await getSosChat();
    isLoading(false);

    if (response.chatList != null) {
      sosChatList.value = response.chatList!;
    } else {
      print(response);
    }
  }

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

  Future getSosChat() async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/sosChatList')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    if (map.isNotEmpty) {
      return ChatListModel.fromJson(map);
    }
  }
}
