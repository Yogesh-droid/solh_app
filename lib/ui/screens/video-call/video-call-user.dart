import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
}
