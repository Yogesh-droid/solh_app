import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';

class LiveStreamWaiting extends StatefulWidget {
  const LiveStreamWaiting({super.key});

  @override
  State<LiveStreamWaiting> createState() => _LiveStreamWaitingState();
}

class _LiveStreamWaitingState extends State<LiveStreamWaiting> {
  @override
  void initState() {
    // TODO: implement initState
    getStreamData();
    super.initState();
  }

  getStreamData() async {
    var response = await Network.makeGetRequestWithToken(
        "${APIConstants.api}/api/agora/get-webinars");

    if (response['success']) {
      globalNavigatorKey.currentState!
          .pushNamed(AppRoutes.liveStream, arguments: {
        'appId': response['webinar']['APP_ID'],
        'title': response['webinar']['title'],
        'channelName': response['webinar']['channelName'],
        'token': response['webinar']['token'],
        'isBroadcaster': true
      });
    } else {
      globalNavigatorKey.currentState!.pop();
      SolhSnackbar.error("Opps!", "SomeThing went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyLoader(),
          SizedBox(
            height: 4.h,
          ),
          Text(
            "Wait , Going Live ...",
            style:
                SolhTextStyles.QS_body_2_bold.copyWith(color: SolhColors.white),
          )
        ],
      )),
    );
  }
}
