import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/ui/screens/notification/controller/notification_controller.dart';
import 'package:solh/ui/screens/notification/model/notification_model.dart';
import 'package:solh/widgets_constants/animated_refresh_container.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/image_container.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../routes/routes.dart';
import '../comment/comment-screen.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var notificaltionColtroller = Get.put(NotificationController());
  final JournalPageController journalPageController = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => notificaltionColtroller
        .getNoificationController(Get.find<ProfileController>()
                .myProfileModel
                .value
                .body!
                .user!
                .sId ??
            ''));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff6f6f8),
        appBar: SolhAppBar(
          isLandingScreen: false,
          isNotificationPage: true,
          title: Text(
            'Notification'.tr,
            style: GoogleFonts.signika(
              color: SolhColors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                return notificaltionColtroller.shouldRefresh.value
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedRefreshContainer(),
                        ],
                      )
                    : Container();
              }),
              Obx(() {
                //if notification is loading show circularProgressIndicator
                //if loaded notification is empty show column else show notification tile
                return notificaltionColtroller.isNotificationListLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : (notificaltionColtroller.notificationModel.length == 0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.notifications,
                                    size: 40,
                                    color: Colors.grey.shade300,
                                  ),
                                  Text(
                                    'No notifications',
                                    style: GoogleFonts.signika(
                                      fontSize: 25,
                                      color: Colors.grey.shade300,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(top: 8),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              height: 8,
                            ),
                            itemCount: notificaltionColtroller
                                .notificationModel.length,
                            itemBuilder: ((context, index) {
                              print(notificaltionColtroller
                                  .notificationModel.length);
                              return Container(
                                decoration: BoxDecoration(
                                    color: notificaltionColtroller
                                                .notificationModel[index]
                                                .seenStatus ==
                                            "read"
                                        ? Colors.grey.shade100
                                        : Colors.white,
                                    border: Border.all(
                                        color: Color(
                                          0xffefefef,
                                        ),
                                        width: 1),
                                    borderRadius: BorderRadius.circular(8)),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    getNotificationTile(notificaltionColtroller
                                        .notificationModel[index]),
                                  ],
                                ),
                              );
                            }),
                          ));
              }),
            ],
          ),
        ));
  }

  Widget getNotificationTile(NotificationList item) {
    if (item.routeData == 'journal') {
      return InkWell(
        onTap: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CommentScreen(
                  journalModel: Journals(id: item.routeContent ?? ''),
                  index: -1)));
          if (!(item.seenStatus == "read")) {
            notificaltionColtroller.updateStatus(item.sId!);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: SolhColors.white,
                backgroundImage: NetworkImage(item.senderId!.profilePicture!),
                radius: 30,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        Text(item.content ?? ''),
                      ],
                    ),
                    Text(
                      timeago.format(DateTime.parse(item.createdAt!)),
                      style: GoogleFonts.signika(
                        color: Color(0xff666666),
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    if (item.routeData == 'announcement') {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: SolhColors.white,
              backgroundImage: NetworkImage(item.senderId != null
                  ? item.senderId!.profilePicture!
                  : "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y"),
              radius: 30,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    children: [
                      Text(item.content ?? ''),
                    ],
                  ),
                  Text(
                    timeago.format(DateTime.parse(item.createdAt!)),
                    style: GoogleFonts.signika(
                      color: Color(0xff666666),
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }
    if (item.routeData == 'connection') {
      return InkWell(
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.connectScreen, arguments: {
            "uid": item.senderId!.id ?? '',
            "sId": item.senderId!.sId ?? ''
          });
          if (!(item.seenStatus == "read")) {
            notificaltionColtroller.updateStatus(item.sId!);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              SimpleImageContainer(
                imageUrl: item.senderId!.profilePicture!,
                radius: 60,
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        Text(item.content ?? ''),
                      ],
                    ),
                    Text(
                      timeago.format(DateTime.parse(item.createdAt!)),
                      style: GoogleFonts.signika(
                        color: Color(0xff666666),
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
