import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/mood-meter/mood_meter_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/home/chat-anonymously/chat-anon-controller/chat_anon_controller.dart';
import 'package:solh/ui/screens/video-call/video-call-user.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/animated_refresh_container.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';
import 'package:solh/widgets_constants/typing_indicator.dart';
import 'package:solh/controllers/chat-list/chat_list_controller.dart';
import 'package:solh/ui/screens/chat/chat_controller/chat_controller.dart';
import 'package:solh/ui/screens/chat/chat_services/chat_socket_service.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key, required Map<dynamic, dynamic> args})
      : _imageUrl = args['imageUrl'],
        _name = args["name"],
        _sId = args["sId"],
        _nowChat = args["nowChat"],
        _isAnonChat = args['isAnonChat'] ?? false,
        super(key: key);

  final String _imageUrl;
  final String _name;
  final String _sId;
  final bool? _nowChat;
  final bool _isAnonChat;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  SocketService _service = SocketService();
  ProfileController profileController = Get.find();
  ChatAnonController chatAnonController = Get.put(ChatAnonController());
  MoodMeterController moodMeterController = Get.find();
  var _controller = Get.put(ChatController());
  final focus = FocusNode();
  @override
  void initState() {
    debugPrint(
        'anon ${profileController.myProfileModel.value.body!.user!.sId}');
    _service.connectAndListen();
    _controller.currentSid = widget._sId;
    SocketService.setCurrentSId(widget._sId);
    SocketService.isSosChatSupport =
        profileController.myProfileModel.value.body!.user!.sosChatSupport!;
    if (widget._isAnonChat) {
      SocketService.isAnon = widget._isAnonChat;
    }
    if (widget._isAnonChat == false ||
        profileController.myProfileModel.value.body!.user!.sosChatSupport ==
            true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.getChatController(widget._sId);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget._isAnonChat) {
        _controller.getSosChatController(widget._sId);
      }
    });

    print(
        'my profile id ${profileController.myProfileModel.value.body!.user!.sId}');
    if (widget._isAnonChat == true &&
        profileController.myProfileModel.value.body!.user!.sosChatSupport !=
            true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {});
      if (profileController.myProfileModel.value.body!.user!.sosChatSupport ==
          false) {
        debugPrint("first msg sent3");
        delayedAnonChat();
      }
    }

    if (widget._isAnonChat) {
      chatAnonController.anonSId.value = widget._sId;
    }
    _controller.currentSid = widget._sId;

    widget._isAnonChat
        ? SocketService.setUserName(profileController
                .myProfileModel.value.body!.user!.anonymous!.userName ??
            '')
        : SocketService.setUserName(
            profileController.myProfileModel.value.body!.user!.name ?? '');

    super.initState();
  }

  delayedAnonChat() {
    // if (_controller.isfirstmsgSent == false) {
    //   Future.delayed(Duration(milliseconds: 1000), () {
    //     sendFirstAnonChat();
    //   });
    // }
  }

  sendFirstAnonChat() {
    _controller.sendMessageController(
        message: "Hi, is anyone their ?",
        conversationType: "text",
        sId: widget._sId,
        autherType: "users",
        ct: "sosChat",
        mediaUrl: "",
        appointmentId: null,
        mediaType: '',
        authorId: profileController.myProfileModel.value.body!.user!.sId!,
        fileName: "");
    _controller.isfirstmsgSent = true;
  }

  @override
  void dispose() {
    _controller.isVideoConnecting.value = false;
    _service.userLeft();
    SocketService.isAnon = false;
    _controller.pageController.dispose();
    _controller.selectedStar.value = 0;
    chatAnonController.feedbackTextField.text = '';
    _controller.firstMsgSent = false;
    SocketService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Get.find<ChatListController>().fromIDontKnow &&
            _controller.firstMsgSent == false) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else if (widget._nowChat != null) {
          Navigator.of(context).pop();
        } else if (_controller.firstMsgSent == false && widget._isAnonChat) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else if (widget._isAnonChat &&
            profileController.myProfileModel.value.body!.user!.sosChatSupport !=
                true &&
            _controller.firstMsgSent) {
          return _onWillPop(context, widget._sId);
        }
        return true;
      },
      child: SafeArea(
        child: ScaffoldWithBackgroundArt(
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.maxFinite,
            child: Column(
              children: [
                ChatAppbar(
                  imageUrl: widget._imageUrl,
                  name: widget._name,
                  sId: widget._sId,
                  nowchat: widget._nowChat,
                  isAnonChat: widget._isAnonChat,
                ),
                const SizedBox(
                  height: 10,
                ),
                widget._isAnonChat &&
                        profileController.myProfileModel.value.body!.user!
                                .sosChatSupport !=
                            true
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Welcome to your safe and confidential space for mental wellness. Take the first step and share your feelings here.'
                              .tr,
                          style: SolhTextStyles.QS_cap_semi.copyWith(
                              color: SolhColors.Grey_1),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : (profileController.myProfileModel.value.body!.user!
                                .sosChatSupport ==
                            true
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Text(
                              'Please take this conversation further. The seeker is waiting for you.'
                                  .tr,
                              style: SolhTextStyles.QS_cap_semi.copyWith(
                                  color: SolhColors.Grey_1),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : Container()),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: MessageList(
                    sId: widget._sId,
                  ),
                ),
                Stack(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _controller.istyping == true
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: TypingIndicator(),
                                )
                              : Container()
                        ],
                      );
                    }),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: MessageBox(
                      focus: focus,
                      sId: widget._sId,
                      chatType: 'cc',
                      isAnon: widget._isAnonChat,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ChatAppbar extends StatelessWidget {
  ChatAppbar(
      {Key? key,
      required String imageUrl,
      required name,
      required sId,
      nowchat,
      required isAnonChat})
      : _imageUrl = imageUrl,
        _name = name,
        _sId = sId,
        _nowChat = nowchat,
        _isAnonChat = isAnonChat,
        super(key: key);

  final String _imageUrl;
  final String _name;
  final String _sId;
  final bool? _nowChat;
  final bool _isAnonChat;

  ChatController _controller = Get.put(ChatController());
  ProfileController profileController = Get.find();
  SocketService service = SocketService();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
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
                InkWell(
                  onTap: (() async {
                    print(
                        'fromIDontKnow ${Get.find<ChatListController>().fromIDontKnow} ,firstMsgSent ${_controller.firstMsgSent} _nowChat $_nowChat,_isAnonChat $_isAnonChat, ');
                    if (Get.find<ChatListController>().fromIDontKnow &&
                        _controller.firstMsgSent == false) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    } else if (_nowChat != null) {
                      Navigator.of(context).pop();
                    } else if (_isAnonChat == true &&
                        profileController.myProfileModel.value.body!.user!
                                .sosChatSupport !=
                            true &&
                        _controller.firstMsgSent) {
                      await _onWillPop(context, _sId);
                      service.userLeft();
                    } else {
                      service.userLeft();
                      if (_isAnonChat) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                      Navigator.of(context).pop();
                      // Navigator.of(context).pop();
                    }

                    _controller.firstMsgSent = false;
                  }),
                  child: const SizedBox(
                    width: 50,
                    child: Icon(Icons.arrow_back_ios_new),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: CachedNetworkImageProvider(_imageUrl == ''
                      ? 'https://180dc.org/wp-content/uploads/2016/08/default-profile.png'
                      : _imageUrl),
                ),
                const SizedBox(
                  width: 6,
                ),
                SizedBox(
                  width: 50.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _name == '' ? '' : _name,
                        style: GoogleFonts.signika(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      _isAnonChat
                          ? Container()
                          : Obx(() {
                              return Text(
                                _controller.seenStatus.value,
                                style: GoogleFonts.signika(
                                    color: SolhColors.primary_green),
                              );
                            })
                    ],
                  ),
                ),
              ],
            ),
            (_isAnonChat ||
                        ifMinor(profileController
                            .myProfileModel.value.body!.user!.dob!) ||
                        _sId == '62e125176a858283a925d15c') &&
                    profileController
                            .myProfileModel.value.body!.user!.sosChatSupport ==
                        false
                ? Container()
                : Obx(
                    () => _controller.isVideoConnecting.value
                        ? const Padding(
                            padding: EdgeInsets.only(right: 24),
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
                                "sender": profileController
                                    .myProfileModel.value.body!.user!.sId!,
                                "senderType": "seeker",
                                "receiver": _sId,
                                "receiverType": "seeker",
                                "channel": (profileController
                                        .myProfileModel.value.body!.user!.sId! +
                                    '_' +
                                    _sId.toString()),
                                "appointmentId": "",
                                "callType": "cc",
                                "callStatus": "initiated"
                              };
                              var value = await _controller
                                  .initiateVideoController(body);
                              if (value['success'] == true) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => VideoCallUser(
                                          channel: value['data']['channelName'],
                                          token: value['data']['rtcToken'],
                                          sId: _sId,
                                        ))));
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 24),
                              child: Icon(
                                Icons.video_call_outlined,
                                size: 34,
                                color: SolhColors.primary_green,
                              ),
                            ),
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}

