import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solh/ui/screens/chat/chat_model/chat_model.dart';
import 'package:solh/ui/screens/chat/chat_services/chat_services.dart';
import 'package:solh/ui/screens/chat/chat_services/chat_socket_service.dart';

class ChatController extends GetxController {
  var isLoading = false.obs;

  var convo = <Conversation>[].obs;

  TextEditingController messageEditingController = TextEditingController();

  ChatServices services = ChatServices();

  SocketService socketService = SocketService();
  Future getChatController(String sId) async {
    isLoading(true);

    MessageModel response = await services.getChat(sId);
    isLoading(false);

    print(response);

    if (response.chatLog != null) {
      convo.value = response.chatLog!.conversation!;
    } else {
      convo.value = [];
    }
  }

  sendMessageController(message, sId, autherType, ct) {
    SocketService.sendMessage(message, sId, autherType, ct);
    messageEditingController.text = '';
  }
}
