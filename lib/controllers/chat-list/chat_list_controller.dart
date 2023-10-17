import 'dart:developer';

import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/allChat/all_chat_model.dart';
import 'package:solh/services/network/network.dart';

class ChatListController extends GetxController {
  var isLoading = false.obs;
  var isMorePageLoading = false.obs;
  var isLoadingMoreChat = false.obs;
  var chatList = <ChatList>[].obs;
  var sosChatList = <ChatList>[].obs;
  bool fromIDontKnow = false;
  String? filter;
  bool unrespondedFilter = false;
  bool orgOnlyFilter = false;

  int? nextPage;

  @override
  void onInit() {
    chatListController(1);
    sosChatListController(1);
    super.onInit();
  }

  Future chatListController(int pageNo) async {
    try {
      print("it called");
      pageNo > 1 ? isLoadingMoreChat(true) : isLoading(true);
      var response = await getAllChat(pageNo);
      pageNo > 1 ? isLoadingMoreChat(false) : isLoading(false);

      if (response.chatList != null) {
        if (pageNo > 1) {
          chatList.addAll(response.chatList!);
          chatList.refresh();
        } else {
          chatList.value = response.chatList!;
        }
        nextPage = response.next;
      } else {
        print(response);
      }
    } on Exception catch (e) {
      throw (e);
    }
  }

  Future sosChatListController(int pageNo, {String? filter}) async {
    pageNo > 1 ? isMorePageLoading(true) : isLoading(true);
    if (pageNo == 1 && filter != null) {
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

  Future<ChatListModel> getAllChat(int pageNo) async {
    try {
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
              APIConstants.api + '/api/v2/chatList?page=$pageNo')
          .onError((error, stackTrace) {
        print(error);
        return {};
      });

      if (map.isNotEmpty) {
        return ChatListModel.fromJson(map);
      } else {
        throw ("Thrown in getAllChat" + map.toString());
      }
    } on Exception catch (e) {
      throw (e);
    }
  }

  Future getSosChat(int pageNo,
      {String? filter, bool? unrespondedFilter, bool? orgOnlyFilter}) async {
    unrespondedFilter = this.unrespondedFilter;

    orgOnlyFilter = this.orgOnlyFilter;
    Map<String,
        dynamic> map = await Network.makeGetRequestWithToken(APIConstants.api +
            '/api/v3/sosChatList?page=$pageNo${filter ?? ''}&unresponded=$unrespondedFilter&orgOnly=$orgOnlyFilter')
        .onError((error, stackTrace) {
      print(error);
      return {};
    });

    if (map.isNotEmpty) {
      return ChatListModel.fromJson(map);
    }
  }
}
