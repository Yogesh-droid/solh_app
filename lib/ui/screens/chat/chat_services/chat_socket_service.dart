import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solh/controllers/chat-list/chat_controller.dart';

import 'package:solh/model/user/user.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/ui/screens/chat/chat_controller/chat_controller.dart';
import 'package:solh/ui/screens/chat/chat_model/chat_model.dart';
import 'package:solh/ui/screens/chat/constants/constants.dart';

import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  static late StreamController<Conversation> _socketResponse;
  static late StreamController<List<String>> _userResponse;
  // final ChatController _chatController = Get.find();

  // ChatController _chatController = ChatController();
  static late io.Socket socket = io.io(
      serverUrl,
      io.OptionBuilder()
          .setTransports(['websocket', 'polling']) // for Flutter or Dart VM

          .setQuery({'userName': _userName})
          .enableAutoConnect()
          .build());
  static String _userName = '';

  static String? get userId => socket.id;

  static Stream<Conversation> get getResponse =>
      _socketResponse.stream.asBroadcastStream();
  static Stream<List<String>> get userResponse =>
      _userResponse.stream.asBroadcastStream();

  static void setUserName(String name) {
    _userName = name;
  }

  static void sendMessage(
      String message, String sId, String autherType, String ct) {
    print(socket.id);
    socket.emit('message', {
      'socketId': socket.id,
      'author': _userName,
      'authorId': userBlocNetwork.id,
      'authorType': autherType,
      'body': message,
      'connection': sId,
      'ct': ct,
    });
  }

  void connectAndListen() {
    _socketResponse = StreamController<Conversation>();
    _userResponse = StreamController<List<String>>();

    socket.connect();

    socket.onConnect((data) {
      print('connected');
      print(socket.id);
      socket.emit('uconnect', {
        'socketId': socket.id,
        'userId': userBlocNetwork.id,
      });
    });
    socket.onConnectError(
      (data) {
        print(data);
      },
    );

    print(socket.connected);
    socket.emit('uconnect', {
      'socketId': socket.id,
      'userId': userBlocNetwork.id,
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
    socket.dispose();
    socket.destroy();
    socket.close();
    socket.disconnect();
    _socketResponse.close();
    _userResponse.close();
  }
}
