import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/chat-list/chat_list_controller.dart';
import 'package:solh/ui/screens/chat/chat_model/chat_model.dart';
import 'package:solh/ui/screens/chat/chat_services/chat_services.dart';
import 'package:solh/ui/screens/chat/chat_services/chat_socket_service.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../services/network/network.dart';

class ChatController extends GetxController {
  var isLoading = false.obs;

  var istyping = false.obs;

  var isFileDownloading = false.obs;

  var isFileUploading = false.obs;

  String currentLoadingurl = '';
  var scrollOffset = 0.0.obs;

  Map downloadedAndLocalfile = {}.obs;

  var convo = <Conversation>[].obs;

  var isVideoConnecting = false.obs;

  var seenStatus = ''.obs;

  var isTypingEpochTime = 0.obs;

  //anon chat

  var selectedStar = 0.obs;
  final PageController pageController = PageController();
  //anon chat

  var currentSid;
  TextEditingController messageEditingController = TextEditingController();
  ChatListController chatListController = Get.find();

  ChatServices services = ChatServices();

  String? filePath;

  @override
  void onInit() {
    getLocalPath();

    SocketService.socket.on('message:received', (data) {
      debugPrint('message:received $data');

      if (currentSid == data['authorId']) {
        convo.add(Conversation.fromJson(data));
      }

      chatListController.chatListController();
    });
    SocketService.socket.on("seenStatus", (data) {
      if (data == null) {
        seenStatus.value = '';
        return;
      }
      // debugPrint('seenStatus ${timeago.format(DateTime.parse(data))}');
      if (data == 'Online') {
        seenStatus.value = data;
      } else {
        seenStatus.value = 'last seen ' + timeago.format(DateTime.parse(data));
      }
    });

    SocketService.socket.on("isTyping", (data) {
      debugPrint('Typing $data');
      if (currentSid == data['authorId']) {
        istyping(data['isTyping']);
      }
    });

    super.onInit();
  }

  Future getChatController(String sId) async {
    isLoading(true);

    MessageModel response = await services.getChat(sId);
    isLoading(false);

    debugPrint(response.toString());

    if (response.chatLog != null) {
      convo.value = response.chatLog!.conversation!;
      debugPrint(convo.value.toString());
    } else {
      convo.value = [];
    }
  }

  Future initiateVideoController(body) async {
    isLoading(true);
    isVideoConnecting(true);

    var response = await services.initiateVideo(body);
    isVideoConnecting(false);
    isLoading(false);
    return response;
  }

  Future<String> uploadChatFile(File file) async {
    isFileUploading(true);
    Map<String, dynamic> response = await Network.uploadFileToServer(
        "${APIConstants.api}/api/fileupload/chat", "chat", file);
    isFileUploading(false);

    if (response["success"]) {
      downloadedAndLocalfile[response['imageUrl']] = file.path;
      File(file.path).exists().then((value) {
        debugPrint(file.path);
        if (value) {
          debugPrint('it exists');
        } else {
          debugPrint('not exits');
        }
      });
      return response['imageUrl'];
    } else {
      return 'File upload failed';
    }
  }

  Future getLocalPathFromDownloadedFile(
      {required String url,
      required String fileName,
      required String extension}) async {
    try {
      isFileDownloading(true);
      Uri _uri = Uri.parse(url);

      currentLoadingurl = url;

      var response = await http.get(_uri);
      isFileDownloading(false);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodedResponse = response.bodyBytes;

        File file = new File('$filePath/$fileName');
        await file.writeAsBytes(decodedResponse);
        downloadedAndLocalfile[url] = '$filePath/$fileName';
        File(file.path).exists().then((value) {
          debugPrint(file.path);
          if (value) {
            debugPrint('it exists');
          } else {
            debugPrint('not exits');
          }
        });
      } else {
        throw "server-error";
      }
    } on SocketException {
      throw "no-internet";
    } catch (e) {
      throw e;
    }
  }

  sendMessageController(
      {required message,
      required conversationType,
      required sId,
      required autherType,
      required ct,
      required mediaUrl,
      required appointmentId,
      required mediaType,
      required authorId,
      required fileName}) {
    SocketService.sendMessage(
        message: message,
        sId: sId,
        autherType: autherType,
        ct: ct,
        mediaUrl: mediaUrl,
        appointmentId: appointmentId,
        mediaType: mediaType,
        fileName: fileName,
        conversationType: conversationType,
        authorId: authorId);

    messageEditingController.text = '';
    convo.add(Conversation(
        author: '',
        authorId: userBlocNetwork.id,
        authorType: autherType,
        body: message,
        conversationType: conversationType,
        dateTime: DateTime.now().toString(),
        sId: '',
        fileName: fileName,
        media: Media(
          mediaType: mediaType,
          mediaUrl: mediaUrl,
        )));
    chatListController.chatListController();
  }

  Future<void> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    debugPrint('directory $directory');
    filePath = directory.path;
  }
}
