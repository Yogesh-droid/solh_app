import 'package:get/get.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/ui/screens/chat/chat_model/chat_model.dart';

import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../../../../constants/api.dart';

class SocketService {
  static late StreamController<Conversation> _socketResponse;

  static late StreamController<List<String>> _userResponse;
  // final ChatController _chatController = Get.find();

  ProfileController profileController = Get.find();

  // ChatController _chatController = ChatController();
  static late io.Socket socket = io.io(
      APIConstants.api,
      io.OptionBuilder()
          .setTransports(['websocket', 'polling'])
          .setQuery({'userName': _userName})
          .enableAutoConnect()
          .build());
  static String _userName = '';

  static String currentSId = '';

  static String? get userId => socket.id;

  static Stream<Conversation> get getResponse =>
      _socketResponse.stream.asBroadcastStream();
  static Stream<List<String>> get userResponse =>
      _userResponse.stream.asBroadcastStream();

  static void setUserName(String name) {
    _userName = name;
  }

  static void setCurrentSId(String sId) {
    currentSId = sId;
  }

  static void sendMessage(
      {required String message,
      required String sId,
      required String autherType,
      required String ct,
      required String mediaUrl,
      required String appointmentId,
      required String mediaType,
      required String fileName,
      required String conversationType,
      required String authorId}) {
    print('message emmited' +
        {
          'socketId': socket.id,
          'author': _userName,
          'authorId': authorId,
          'authorType': autherType,
          'body': message,
          'connection': sId,
          'chatType': ct,
          'media': {
            'mediaUrl': mediaUrl,
            'mediaType': mediaType,
          },
          'appointmentId': null,
          'fileName': fileName,
          'conversationType': conversationType,
        }.toString());
    socket.emit('message', {
      'socketId': socket.id,
      'author': _userName,
      'authorId': authorId,
      'authorType': autherType,
      'body': message,
      'connection': sId,
      'chatType': ct,
      'media': {
        'mediaUrl': mediaUrl,
        'mediaType': mediaType,
      },
      'appointmentId': null,
      'fileName': fileName,
      'conversationType': conversationType,
    });
  }

  void userLeft() {
    socket.emit('userLeft', {
      'socketId': socket.id,
      'authorId': profileController.myProfileModel.value.body!.user!.sId!,
      'connection': currentSId,
    });
  }

  void typing(sId, chatType, userType) {
    socket.emit('typing', {
      'socketId': socket.id,
      'authorId': profileController.myProfileModel.value.body!.user!.sId!,
      'connection': currentSId,
      'chatType': chatType,
      'authorType': userType
    });
  }

  void notTyping(sId, chatType, userType) {
    socket.emit('notTyping', {
      'socketId': socket.id,
      'authorId': profileController.myProfileModel.value.body!.user!.sId!,
      'connection': currentSId,
      'chatType': chatType,
      'authorType': userType
    });
  }

  void connectAndListen() {
    _socketResponse = StreamController<Conversation>();
    _userResponse = StreamController<List<String>>();

    socket.connect();

    socket.onConnect((data) {
      print('Connected to server');
      print('connected');
      print(socket.id);

      socket.emit('uconnect', {
        'socketId': socket.id,
        'userId': profileController.myProfileModel.value.body!.user!.sId!,
        'connection': currentSId,
      });
      socket.emit('sendOnlineStatus', {
        'socketId': socket.id,
        'userId': profileController.myProfileModel.value.body!.user!.sId!,
        'connection': currentSId,
      });
    });

    socket.onConnectError(
      (data) {
        print('err to server');
        print(data);
      },
    );
    print(profileController.myProfileModel.value.body.toString());
    print(socket.connected);
    socket.emit('uconnect', {
      'socketId': socket.id,
      'userId': profileController.myProfileModel.value.body!.user!.sId!,
      'connection': currentSId,
    });
    print(socket.id);

    // socket.on('message:received', (data) {
    //   print('message:received $data');
    //   _chatController.convo.add(Conversation(
    //       author: data['author'],
    //       authorId: data['authorId'],
    //       authorType: data['authorType'],
    //       body: data['body'],
    //       dateTime: '',
    //       sId: data['authorType']));

    //   print('_chatcontroller ' + _chatController.convo.last.body!);
    // });

    //When an event recieved from server, data is added to the stream
    socket.on('message', (data) {
      print('message $data');
      _socketResponse.sink.add(Conversation.fromJson(data));
    });

    //when users are connected or disconnected
    socket.on('users', (data) {
      print('users $data');
      var users = (data as List<dynamic>).map((e) => e.toString()).toList();
      _userResponse.sink.add(users);
    });

    // _socket.onDisconnect((_) => print('disconnect'));
  }

  static void dispose() {
    // socket.dispose();
    // socket.destroy();
    // socket.close();
    socket.disconnect();
    // _socketResponse.close();
    // _userResponse.close();
  }
}
