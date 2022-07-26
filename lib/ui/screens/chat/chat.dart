import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:solh/controllers/chat-list/chat_controller.dart';
import 'package:solh/ui/screens/chat/chat_controller/chat_controller.dart';
import 'package:solh/ui/screens/chat/chat_model/chat_model.dart';
import 'package:solh/ui/screens/chat/chat_services/chat_socket_service.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {Key? key,
      required String imageUrl,
      required String name,
      required String sId})
      : _imageUrl = imageUrl,
        _name = name,
        _sId = sId,
        super(key: key);

  final String _imageUrl;
  final String _name;
  final String _sId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  SocketService _service = SocketService();
  var _controller = Get.put(ChatController());
  @override
  void initState() {
    // TODO: implement initState

    _service.connectAndListen();
    _controller.getChatController(widget._sId);
    super.initState();
    SocketService.setUserName(widget._name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.maxFinite,
          child: Column(
            children: [
              ChatAppbar(imageUrl: widget._imageUrl, name: widget._name),
              Expanded(
                child: MessageList(
                  sId: widget._sId,
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: MessageBox(
                    sId: widget._sId,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class ChatAppbar extends StatelessWidget {
  const ChatAppbar({Key? key, required String imageUrl, required name})
      : _imageUrl = imageUrl,
        _name = name,
        super(key: key);

  final String _imageUrl;
  final String _name;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, 2),
            blurRadius: 2,
            spreadRadius: 2,
            color: Colors.black12)
      ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            InkWell(
                onTap: (() {
                  Navigator.of(context).pop();
                }),
                child: Icon(Icons.arrow_back_ios_new)),
            SizedBox(
              width: 6,
            ),
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              backgroundImage: CachedNetworkImageProvider(_imageUrl == ''
                  ? 'https://180dc.org/wp-content/uploads/2016/08/default-profile.png'
                  : _imageUrl),
            ),
            SizedBox(
              width: 6,
            ),
            Text(
              _name == '' ? '' : _name,
              style: GoogleFonts.signika(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBox extends StatelessWidget {
  MessageBox({Key? key, required String sId})
      : _sId = sId,
        super(key: key);

  final String _sId;

  ChatController _controller = Get.put(ChatController());
  SocketService service = SocketService();
  ChatListController chatListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          border: Border.all(
            color: SolhColors.green,
          ),
          borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: _controller.messageEditingController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write message',
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (_controller.messageEditingController.text.trim() == '') {
                  return;
                } else {
                  _controller.sendMessageController(
                    _controller.messageEditingController.text,
                    _sId,
                    'users',
                    'connection',
                  );
                }
                chatListController.chatListController();
              },
              child: Icon(
                Icons.send,
                color: SolhColors.green,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageList extends StatefulWidget {
  MessageList({
    Key? key,
    required String sId,
  })  : _sId = sId,
        super(key: key);

  final String _sId;

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  ChatController _controller = Get.put(ChatController());

  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _controller.isLoading == true
          ? Column(
              children: [
                CircularProgressIndicator(),
              ],
            )
          : Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: _controller.convo.length,
                    itemBuilder: (context, index) {
                      final reversedIndex =
                          _controller.convo.length - 1 - index;

                      return MessageTile(
                        message: _controller.convo.value[reversedIndex].body,
                        dateTime:
                            _controller.convo.value[reversedIndex].dateTime,
                        authorId:
                            _controller.convo.value[reversedIndex].authorId,
                        sId: widget._sId,
                      );
                    }),
              ),
            );
    });
  }
}

class MessageTile extends StatelessWidget {
  const MessageTile(
      {Key? key,
      required message,
      required authorId,
      required sId,
      String? dateTime})
      : _message = message,
        _authorId = authorId,
        _sId = sId,
        _dateTime = dateTime ?? '',
        super(key: key);

  final String _message;
  final String _authorId;
  final String _sId;
  final String _dateTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Row(
          mainAxisAlignment: _authorId == _sId
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   _authorId,
                    //   style: GoogleFonts.signika(color: Colors.lightGreen),
                    // ),
                    ReadMoreText(
                      _message,
                      style: GoogleFonts.signika(color: Colors.black),
                      trimLines: 8,
                      colorClickableText: Colors.pink,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      trimMode: TrimMode.Line,
                      moreStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: SolhColors.green),
                      lessStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: SolhColors.green),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              _dateTime == null
                  ? ''
                  : DateTime.tryParse(_dateTime) != null
                      ? DateFormat('dd MMM kk:mm')
                          .format(DateTime.parse(_dateTime).toLocal())
                      : '',
              style: GoogleFonts.signika(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
