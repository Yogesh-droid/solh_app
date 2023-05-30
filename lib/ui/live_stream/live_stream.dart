import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';

import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/live_stream/live-stream-controller.dart/live_stream_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class LiveStream extends StatefulWidget {
  LiveStream({super.key, required Map<dynamic, dynamic> args})
      : appId = args['appId'],
        title = args['title'],
        channelName = args['channelName'],
        token = args['token'],
        isBroadcaster = args['isBroadcaster'];

  final bool isBroadcaster;
  final String title;
  final String channelName;
  final String token;
  final String appId;
  @override
  State<LiveStream> createState() => _LiveStreamState();
}

class _LiveStreamState extends State<LiveStream> {
  final _users = <int>[];
  final _infoStrings = <String>[];
  RtcEngine? _engine;

  LiveStreamController _liveStreamController = Get.find();

  ValueNotifier<bool> isDialOpen = ValueNotifier(true);

  List<Map<int, Widget>> viewWidgets = [];

  String? channel;
  bool _localUserJoined = false;

  @override
  void dispose() {
    // clear users
    _users.clear();
    // destroy sdk and leave channel
    _engine!.leaveChannel();
    _engine!.destroy();
    _liveStreamController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // initialize agora sdk
    log({
      'appId': widget.appId,
      'title': widget.title,
      'channelName': widget.channelName,
      'token': widget.token,
      'isBroadcaster': widget.isBroadcaster
    }.toString());
    initialize();
  }

  Future<void> initialize() async {
    print('Client Role: ${widget.isBroadcaster}');
    if (widget.appId == null) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    try {
      await _engine!.joinChannel(widget.token, widget.channelName, null, 0);
    } on PlatformException {
      _users.clear();
      // destroy sdk and leave channel
      _engine!.leaveChannel();
      _engine!.destroy();

      initialize();
    }
  }