class MessageBox extends StatefulWidget {
  MessageBox(
      {Key? key, required String sId, this.chatType, this.isAnon, this.focus})
      : _sId = sId,
        super(key: key);

  final String _sId;
  final String? chatType;
  final bool? isAnon;
  final focus;

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(widget.focus);
    });

    super.initState();
  }

  ChatController _controller = Get.put(ChatController());

  SocketService service = SocketService();

  ChatListController chatListController = Get.find();

  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: SolhColors.white,
          border: Border.all(
            color: SolhColors.white,
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
                maxLines: null,
                focusNode: widget.focus,
                onChanged: ((value) {
                  service.typing(widget._sId,
                      widget.chatType == 'sc' ? 'sc' : 'cc', 'users');
                  _controller.isTypingEpochTime.value =
                      DateTime.now().millisecondsSinceEpoch;

                  Future.delayed(const Duration(seconds: 2), (() {
                    if (DateTime.now().millisecondsSinceEpoch -
                            _controller.isTypingEpochTime.value >=
                        2000) {
                      service.notTyping(widget._sId,
                          widget.chatType == 'sc' ? 'sc' : 'cc', 'users');
                    }
                  }));
                }),
                controller: _controller.messageEditingController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: SolhColors.primary_green)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: SolhColors.primary_green)),
                  // border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (_controller.messageEditingController.text.trim() ==
                          '') {
                        return;
                      } else {
                        _controller.firstMsgSent = true;
                        _controller.sendMessageController(
                            message: _controller.messageEditingController.text,
                            sId: widget._sId,
                            autherType: 'users',
                            ct: widget.isAnon == true
                                ? 'sosChat'
                                : (widget.chatType == 'sc' ? 'sc' : 'cc'),
                            mediaType: '',
                            mediaUrl: '',
                            fileName: '',
                            appointmentId: '',
                            conversationType: 'text',
                            authorId: profileController
                                .myProfileModel.value.body!.user!.sId!);
                      }
                      chatListController.chatListController(1);
                    },
                    icon: const Icon(
                      Icons.send,
                      color: SolhColors.primary_green,
                    ),
                  ),
                  hintText: 'Write message'.tr,
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
                        sId: widget._sId,
                        autherType: 'users',
                        ct: widget.isAnon == true
                            ? 'sosChat'
                            : (widget.chatType == 'sc' ? 'sc' : 'cc'),
                        mediaType: '',
                        mediaUrl: '',
                        fileName: '',
                        appointmentId: '',
                        conversationType: 'text',
                        authorId: profileController
                            .myProfileModel.value.body!.user!.sId!);
                  }
                  chatListController.chatListController(1);
                },
                child: Container())
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
                AnimatedRefreshContainer(
                  text: 'Loading...',
                )
              ],
            )
          : Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: _controller.convo.length,
                    itemBuilder: (context, index) {
                      final reversedIndex =
                          _controller.convo.length - 1 - index;

                      return MessageTile(
                        message: _controller.convo[reversedIndex].body,
                        author: _controller.convo[reversedIndex].author,
                        dateTime: _controller.convo[reversedIndex].dateTime,
                        authorId: _controller.convo[reversedIndex].authorId,
                        sId: widget._sId,
                      );
                    }),
              ),
            );
    });
  }
}

