import 'package:intl/intl.dart';

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
  ChatController _controller = ChatController();
  static late io.Socket _socket = io.io(
      serverUrl,
      io.OptionBuilder()
          .setTransports(['websocket', 'polling']) // for Flutter or Dart VM
          .disableAutoConnect()
          .setQuery({'userName': _userName})
          .enableAutoConnect()
          .build());
  static String _userName = '';

  static String? get userId => _socket.id;

  static Stream<Conversation> get getResponse =>
      _socketResponse.stream.asBroadcastStream();
  static Stream<List<String>> get userResponse =>
      _userResponse.stream.asBroadcastStream();

  static void setUserName(String name) {
    _userName = name;
  }

  static void sendMessage(
      String message, String sId, String autherType, String ct) {
    _socket.emit('message', {
      'author': _userName,
      'authorId': userBlocNetwork.id,
      'authorType': autherType,
      'body': message,
      'connection': sId,
      'ct': ct,
    });
  }

  static void connectAndListen() {
    _socketResponse = StreamController<Conversation>();
    _userResponse = StreamController<List<String>>();

    _socket.connect();

    _socket.onConnect((data) {
      print('connected');
    });
    _socket.onConnectError(
      (data) {
        print(data);
      },
    );
    print(_socket.connected);
    print(_socket.query);

    //When an event recieved from server, data is added to the stream
    _socket.on('message', (data) {
      _socketResponse.sink.add(Conversation.fromJson(data));
    });

    //when users are connected or disconnected
    _socket.on('users', (data) {
      var users = (data as List<dynamic>).map((e) => e.toString()).toList();
      _userResponse.sink.add(users);
    });

    // _socket.onDisconnect((_) => print('disconnect'));
  }

  static void dispose() {
    _socket.dispose();
    _socket.destroy();
    _socket.close();
    _socket.disconnect();
    _socketResponse.close();
    _userResponse.close();
  }
}
