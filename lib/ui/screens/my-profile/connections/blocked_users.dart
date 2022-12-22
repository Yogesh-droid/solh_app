import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/model/blocked_user_model.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';

import '../../../../widgets_constants/constants/colors.dart';

class BlockedUsers extends StatefulWidget {
  const BlockedUsers({Key? key}) : super(key: key);

  @override
  State<BlockedUsers> createState() => _BlockedUsersState();
}

class _BlockedUsersState extends State<BlockedUsers> {
  ConnectionController connectionController = Get.find();

  @override
  void initState() {
    if (connectionController.blockedUsers.value.blockedUsers == null) {
      connectionController.getPeopleBlocked();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          'Blocked Users',
          style: SolhTextStyles.QS_body_1_bold,
        ),
        isLandingScreen: false,
      ),
      body: Column(
        children: [
          Text(
            "Users you've blocked are listed below; tap any of them to unblock them.",
            style: SolhTextStyles.QS_cap_semi,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: Obx(() => connectionController.isGettingBlockedUsers.value
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: connectionController
                        .blockedUsers.value.blockedUsers!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          tileColor: SolhColors.light_Bg,
                          leading: SizedBox(
                            width: 50,
                            child: SimpleImageContainer(
                                imageUrl: connectionController
                                        .blockedUsers
                                        .value
                                        .blockedUsers![index]
                                        .blockedUser!
                                        .profilePicture ??
                                    '',
                                boxFit: BoxFit.fill,
                                radius: 50),
                          ),
                          title: Text(
                            connectionController.blockedUsers.value
                                    .blockedUsers![index].blockedUser!.name ??
                                '',
                            overflow: TextOverflow.ellipsis,
                            style: SolhTextStyles.QS_body_semi_1,
                          ),
                          onTap: () {
                            openBottomSheet(
                                user: connectionController.blockedUsers.value
                                    .blockedUsers![index].blockedUser!);
                          },
                        ),
                      );
                    },
                  )),
          ),
        ],
      ),
    );
  }

  void openBottomSheet({required BlockedUser user}) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) => Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Unblock',
                    style: SolhTextStyles.QS_body_1_bold,
                  ),
                  Divider(),
                  ListTile(
                    leading: SizedBox(
                      width: 50,
                      child: SimpleImageContainer(
                          imageUrl: user.profilePicture ?? '',
                          boxFit: BoxFit.fill,
                          radius: 50),
                    ),
                    title: Text(
                      user.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: SolhTextStyles.QS_body_semi_1,
                    ),
                  ),
                ],
              ),
            ));
  }
}
