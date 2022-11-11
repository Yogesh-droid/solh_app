import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/ui/screens/connect/connect_screen_controller/connect_screen_controller.dart';
import 'package:solh/ui/screens/journaling/side_drawer.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class ConnectScreen2 extends StatefulWidget {
  ConnectScreen2({
    Key? key,
    required Map<dynamic, dynamic>? args,
  })  : sId = args!['sId'],
        super(key: key);

  final String sId;

  @override
  State<ConnectScreen2> createState() => _ConnectScreen2State();
}

class _ConnectScreen2State extends State<ConnectScreen2> {
  ConnectScreenController connectScreenController =
      Get.put(ConnectScreenController());

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  void loadData() {
    connectScreenController
        .getProfileDetailsController(widget.sId)
        .then((value) => initFunctions());
  }

  initFunctions() {
    connectScreenController.checkIfAlreadyInRecivedConnection(widget.sId);
    connectScreenController.checkIfAlreadyInSendConnection(widget.sId);
    connectScreenController.isMyConnectionController(userBlocNetwork.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text('Connect', style: SolhTextStyles.AppBarText),
      ),
      body: Obx(() {
        return connectScreenController.isConnectScreenDataLoading.value
            ? MyLoader()
            : ListView(children: [
                SizedBox(
                  height: 5.h,
                ),
                SimpleImageContainer(
                  imageUrl: connectScreenController
                          .connectScreenModel.value.user!.profilePicture ??
                      '',
                  enableborder: true,
                  radius: 15.h,
                ),
                SizedBox(
                  height: 2.h,
                ),
                GetNaameBadgeAndBio(
                  name: connectScreenController
                          .connectScreenModel.value.user!.name ??
                      '',
                  bio: connectScreenController
                          .connectScreenModel.value.user!.bio ??
                      '',
                  userType: connectScreenController
                          .connectScreenModel.value.user!.userType ??
                      '',
                ),
                SizedBox(
                  height: 5.h,
                ),
                GetProfileStats(
                    connections: connectScreenController
                        .connectScreenModel.value.user!.connectionsList!.length,
                    like: connectScreenController
                        .connectScreenModel.value.journalLikeCount),
                GetMessageButton(
                    isMyConnection:
                        connectScreenController.isMyConnection.value),
                GetConnectJoinUnfriendButton(
                    connectScreenController: connectScreenController),
              ]);
      }),
    ));
  }
}

class GetNaameBadgeAndBio extends StatelessWidget {
  const GetNaameBadgeAndBio({
    Key? key,
    required this.name,
    this.bio,
    required this.userType,
  }) : super(key: key);

  final String name;
  final String? bio;
  final String userType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: SolhTextStyles.LargeNameText,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [getBadge(userType)],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 80.w,
          child: Text(
            bio ?? '',
            style: SolhTextStyles.UniversalText,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class GetProfileStats extends StatelessWidget {
  const GetProfileStats(
      {Key? key, required this.like, required this.connections})
      : super(key: key);

  final like;
  final connections;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.thumb_up,
                    color: SolhColors.green,
                    size: 16,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    like.toString(),
                    style: SolhTextStyles.ToggleLinkText,
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Likes',
                style: SolhTextStyles.LandingParaText,
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/images/connect.svg'),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    connections.toString(),
                    style: SolhTextStyles.ToggleLinkText,
                  )
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'Connections',
                style: SolhTextStyles.LandingParaText,
              ),
            ],
          ),
          // Column(
          //   children: [
          //     Row(
          //       children: [
          //         Icon(
          //           Icons.thumb_up,
          //           color: SolhColors.green,
          //         ),
          //         SizedBox(
          //           width: 5,
          //         ),
          //         Text(
          //           '27',
          //           style: SolhTextStyles.ToggleLinkText,
          //         )
          //       ],
          //     ),
          //     Text(
          //       'Likes',
          //       style: SolhTextStyles.LandingParaText,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class GetMessageButton extends StatelessWidget {
  GetMessageButton({Key? key, required this.isMyConnection}) : super(key: key);
  final bool isMyConnection;
  final ConnectScreenController connectScreenController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        isMyConnection
            ? SolhGreenButton(
                width: 70.w,
                child: Text(
                  'Message',
                  style: SolhTextStyles.GreenButtonText,
                ),
              )
            : ((connectScreenController.isInRecivedRequest == false &&
                    connectScreenController.isInSentRequest == false)
                ? Column(
                    children: [
                      SolhGreenButton(
                        width: 70.w,
                        child: Text(
                          'Connect',
                          style: SolhTextStyles.GreenButtonText,
                        ),
                      ),
                    ],
                  )
                : Container()),
      ],
    );
  }
}

class GetConnectJoinUnfriendButton extends StatelessWidget {
  GetConnectJoinUnfriendButton({
    Key? key,
    required this.connectScreenController,
  }) : super(key: key);

  ConnectScreenController connectScreenController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        getUnfriendAcceptPendingButton(connectScreenController),
      ],
    );
  }
}

Widget getBadge(String userType) {
  switch (userType) {
    case 'SolhVolunteer':
      return GetBadge(userType: 'SolhVolunteer');
    case 'SolhProvider':
      return GetBadge(userType: 'SolhProvider');
    default:
      return Container();
  }
}

Widget getUnfriendAcceptPendingButton(
    ConnectScreenController connectScreenController) {
  if (connectScreenController.isMyConnection.value) {
    return SolhGreenBorderButton(
        width: 70.w,
        child: Text(
          'Unfriend',
          style: SolhTextStyles.GreenBorderButtonText,
        ));
  }
  if (connectScreenController.isInSentRequest.value) {
    return SolhGreenBorderButton(
        width: 70.w,
        child: Text(
          'Cancle',
          style: SolhTextStyles.GreenBorderButtonText,
        ));
  }

  if (connectScreenController.isInRecivedRequest.value) {
    return SolhGreenBorderButton(
        width: 70.w,
        child: Text(
          'Accept',
          style: SolhTextStyles.GreenBorderButtonText,
        ));
  } else {
    return Container();
  }
}
