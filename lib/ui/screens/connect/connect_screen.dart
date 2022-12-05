import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/journals/journal_comment_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/connect/connect_screen_controller/connect_screen_controller.dart';
import 'package:solh/ui/screens/journaling/side_drawer.dart';
import 'package:solh/ui/screens/my-profile/profile/edit-profile.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
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
        userName = args['userName'],
        super(key: key);

  final String? sId;
  final String? userName;

  @override
  State<ConnectScreen2> createState() => _ConnectScreen2State();
}

class _ConnectScreen2State extends State<ConnectScreen2> {
  ConnectScreenController connectScreenController =
      Get.put(ConnectScreenController());
  ConnectionController connectionController = Get.find();
  JournalCommentController journalCommentController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => loadData());
    super.initState();
  }

  void loadData() {
    if (widget.userName != null) {
      connectScreenController
          .getProfileDetailsFromUserNameController(widget.userName!)
          .then((value) => initfuntionsUserName());
    } else {
      connectScreenController
          .getProfileDetailsController(widget.sId!)
          .then((value) => initFunctions());
    }
  }

  initfuntionsUserName() {
    connectScreenController.checkIfAlreadyInRecivedConnection(
        connectScreenController.connectScreenModel.value.user!.sId!);
    connectScreenController.checkIfAlreadyInSendConnection(
        connectScreenController.connectScreenModel.value.user!.sId!);
    connectScreenController.isMyConnectionController(userBlocNetwork.id);
  }

  initFunctions() {
    connectScreenController.checkIfAlreadyInRecivedConnection(widget.sId!);
    connectScreenController.checkIfAlreadyInSendConnection(widget.sId!);
    connectScreenController.isMyConnectionController(userBlocNetwork.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text('Connect', style: SolhTextStyles.AppBarText),
        menuButton: getpopUpMenu(
            context,
            widget.sId ??
                connectScreenController.connectScreenModel.value.user!.sId!,
            journalCommentController),
      ),
      body: Obx(() {
        return connectScreenController.connectScreenModel.value.user == null
            ? Center(
                child: MyLoader(),
              )
            : (connectScreenController.isConnectScreenDataLoading.value ||
                    connectScreenController
                            .connectScreenModel.value.user!.sId ==
                        null)
                ? MyLoader()
                : ListView(
                    children: [
                      SizedBox(
                        height: 5.h,
                      ),
                      SimpleImageContainer(
                        imageUrl: connectScreenController.connectScreenModel
                                .value.user!.profilePicture ??
                            '',
                        enableborder: true,
                        radius: 15.h,
                        zoomEnabled: true,
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
                              .connectScreenModel
                              .value
                              .user!
                              .connectionsList!
                              .length,
                          like: connectScreenController
                              .connectScreenModel.value.journalLikeCount),
                      GetMessageButton(
                        isMyConnection:
                            connectScreenController.isMyConnection.value,
                        name: connectScreenController
                                .connectScreenModel.value.user!.name ??
                            '',
                        profilePicture: connectScreenController
                                .connectScreenModel
                                .value
                                .user!
                                .profilePicture ??
                            '',
                        sId: connectScreenController
                                .connectScreenModel.value.user!.sId ??
                            '',
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      GetConnectJoinUnfriendButton(
                          connectScreenController: connectScreenController,
                          sId: widget.sId == null || widget.sId == '123'
                              ? connectScreenController
                                  .connectScreenModel.value.user!.sId!
                              : widget.sId!),
                      SizedBox(
                        height: 3.h,
                      ),
                      GetPostsButton(
                          sId: widget.sId == null || widget.sId == '123'
                              ? connectScreenController
                                  .connectScreenModel.value.user!.sId!
                              : widget.sId!),
                    ],
                  );
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
  GetMessageButton({
    Key? key,
    required this.isMyConnection,
    required this.name,
    required this.profilePicture,
    required this.sId,
  }) : super(key: key);
  final bool isMyConnection;
  final String name;
  final String profilePicture;
  final String sId;
  final ConnectScreenController connectScreenController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Obx(() {
          return connectScreenController.isMyConnection.value
              ? SolhGreenButton(
                  width: 70.w,
                  child: Text(
                    'Message',
                    style: SolhTextStyles.GreenButtonText,
                  ),
                  onPressed: () => Navigator.pushNamed(
                      context, AppRoutes.chatUser,
                      arguments: {
                        "name": name,
                        "imageUrl": profilePicture,
                        "sId": sId,
                      }),
                )
              : Obx(() {
                  return ((connectScreenController.isInRecivedRequest ==
                              false &&
                          connectScreenController.isInSentRequest == false)
                      ? (connectScreenController.sendingConnectionRequest.value
                          ? SolhGreenBorderButton(
                              width: 70.w,
                              child: ButtonLoadingAnimation(
                                ballColor: SolhColors.green,
                                ballSizeLowerBound: 3,
                                ballSizeUpperBound: 8,
                              ),
                            )
                          : Column(
                              children: [
                                SolhGreenButton(
                                  width: 70.w,
                                  child: Text(
                                    'Connect',
                                    style: SolhTextStyles.GreenButtonText,
                                  ),
                                  onPressed: (() => connectScreenController
                                      .sendConnectionRequest(sId)),
                                ),
                              ],
                            ))
                      : Container());
                });
        }),
      ],
    );
  }
}

