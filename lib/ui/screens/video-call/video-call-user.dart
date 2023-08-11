import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:solh/controllers/chat-list/chat_list_controller.dart';
import 'package:solh/ui/screens/chat/chat.dart';
import 'package:solh/ui/screens/chat/chat_controller/chat_controller.dart';
import 'package:solh/ui/screens/chat/chat_provider.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../bloc/user-bloc.dart';
import '../chat/chat_services/chat_socket_service.dart';

class VideoCallUser extends StatefulWidget {
  String appId = "4db2d5eea0c3466cb8dc7ba7f488dbef";
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
  List _remoteUidList = [];
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
    _engine.leaveChannel(
        options: LeaveChannelOptions(
            stopAllEffect: true,
            stopAudioMixing: true,
            stopMicrophoneRecording: true));
    _engine.release();
  }

  @override
  void initState() {
    log('callType ${widget.type}');
    log(widget.appId);
    log(widget.channel);
    log('call token  ${widget.token}');
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      SocketService.currentSId = widget.sId ?? '';
      _controller.currentSid = widget.sId ?? '';
      timer = Timer(Duration(seconds: 20), () {
        if (_remoteUid == null) {
          _engine.leaveChannel();
          _engine.release();
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
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: "4db2d5eea0c3466cb8dc7ba7f488dbef",
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
            _remoteUidList.add(remoteUid);
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          setState(() {
            _remoteUidList.remove(remoteUid);
          });
          if (_remoteUidList.length == 0) {
            Navigator.of(context).pop();
          }
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine
        .joinChannel(
          token: widget.token,
          channelId: widget.channel,
          uid: 0,
          options: const ChannelMediaOptions(),
        )
        .onError((error, stackTrace) => {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: SolhAppBar(
          isLandingScreen: false,
          title: Text(
            'Video Call',
            style: SolhTextStyles.QS_body_1_bold,
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
        body: getVideocallPage(),
      ),
    );
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      if (_remoteUidList.length == 1) {
        return AgoraVideoView(
            controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(
              uid: _remoteUidList[0], renderMode: RenderModeType.renderModeFit),
          connection: RtcConnection(channelId: widget.channel),
        ));
      }
      return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 4,
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0),
          itemCount: _remoteUidList.length,
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            return AgoraVideoView(
                controller: VideoViewController.remote(
              useAndroidSurfaceView: Platform.isAndroid,
              rtcEngine: _engine,
              canvas: VideoCanvas(
                  uid: _remoteUidList[index],
                  mirrorMode: VideoMirrorModeType.videoMirrorModeAuto,
                  enableAlphaMask: true,
                  view: 1,
                  renderMode: RenderModeType.renderModeFit),
              connection: RtcConnection(channelId: widget.channel),
            ));
          }));
    } else {
      return ButtonLoadingAnimation(
        ballColor: Colors.white,
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
                  ? AgoraVideoView(
                      controller: VideoViewController(
                      rtcEngine: _engine,
                      canvas: const VideoCanvas(uid: 0),
                    ))
                  : CircularProgressIndicator(),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
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
                    color: muted ? Colors.white : SolhColors.primary_green,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: muted ? SolhColors.primary_green : Colors.white,
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
                    color: _isVideoDisabled
                        ? Colors.white
                        : SolhColors.primary_green,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: _isVideoDisabled
                      ? SolhColors.primary_green
                      : Colors.white,
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
              Container(
                width: 50,
                child: RawMaterialButton(
                  onPressed: () {
                    _engine.leaveChannel();
                    _engine.release();
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
                    CupertinoIcons.switch_camera_solid,
                    color: SolhColors.primary_green,
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
                    color: SolhColors.primary_green,
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
            child: widget.type != null && widget.type == 'sc'
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
            child: widget.type != null && widget.type == 'sc'
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