  Future<void> _initAgoraRtcEngine() async {
    await [Permission.microphone, Permission.camera].request();
    _engine = await RtcEngine.create(widget.appId);
    await _engine!.enableVideo();

    await _engine!.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.isBroadcaster) {
      await _engine!.setClientRole(ClientRole.Broadcaster);
    } else {
      await _engine!.setClientRole(ClientRole.Audience);
    }
  }

  void _addAgoraEventHandlers() {
    _engine!.setEventHandler(RtcEngineEventHandler(
      error: (code) {
        setState(() {
          final info = 'onError: $code';
          // _infoStrings.add(info);
          log(info.toString());
        });
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        setState(() {
          _users.add(uid);
          setState(() {
            _localUserJoined = true;
            if (widget.isBroadcaster) {
              viewWidgets.add({
                uid: RtcLocalView.SurfaceView(
                  mirrorMode: VideoMirrorMode.Disabled,
                  renderMode: VideoRenderMode.Hidden,
                  channelId: widget.channelName,
                )
              });
            }
          });
          log(uid.toString(), name: "uId");
        });
      },
      leaveChannel: (stats) {
        setState(() {
          log("user left");
          _users.clear();
        });
      },
      userJoined: (uid, elapsed) {
        setState(() {
          final info = 'userJoined: $uid';
          // _infoStrings.add(info);
          _users.add(uid);
          viewWidgets.add({
            uid: RtcRemoteView.SurfaceView(
              mirrorMode: VideoMirrorMode.Enabled,
              renderMode: VideoRenderMode.Hidden,
              uid: uid,
              channelId: widget.channelName,
            )
          });
          setState(() {});
          log(uid.toString(),name: 'uid');
        });
      },
      userOffline: (uid, elapsed) {
        log("user left 2");
        setState(() {
          final info = 'userOffline: $uid';
          viewWidgets.removeWhere((element) => uid == element.keys.first);
        });
      },
    ));
  }

  Widget _remoteVideo() {
    if (_infoStrings != null) {
      if (viewWidgets.length == 1) {
        print(_infoStrings.toString() + "_infoString");
        return RtcLocalView.SurfaceView(
          mirrorMode: VideoMirrorMode.Enabled,
          renderMode: VideoRenderMode.Fit,
          channelId: widget.channelName,
        );
      }

      if (viewWidgets.length == 2) {
        return SizedBox(
          // height: 700,
          // width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: viewWidgets
                .map((e) => Expanded(child: e.values.first))
                .toList(),
          ),
        );
      }
      return Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 4,
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: viewWidgets.length,
          shrinkWrap: true,
          itemBuilder: ((context, index) {
            return viewWidgets[index].values.first;
          }),
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  List<SpeedDialChild> getSpeedDialChildern() {
    return [
      SpeedDialChild(
        backgroundColor: Colors.red,
        onTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.phone,
          color: SolhColors.white,
        ),
      ),
      SpeedDialChild(
        onTap: () {
          _engine!.switchCamera();
        },
        backgroundColor: SolhColors.white,
        child: Icon(
          CupertinoIcons.switch_camera,
          color: SolhColors.primary_green,
        ),
      ),
      SpeedDialChild(
        onTap: () {
          if (_liveStreamController.isMuted.value) {
            _engine!.muteLocalAudioStream(!_liveStreamController.isMuted.value);
            _liveStreamController.isMuted.value = false;
          } else {
            _engine!.muteLocalAudioStream(!_liveStreamController.isMuted.value);
            _liveStreamController.isMuted.value = true;
          }
          // setState(() {});
        },
        backgroundColor: SolhColors.white,
        child: Obx(() {
          return _liveStreamController.isMuted.value
              ? Icon(
                  CupertinoIcons.mic_fill,
                  color: SolhColors.primary_green,
                )
              : Icon(
                  CupertinoIcons.mic_slash_fill,
                  color: SolhColors.primary_green,
                );
        }),
      ),
      SpeedDialChild(
        onTap: () {
          // _engine!.muteLocalVideoStream(true);

          log(_liveStreamController.isCameraOff.value.toString());
          if (_liveStreamController.isCameraOff.value) {
            _engine!
                .muteLocalVideoStream(!_liveStreamController.isCameraOff.value);
            _liveStreamController.isCameraOff.value = false;
          } else {
            _engine!
                .muteLocalVideoStream(!_liveStreamController.isCameraOff.value);
            _liveStreamController.isCameraOff.value = true;
          }

          log(_liveStreamController.isCameraOff.value.toString());
        },
        backgroundColor: SolhColors.white,
        child: Obx(
          () {
            log(_liveStreamController.isCameraOff.value.toString(),
                name: "obx");
            return _liveStreamController.isCameraOff.value
                ? SvgPicture.asset(
                    'assets/images/camera_on.svg',
                  )
                : SvgPicture.asset(
                    'assets/images/camera_off.svg',
                  );
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context);
      },
      child: SafeArea(
          child: Scaffold(
        floatingActionButton: SpeedDial(
          // direction: SpeedDialDirection.down,
          childPadding: EdgeInsets.all(10),
          buttonSize: Size(45, 45),
          openCloseDial: isDialOpen,
          closeDialOnPop: false,
          closeManually: true,
          icon: CupertinoIcons.ellipsis_vertical,
          activeIcon: CupertinoIcons.clear,
          overlayOpacity: 0,
          children: getSpeedDialChildern(),
        ),
        backgroundColor: Colors.grey.shade900,
        body: Stack(
          children: [
            _remoteVideo(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black54,
                      Colors.black38,
                      Colors.black12,
                      Colors.transparent
                    ]),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(
                              widget.title,
                              style: SolhTextStyles.QS_body_1_bold.copyWith(
                                color: SolhColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

_onWillPop(context) async {
  return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actionsPadding: EdgeInsets.all(8.0),
          content: Text(
            'Do you really want to exit this screen?'.tr,
            style: SolhTextStyles.JournalingDescriptionText,
          ),
          actions: [
            InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Yes'.tr,
                    style: SolhTextStyles.CTA
                        .copyWith(color: SolhColors.primaryRed),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }),
            SizedBox(width: 30),
            InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'No'.tr,
                    style: SolhTextStyles.CTA
                        .copyWith(color: SolhColors.primary_green),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop(false);
                }),
          ],
        );
      });
}