// ignore: must_be_immutable
class MessageTile extends StatelessWidget {
  MessageTile(
      {Key? key,
      required message,
      required authorId,
      required author,
      required sId,
      String? dateTime})
      : _message = message,
        _authorId = authorId,
        _sId = sId,
        _author = author,
        _dateTime = dateTime ?? '',
        super(key: key);

  final String _message;
  final String _authorId;
  final String _author;
  // ignore: unused_field
  final String _sId;
  final String _dateTime;

  ProfileController profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    print(
        '_author ${profileController.myProfileModel.value.body!.user!.sId!} ${_authorId} ${_message}');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Row(
          mainAxisAlignment: _authorId ==
                  profileController.myProfileModel.value.body!.user!.sId!
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: _authorId ==
                        profileController.myProfileModel.value.body!.user!.sId!
                    ? Colors.grey.shade200
                    : const Color(0xFFEFF9F6),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        profileController.myProfileModel.value.body!.user!
                                .sosChatSupport!
                            ? Text(
                                _author,
                                style: SolhTextStyles.SmallTextGreen1S12W5,
                              )
                            : Container(),
                      ],
                    ),
                    InkWell(
                      onLongPress: () async {
                        await Clipboard.setData(ClipboardData(text: _message));
                        Utility.showToast("Successfully copied".tr);
                      },
                      child: ReadMoreText(
                        _message,
                        style:
                            GoogleFonts.signika(color: const Color(0xff666666)),
                        trimLines: 8,
                        colorClickableText: Colors.pink,
                        trimCollapsedText: 'Show more',
                        trimExpandedText: 'Show less',
                        trimMode: TrimMode.Line,
                        moreStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: SolhColors.primary_green),
                        lessStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: SolhColors.primary_green),
                      ),
                    ),
                    Text(
                      DateTime.tryParse(_dateTime) != null
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

class RatingBottomSheet extends StatefulWidget {
  RatingBottomSheet({Key? key, required this.sId}) : super(key: key);
  final String sId;

  @override
  State<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  final PageController pageController = PageController();

  final ChatController chatController = Get.find();
  @override
  void dispose() {
    pageController.dispose();
    chatController.dispose();
    chatController.firstMsgSent = false;
    Get.find<ChatListController>().fromIDontKnow = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: chatController.pageController,
      children: [
        RatingBottomSheetChild1(
          sId: widget.sId,
        ),
        RatingBottomSheetChild2(
          sId: widget.sId,
        ),
      ],
    );
  }
}

