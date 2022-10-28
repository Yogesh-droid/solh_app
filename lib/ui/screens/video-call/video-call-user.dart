import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:solh/controllers/chat-list/chat_list_controller.dart';
import 'package:solh/ui/screens/chat/chat.dart';
import 'package:solh/ui/screens/chat/chat_controller/chat_controller.dart';
import 'package:solh/ui/screens/chat/chat_provider.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../bloc/user-bloc.dart';
import '../chat/chat_services/chat_socket_service.dart';

class VideoCallUser extends StatefulWidget {
  var appId = "4db2d5eea0c3466cb8dc7ba7f488dbef";
  var token;
  // "0064db2d5eea0c3466cb8dc7ba7f488dbefIABV0AhZlwohqekpkdqXNpk8FlEVw5u5FwIFWzdr/3U1DMJBJDUh39v0IgAi1l/HOrwBYwQAAQDKeABjAgDKeABjAwDKeABjBADKeABj";
  var channel;
  String? sId;
  String? type;

  VideoCallUser(
      {required this.token,
      required this.channel,
      required this.sId,
      this.type});

  @override
  State<VideoCallUser> createState() => _CallState();
}

class _CallState extends State<VideoCallUser> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool muted = false;
  bool _isVideoDisabled = false;
  late Timer timer;
  ChatController _controller = Get.put(ChatController());
  ChatListController _chatListController = Get.put(ChatListController());
  // OverlayEntry? overlayEntry;
  SocketService _service = SocketService();
  PageController pageController = PageController();
  bool isBottomSheetOpened = false;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SocketService.currentSId = widget.sId ?? '';
      _controller.currentSid = widget.sId ?? '';
      timer = Timer(Duration(seconds: 20), () {
        if (_remoteUid == null) {
          _engine.leaveChannel();
          _engine.destroy();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Person not available',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
          ));
        }
      });
      initAgora();
      initChatService();
    });
    super.initState();
  }

  Future<void> initChatService() async {
    await userBlocNetwork.getMyProfileSnapshot();
    _service.connectAndListen();
    SocketService.setCurrentSId(widget.sId!);
    if (_controller.convo.isEmpty) {
      _controller.getChatController(widget.sId!);
    }
    SocketService.setUserName(userBlocNetwork.myData.name!);
  }

  Future<void> initAgora() async {
    print(widget.channel);
    print(widget.token);
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = await RtcEngine.create(widget.appId);
    await _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print(" time $elapsed");
          print("local user $uid joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        userJoined: (int uid, int elapsed) {
          print("remote user $uid joined");
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print("remote user $uid left channel");
          _engine.leaveChannel();
          _engine.destroy();

          Navigator.pop(context);
          if (isBottomSheetOpened) {
            Navigator.pop(context);
          }

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              reason.name == 'Quit' ? '  Call Ended  ' : '  User offline  ',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5))),
          ));
        },
      ),
    );
    await _engine.joinChannel(widget.token, widget.channel, null, 0);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: SolhAppBar(
          isLandingScreen: false,
          title: Text(
            'Video Call',
            style: SolhTextStyles.AppBarText,
          ),
          callback: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                        'Your Call will be stopped \n Do you want to exit session ?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          _engine.leaveChannel();
                        },
                        child: Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No'),
                      )
                    ],
                  );
                });
          },
        ),
        // body: PageView(
        //   controller: pageController,
        //   scrollDirection: Axis.vertical,
        //   children: [getVideocallPage(), getChatPage(widget.sId)],
        // ),

        body: getVideocallPage(),
      ),
    );
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid!,
        channelId: widget.channel,
      );
    } else {
      return Text(
        'Connecting ......',
        textAlign: TextAlign.center,
      );
    }
  }

  Future<bool> _onWillPop() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
                'Your Call will be stopped \n Do you want to exit session ?'),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  _engine.leaveChannel();
                },
                child: Text('Yes'),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('No'),
              )
            ],
          );
        });
    return Future.value(true);
  }

  Widget getVideocallPage() {
    return Stack(
      children: [
        Center(
          child: _remoteVideo(),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            width: 100,
            height: 150,
            child: Center(
              child: _localUserJoined
                  ? RtcLocalView.SurfaceView()
                  : CircularProgressIndicator(),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 50,
                child: RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      muted = !muted;
                      _engine.muteLocalAudioStream(muted);
                    });
                    // _engine.muteLocalAudioStream(muted);
                  },
                  child: Icon(
                    muted ? Icons.mic_off : Icons.mic,
                    color: muted ? Colors.white : Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: muted ? Colors.blueAccent : Colors.white,
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
              Container(
                width: 50,
                child: RawMaterialButton(
                  onPressed: () {
                    setState(() {
                      _isVideoDisabled = !_isVideoDisabled;
                      _engine.muteLocalVideoStream(_isVideoDisabled);
                    });
                  },
                  child: Icon(
                    _isVideoDisabled ? Icons.videocam_off : Icons.videocam,
                    color: _isVideoDisabled ? Colors.white : Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor:
                      _isVideoDisabled ? Colors.blueAccent : Colors.white,
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
              Container(
                width: 50,
                child: RawMaterialButton(
                  onPressed: () {
                    _engine.leaveChannel();
                    _engine.destroy();
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.call_end,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.redAccent,
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
              Container(
                width: 50,
                child: RawMaterialButton(
                  onPressed: () => _engine.switchCamera(),
                  child: Icon(
                    Icons.switch_camera,
                    color: Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
              Container(
                width: 50,
                child: RawMaterialButton(
                  onPressed: () {
                    // pageController.nextPage(
                    //     duration: Duration(milliseconds: 200),
                    //     curve: Curves.easeIn);
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        enableDrag: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => getChatPage(widget.sId));
                    isBottomSheetOpened = true;
                  },
                  child: Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget getChatPage(String? sId) {
    return Container(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, top: 20),
      height: MediaQuery.of(context).size.height,
      width: double.maxFinite,
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chat',
                    style: SolhTextStyles.AppBarText,
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: SolhColors.greyS200, shape: BoxShape.circle),
                    child: IconButton(
                        onPressed: () {
                          isBottomSheetOpened = false;
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close)),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: widget.type != null
                ? MessageListProvider(sId: sId ?? '')
                : MessageList(
                    sId: sId ?? '',
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
            child: widget.type != null
                ? MessageBoxProvider(sId: sId ?? '')
                : MessageBox(
                    sId: sId ?? '',
                    chatType: widget.type,
                  ),
          ),
        ],
      ),
    );
  }
}
