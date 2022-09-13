import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../get-help.dart';

class ViewAllVolunteers extends StatelessWidget {
  ViewAllVolunteers({Key? key}) : super(key: key);
  final ConnectionController connectionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return !connectionController.isRecommnedationLoading.value
        ? connectionController.peopleYouMayKnow.value.reccomendation != null &&
                connectionController
                    .peopleYouMayKnow.value.reccomendation!.isNotEmpty
            ? SingleChildScrollView(
                child: getVolunteersGrid(),
              )
            : Container()
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  getAppBar() {
    return SolhAppBar(
      isLandingScreen: false,
      title: Text(
        "Solh Mates",
        style: SolhTextStyles.AppBarText,
      ),
    );
  }

  getVolunteersGrid() {
    return Obx(() {
      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 1.h, right: 1.h),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount:
            connectionController.peopleYouMayKnow.value.reccomendation!.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: SolhVolunteers(
            bio: connectionController.peopleYouMayKnow.value.reccomendation!
                .elementAt(index)
                .bio,
            name: connectionController.peopleYouMayKnow.value.reccomendation!
                .elementAt(index)
                .name,
            mobile: '',
            imgUrl: connectionController.peopleYouMayKnow.value.reccomendation!
                .elementAt(index)
                .profilePicture,
            sId: connectionController.peopleYouMayKnow.value.reccomendation!
                .elementAt(index)
                .sId,
            uid: connectionController.peopleYouMayKnow.value.reccomendation!
                .elementAt(index)
                .uid,
            comments: connectionController
                .peopleYouMayKnow.value.reccomendation!
                .elementAt(index)
                .commentCount
                .toString(),
            connections: connectionController
                .peopleYouMayKnow.value.reccomendation!
                .elementAt(index)
                .connectionsCount
                .toString(),
            likes: connectionController.peopleYouMayKnow.value.reccomendation!
                .elementAt(index)
                .likesCount
                .toString(),
            userType: null,
          ),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1 / 1.5),
      );
    });
  }
}
