import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import '../../../bloc/user-bloc.dart';
import 'package:solh/controllers/chat-list/chat_list_controller.dart';
import 'package:solh/ui/screens/chat/chat_controller/chat_controller.dart';
import 'package:solh/ui/screens/chat/chat_services/chat_socket_service.dart';
import 'package:solh/ui/screens/video-call/video-call-user.dart';
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
    _service.connectAndListen();
    SocketService.setCurrentSId(widget._sId);
    _controller.getChatController(widget._sId);
    _controller.currentSid = widget._sId;

    SocketService.setUserName(userBlocNetwork.myData.name!);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.isVideoConnecting.value = false;
    SocketService.userLeft();
    SocketService.dispose();
    super.dispose();
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
              ChatAppbar(
                  imageUrl: widget._imageUrl,
                  name: widget._name,
                  sId: widget._sId),
              Expanded(
                child: MessageList(
                  sId: widget._sId,
                ),
              ),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _controller.istyping.value == true
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              'Typing....',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : Container()
                  ],
                );
              }),
              Align(
                alignment: Alignment.bottomCenter,
                child: MessageBox(
                  sId: widget._sId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatAppbar extends StatelessWidget {
  ChatAppbar({Key? key, required String imageUrl, required name, required sId})
      : _imageUrl = imageUrl,
        _name = name,
        _sId = sId,
        super(key: key);

  final String _imageUrl;
  final String _name;
  final String _sId;

  ChatController _controller = Get.put(ChatController());
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // InkWell(
                //     onTap: (() {
                //       Navigator.of(context).pop();
                //     }),
                //     child: Icon(Icons.arrow_back_ios_new)),
                InkWell(
                  onTap: (() {
                    SocketService.userLeft();
                    Navigator.of(context).pop();
                  }),
                  child: Container(
                    width: 50,
                    child: Icon(Icons.arrow_back_ios_new),
                  ),
                ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _name == '' ? '' : _name,
                      style: GoogleFonts.signika(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Obx(() {
                      print('seen status ran' +
                          _controller.seenStatus.value.toString());
                      return Text(
                        _controller.seenStatus.value,
                        style: GoogleFonts.signika(color: SolhColors.green),
                      );
                    })
                  ],
                ),
              ],
            ),
            Obx(() => _controller.isVideoConnecting.value
                ? Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Icon(
                      Icons.video_call,
                      size: 34,
                      color: Colors.grey,
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      Map<String, dynamic> body = {
                        "uid": '0',
                        "tokentype": "uid",
                        "expiry": "",
                        "role": "publisher",
                        "sender": userBlocNetwork.id.toString(),
                        "senderType": "seeker",
                        "receiver": _sId,
                        "receiverType": "seeker",
                        "channel": (userBlocNetwork.id.toString() +
                            '_' +
                            _sId.toString()),
                        "appointmentId": "",
                        "callType": "cc",
                        "callStatus": "initiated"
                      };
                      var value =
                          await _controller.initiateVideoController(body);
                      if (value['success'] == true) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => VideoCallUser(
                                  channel: value['data']['channelName'],
                                  token: value['data']['rtcToken'],
                                  sId: _sId,
                                ))));
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Icon(
                        Icons.video_call_outlined,
                        size: 34,
                        color: SolhColors.green,
                      ),
                    ),
                  )),
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
                onChanged: ((value) {
                  SocketService.typing(_sId, 'cc', 'users');

                  Future.delayed(Duration(seconds: 2), (() {
                    SocketService.notTyping(_sId, 'cc', 'users');
                  }));
                }),
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
                    message: _controller.messageEditingController.text,
                    sId: _sId,
                    autherType: 'users',
                    ct: 'cc',
                    mediaType: '',
                    mediaUrl: '',
                    fileName: '',
                    appointmentId: '',
                    conversationType: 'text',
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
                color: _authorId == _sId
                    ? Colors.grey.shade200
                    : Color(0x80CCE9E2),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Text(
                    //   _authorId,
                    //   style: GoogleFonts.signika(color: Colors.lightGreen),
                    // ),
                    ReadMoreText(
                      _message,
                      style: GoogleFonts.signika(color: Color(0xff666666)),
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
                    Text(
                      _dateTime == null
                          ? ''
                          : DateTime.tryParse(_dateTime) != null
                              ? DateFormat('dd MMM kk:mm')
                                  .format(DateTime.parse(_dateTime).toLocal())
                              : '',
                      style: GoogleFonts.signika(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: SolhColors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