class RatingBottomSheetChild1 extends StatelessWidget {
  RatingBottomSheetChild1({Key? key, required this.sId}) : super(key: key);

  final String sId;

  final ChatController chatController = Get.find();
  final ChatAnonController chatAnonController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/ScaffoldBackgroundGreen.png'),
          ),
        ),
        child: Column(children: [
          SizedBox(
            height: 2.h,
          ),
          Container(
            height: 5,
            width: 10.w,
            decoration: BoxDecoration(
              color: SolhColors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          const Divider(
            color: SolhColors.white,
          ),
          SizedBox(
            height: 2.h,
          ),
          Column(
            children: [
              Column(
                children: [
                  Text(
                    'Rate your Experience'.tr,
                    style: SolhTextStyles.QS_big_body.copyWith(
                        color: SolhColors.white),
                  ),
                  Text(
                    'Your chat ended, Please rate your experience'.tr,
                    style: SolhTextStyles.QS_cap_2.copyWith(
                        color: SolhColors.white, fontSize: 14),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              RatingStars(sId: sId),
              SizedBox(
                height: 10.h,
              ),
              Obx(() {
                return chatAnonController.isPostingFeedback.value
                    ? const ButtonLoadingAnimation(
                        ballColor: SolhColors.white,
                        ballSizeLowerBound: 3,
                        ballSizeUpperBound: 8,
                      )
                    : InkWell(
                        onTap: () => chatController.pageController
                            .animateToPage(1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn),
                        child: SizedBox(
                          height: 48,
                          width: 120,
                          child: Center(
                            child: Text(
                              'Skip'.tr,
                              style: SolhTextStyles.CTA
                                  .copyWith(color: SolhColors.white),
                            ),
                          ),
                        ),
                      );
              })
            ],
          ),
        ]),
      ),
    );
  }
}

class RatingStars extends StatelessWidget {
  RatingStars({Key? key, required String this.sId}) : super(key: key);

  final String sId;

  final ChatController chatController = Get.find();
  final ChatAnonController chatAnonController = Get.find();

  final List<int> starValue = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: starValue
              .map((e) => Row(
                    children: [
                      SizedBox(
                        width: 3.w,
                      ),
                      InkWell(
                        onTap: () async {
                          chatController.selectedStar.value = e;
                          bool response = await chatAnonController
                              .postFeedbackController({
                            "volunteerId": sId,
                            "ratings":
                                chatController.selectedStar.value.toString()
                          });

                          if (response) {
                            SolhSnackbar.success(
                                '', 'Thank you. Rating recorded successfully');
                            chatController.pageController.animateToPage(2,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          } else {
                            SolhSnackbar.error('Error', 'Something went wrong');
                          }
                        },
                        child: getStart(
                            starvalue: e, chatController: chatController),
                      ),
                    ],
                  ))
              .toList());
    });
  }
}

