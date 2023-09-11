import 'dart:developer';

import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/allChat/all_chat_model.dart';
import 'package:solh/services/network/network.dart';

class ChatListController extends GetxController {
  var isLoading = false.obs;
  var isMorePageLoading = false.obs;
  var chatList = <ChatList>[].obs;
  var sosChatList = <ChatList>[].obs;

  @override
  void onInit() {
    chatListController();
    sosChatListController(1);
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

  Future sosChatListController(int pageNo, {String? filter}) async {
    pageNo > 1 ? isMorePageLoading(true) : isLoading(true);
    if (filter != null) {
      sosChatList.clear();
    }
    ChatListModel? response = await getSosChat(pageNo, filter: filter);

    if (response != null) {
      if (response.chatList != null && pageNo == 1) {
        sosChatList.value = response.chatList!;
      } else if (response.chatList != null &&
          pageNo > 1 &&
          response.chatList!.isNotEmpty) {
        log(response.chatList.toString());
        response.chatList!.forEach((element) {
          sosChatList.add(element);
        });
        sosChatList.refresh();
      } else {
        print(response);
      }
    }
    pageNo > 1 ? isMorePageLoading(false) : isLoading(false);
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

  Future getSosChat(int pageNo, {String? filter = ''}) async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
            APIConstants.api + '/api/v2/sosChatList?page=$pageNo$filter')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    if (map.isNotEmpty) {
      return ChatListModel.fromJson(map);
    }
  }
}