class GetConnectJoinUnfriendButton extends StatelessWidget {
  GetConnectJoinUnfriendButton({
    Key? key,
    required this.connectScreenController,
    required this.sId,
  }) : super(key: key);

  final ConnectScreenController connectScreenController;
  final String sId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sId == "62e125176a858283a925d15c"
            ? Container()
            : Obx((() {
                return connectScreenController.sendingRequest.value
                    ? SolhGreenBorderButton(
                        width: 70.w,
                        child: ButtonLoadingAnimation(
                          ballColor: SolhColors.green,
                          ballSizeLowerBound: 3,
                          ballSizeUpperBound: 8,
                        ),
                      )
                    : getUnfriendAcceptPendingButton(
                        connectScreenController, sId);
              }))
      ],
    );
  }
}

class GetPostsButton extends StatelessWidget {
  const GetPostsButton({Key? key, required this.sId}) : super(key: key);
  final String sId;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: () => Navigator.pushNamed(context, AppRoutes.userPostScreen,
                arguments: {"sId": sId}),
            child: Text(
              'Posts',
              style: SolhTextStyles.ToggleLinkText,
            )),
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
    ConnectScreenController connectScreenController, String sId) {
  if (connectScreenController.isMyConnection.value) {
    return SolhGreenBorderButton(
      width: 70.w,
      child: Text(
        'Unfriend',
        style: SolhTextStyles.GreenBorderButtonText,
      ),
      onPressed: () => connectScreenController.removeConnection(sId),
    );
  }
  if (connectScreenController.isInSentRequest.value) {
    return SolhGreenBorderButton(
      width: 70.w,
      child: Container(
        child: Text(
          'Cancle',
          style: SolhTextStyles.GreenBorderButtonText,
        ),
      ),
      onPressed: () => connectScreenController.removeConnectionRequest(sId),
    );
  }

  if (connectScreenController.isInRecivedRequest.value) {
    return SolhGreenBorderButton(
      width: 70.w,
      child: Text(
        'Accept',
        style: SolhTextStyles.GreenBorderButtonText,
      ),
      onPressed: () => connectScreenController.acceptConnectionRequest(sId),
    );
  } else {
    return Container();
  }
}

getpopUpMenu(context, String sId, journalCommentController) {
  return PopupMenuButton(
    icon: Icon(
      Icons.more_vert,
      color: SolhColors.black,
    ),
    itemBuilder: (context) {
      return [
        PopupMenuItem(
          child: Text('Report this person'),
          value: 1,
        ),
        // PopupMenuItem(
        //   child: Text('Block'),
        //   value: 2,
        // ),
      ];
    },
    onSelected: (value) {
      if (value == 1) {
        showDialog(
          context: context,
          builder: (context) => ReportUserDialog(context,
              userId: sId, journalCommentController: journalCommentController),
        );
      } else {
        print('Block');
      }
    },
  );
}

ReportUserDialog(BuildContext context,
    {required String userId, required journalCommentController}) {
  TextEditingController reasonController = TextEditingController();
  return Dialog(
    insetPadding: EdgeInsets.zero,
    backgroundColor: Colors.transparent,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width / 20,
        vertical: MediaQuery.of(context).size.height / 80,
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: SolhColors.white,
      ),
      child: Column(children: [
        Align(
            alignment: Alignment.topRight,
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: SolhColors.black,
                ))),
        SizedBox(height: 10),
        Text(
          "We are sorry for your inconvenience due to this post/person. Please let us know what is the problem with this post/person.",
          style: SolhTextStyles.JournalingPostMenuText,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        TextFieldB(
          label: 'Reason',
          maxLine: 4,
          textEditingController: reasonController,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 40,
        ),
        SolhGreenButton(
          child: Obx(() {
            return !journalCommentController.isReportingPost.value
                ? Text(
                    'Report',
                    style: SolhTextStyles.GreenButtonText,
                  )
                : Container(
                    width: 20,
                    height: 20,
                    child: SolhGreenButton(
                      child: ButtonLoadingAnimation(
                        ballSizeLowerBound: 3,
                        ballSizeUpperBound: 8,
                        ballColor: Colors.white,
                      ),
                    ));
          }),
          onPressed: journalCommentController.isReportingPost.value
              ? null
              : () async {
                  await journalCommentController.reportPost(
                      journalId: userId,
                      reason: reasonController.text,
                      type: 'user');
                  Navigator.pop(context);
                },
        ),
      ]),
    ),
  );
}
