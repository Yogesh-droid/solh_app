import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solh/bloc/user-bloc.dart';

import 'package:solh/ui/screens/chat/chat_model/chat_model.dart';
import 'package:solh/ui/screens/chat/chat_services/chat_services.dart';
import 'package:solh/ui/screens/chat/chat_services/chat_socket_service.dart';
import 'package:solh/ui/screens/journaling/widgets/solh_expert_badge.dart';

class ChatController extends GetxController {
  var isLoading = false.obs;

  var convo = <Conversation>[].obs;

  TextEditingController messageEditingController = TextEditingController();

  ChatServices services = ChatServices();

  @override
  void onInit() {
    // TODO: implement onInit
    SocketService.socket.on('message:received', (data) {
      print('message:received $data');
      convo.add(Conversation(
          author: data['author'],
          authorId: data['authorId'],
          authorType: data['authorType'],
          body: data['body'],
          dateTime: '',
          sId: data['']));

      print('_chatcontroller ' + convo[3].body!);
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

  sendMessageController(message, sId, autherType, ct) {
    SocketService.sendMessage(message, sId, autherType, ct);

    messageEditingController.text = '';
    convo.add(Conversation(
        author: '',
        authorId: userBlocNetwork.id,
        authorType: autherType,
        body: message,
        dateTime: '',
        sId: ''));
  }
}