Widget getStart(
    {required ChatController chatController, required int starvalue}) {
  return Container(
    padding: const EdgeInsets.all(6),
    decoration: const BoxDecoration(
        color: SolhColors.greenShade1, shape: BoxShape.circle),
    child: Icon(
      chatController.selectedStar < starvalue ? Icons.star_border : Icons.star,
      size: 10.w,
      color: const Color(0xfff0ba00),
    ),
  );
}

class RatingBottomSheetChild2 extends StatelessWidget {
  RatingBottomSheetChild2({Key? key, required this.sId}) : super(key: key);

  final String sId;
  final ChatAnonController chatAnonController = Get.find();
  final ChatController chatController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Container(
            height: 5,
            width: 10.w,
            decoration: BoxDecoration(
              color: SolhColors.grey_3,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          const Divider(
            color: SolhColors.grey_3,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please write your feedback here'.tr,
                      style: SolhTextStyles.QS_body_2,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                TextField(
                  controller: chatAnonController.feedbackTextField,
                  maxLines: 5,
                  minLines: 2,
                  decoration: TextFieldStyles.greenF_greyUF_4R.copyWith(
                    hintText: 'Write here'.tr,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: SolhColors.grey_3,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                SolhGreenButton(
                  onPressed: () async {
                    if (chatAnonController.feedbackTextField.text.trim() !=
                        '') {
                      bool response =
                          await chatAnonController.postFeedbackController({
                        "volunteerId": sId,
                        "reviewBody": chatAnonController.feedbackTextField.text,
                      });
                      chatAnonController.selectedIsses.value = [];
                      chatAnonController.selectedIssuesName.value = '';
                      chatAnonController.selectedOtherIssues.value = [];
                      chatAnonController.selectedOtherIssuesName.value = '';
                      chatController.convo.value = [];

                      if (response) {
                        SolhSnackbar.success(
                            '', 'Thank you. feedback recorded successfully');
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.master, (route) => false);
                      } else {
                        SolhSnackbar.error('Error', 'Something went wrong');
                      }
                    } else {
                      SolhSnackbar.error('Opps!', "It can't be empty");
                    }
                  },
                  child: Obx(() {
                    return chatAnonController.isPostingFeedback.value
                        ? const ButtonLoadingAnimation(
                            ballColor: SolhColors.white,
                            ballSizeLowerBound: 3,
                            ballSizeUpperBound: 8,
                          )
                        : Text('Submit'.tr);
                  }),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        chatAnonController.selectedIsses.value = [];
                        chatAnonController.selectedIssuesName.value = '';
                        chatAnonController.selectedOtherIssues.value = [];
                        chatAnonController.selectedOtherIssuesName.value = '';
                        chatController.convo.value = [];
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.master, (route) => false);
                      },
                      child: SizedBox(
                        height: 40,
                        width: 120,
                        child: Center(
                          child: Text(
                            'Skip'.tr,
                            style: SolhTextStyles.CTA
                                .copyWith(color: SolhColors.primary_green),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<bool> _onWillPop(context, sId) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.all(8.0),
          content: Text(
            'Do you want to end the chat?'.tr,
            style: SolhTextStyles.JournalingDescriptionText,
          ),
          actions: [
            TextButton(
                child: Text(
                  'Cancel'.tr,
                  style: SolhTextStyles.CTA,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            TextButton(
                child: Text(
                  'Leave'.tr,
                  style:
                      SolhTextStyles.CTA.copyWith(color: SolhColors.primaryRed),
                ),
                onPressed: () async {
                  print('model sheet shown');
                  Navigator.of(context).pop();
                  await showModalBottomSheet(
                      isScrollControlled: true,
                      constraints: BoxConstraints(maxHeight: 85.h),
                      context: context,
                      builder: (context) {
                        return Container(
                            // padding: EdgeInsets.only(
                            //     bottom:
                            //         MediaQuery.of(context).viewInsets.bottom),
                            // height: 60.h,
                            child: RatingBottomSheet(sId: sId));
                      });
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, AppRoutes.master, (route) => false);
                }),
          ],
        );
      });
}

bool ifMinor(String dob) {
  DateTime birthDate = DateTime.parse(dob);

  if (DateTime.now().year - birthDate.year < 18) {
    return true;
  } else if (DateTime.now().year - birthDate.year == 18) {
    if (DateTime.now().month < birthDate.month) {
      return DateTime.now().month < birthDate.month;
    } else if (DateTime.now().month == birthDate.month) {
      return DateTime.now().day <= birthDate.day;
    }
  }
  return false;
}
