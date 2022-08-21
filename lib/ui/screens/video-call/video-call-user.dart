/* import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class VideoCallUser extends StatefulWidget {
  VideoCallUser({Key? key}) : super(key: key);

  @override
  State<VideoCallUser> createState() => _VideoCallUserState();
}

class _VideoCallUserState extends State<VideoCallUser> {
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();

  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  @override
  void initState() {
    // TODO: implement initState
    _localRenderer.initialize();
    _remoteRenderer.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black,
        body: Container(
          child: Stack(children: [
            RTCVideoView(_remoteRenderer),
            Positioned(
              right: 20,
              top: 27,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 100,
                    width: 70,
                    child: RTCVideoView(
                      _localRenderer,
                      mirror: true,
                    ),
                  ),
                  Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child:
                          SvgPicture.asset('assets/images/camera_change.svg')),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: 100.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('assets/images/call_disconnect.svg'),
                    InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return OptionModalSheet();
                              });
                        },
                        child: SvgPicture.asset('assets/images/call_menu.svg')),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 10,
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: SvgPicture.asset('assets/images/videocall_back.svg'),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class OptionModalSheet extends StatelessWidget {
  const OptionModalSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11.5),
          child: Text(
            'Options',
            style: GoogleFonts.signika(
              fontSize: 16,
            ),
          ),
        ),
        Divider(
          thickness: 1.5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/images/mic_icon.svg'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Audio',
                  ),
                ],
              ),
              Icon(
                Icons.done,
                color: SolhColors.green,
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/images/camera_icon.svg'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Video',
                  ),
                ],
              ),
              Icon(
                Icons.done,
                color: SolhColors.green,
              )
            ],
          ),
        )
      ]),
    );
  }
} */
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class VideoCallUser extends StatefulWidget {
  var appId = "4db2d5eea0c3466cb8dc7ba7f488dbef";
  var token =
      "0064db2d5eea0c3466cb8dc7ba7f488dbefIABV0AhZlwohqekpkdqXNpk8FlEVw5u5FwIFWzdr/3U1DMJBJDUh39v0IgAi1l/HOrwBYwQAAQDKeABjAgDKeABjAwDKeABjBADKeABj";
  var channel = "abc";

  VideoCallUser({required this.token, required this.channel});

  @override
  State<VideoCallUser> createState() => _CallState();
}

class _CallState extends State<VideoCallUser> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  bool muted = false;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> _dispose() async {
    // destroy sdk
    await _engine.leaveChannel();
    await _engine.destroy();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = await RtcEngine.create(widget.appId);
    await _engine.enableVideo();
    _engine.setEventHandler(
      RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
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
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
    await _engine.joinChannel(widget.token, widget.channel, null, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
          isLandingScreen: false,
          title: Text(
            'Video Call',
            style: SolhTextStyles.AppBarText,
          )),
      body: Stack(
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () {
                    _engine.muteLocalAudioStream(muted);
                  },
                  child: Icon(
                    muted ? Icons.mic_off : Icons.mic,
                    color: muted ? Colors.white : Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: muted ? Colors.blueAccent : Colors.white,
                  padding: const EdgeInsets.all(12.0),
                ),
                RawMaterialButton(
                  onPressed: () => _engine.leaveChannel(),
                  child: Icon(
                    Icons.call_end,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.redAccent,
                  padding: const EdgeInsets.all(15.0),
                ),
                RawMaterialButton(
                  onPressed: () => _engine.switchCamera(),
                  child: Icon(
                    Icons.switch_camera,
                    color: Colors.blueAccent,
                    size: 20.0,
                  ),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  fillColor: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                )
              ],
            ),
          )
        ],
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
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
