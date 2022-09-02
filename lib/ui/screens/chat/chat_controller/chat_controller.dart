import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/controllers/chat-list/chat_controller.dart';
import 'package:solh/ui/screens/chat/chat_model/chat_model.dart';
import 'package:solh/ui/screens/chat/chat_services/chat_services.dart';
import 'package:solh/ui/screens/chat/chat_services/chat_socket_service.dart';

class ChatController extends GetxController {
  var isLoading = false.obs;

  var istyping = false.obs;

  var convo = <Conversation>[].obs;

  TextEditingController messageEditingController = TextEditingController();
  ChatListController chatListController = Get.find();

  ChatServices services = ChatServices();

  @override
  void onInit() {
    SocketService.socket.on('message:received', (data) {
      print('message:received $data');
      convo.add(Conversation(
          author: data['author'],
          authorId: data['authorId'],
          authorType: data['authorType'],
          body: data['body'],
          dateTime: DateTime.now().toString(),
          sId: data['']));

      chatListController.chatListController();
    });

    SocketService.socket.on("isTyping", (data) {
      istyping(false);
    });
    super.onInit();
  }

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

  Future initiateVideoController(body) async {
    isLoading(true);
    var response = await services.initiateVideo(body);
    isLoading(false);
    return response;
  }

  sendMessageController(message, sId, autherType, ct) {
    SocketService.sendMessage(message, sId, autherType, ct);

    messageEditingController.text = '';
    convo.add(Conversation(
        author: '',
        authorId: userBlocNetwork.id,
        authorType: autherType,
        body: message,
        dateTime: DateTime.now().toString(),
        sId: ''));
  }
}
