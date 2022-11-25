import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/model/my_connection_model.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../../../controllers/group/create_group_controller.dart';

class InviteMembersUI extends StatelessWidget {
  InviteMembersUI({
    Key? key,
    required Map<dynamic, dynamic>? args,
  })  : groupId = args!['groupId'],
        super(key: key);
  final String groupId;
  final CreateGroupController controller = Get.find();
  final ConnectionController connectionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 18.0, right: 18.0, top: 18.0, bottom: 60.0),
          child:
              connectionController.myConnectionModel.value.myConnections != null
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: connectionController
                          .myConnectionModel.value.myConnections!.length,
                      itemBuilder: (context, index) {
                        return getMemberTile(
                            context,
                            index,
                            connectionController
                                .myConnectionModel.value.myConnections![index]);
                      })
                  : Container(),
        ),
      ),
      floatingActionButton: getSendButton(context),
    );
  }

  SolhAppBar getAppBar(BuildContext context) {
    return SolhAppBar(
      isLandingScreen: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Invite Members', style: SolhTextStyles.JournalingUsernameText),
          MaterialButton(
              onPressed: () {
                //AutoRouter.of(context).popUntil(((route) => route.isFirst));
                Navigator.popUntil(context,
                    (route) => route.settings.name == AppRoutes.master);
              },
              child: Text(
                'Skip',
                style: SolhTextStyles.GreenBorderButtonText,
              ))
        ],
      ),
    );
  }

  Widget getMemberTile(
      BuildContext context, int index, MyConnections myConnections) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text(connectionController
              .myConnectionModel.value.myConnections![index].name ??
          ''),
      subtitle: Text(
        connectionController
                .myConnectionModel.value.myConnections![index].bio ??
            '',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        if (controller.selectedMembers.contains(myConnections.sId)) {
          controller.selectedMembers.remove(myConnections.sId);
        } else {
          controller.selectedMembers.add(myConnections.sId);
        }
        controller.selectedMembersIndex.contains(index)
            ? controller.selectedMembersIndex.remove(index)
            : controller.selectedMembersIndex.add(index);
        controller.selectedMembersIndex.refresh();
      },
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(
          connectionController.myConnectionModel.value.myConnections![index]
                  .profilePicture ??
              '',
        ),
      ),
      trailing: Container(
          width: 20,
          child: Obx(() {
            return controller.selectedMembersIndex.contains(index)
                ? Icon(
                    Icons.check_circle,
                    color: SolhColors.green,
                  )
                : Container();
          })),
    );
  }

  Widget getSendButton(BuildContext context) {
    return Obx(() {
      return FloatingActionButton.extended(
        elevation: 0,
        onPressed: () async {
          await controller
              .addMembers(
            groupId: groupId,
          )
              .then((value) {
            Utility.showToast('Invitation sent successfully');
          });
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoutes.master, (route) => false);
        },
        label: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Center(
            child: Text(
              'Send Invite',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        backgroundColor: controller.selectedMembersIndex.isEmpty
            ? SolhColors.grey
            : SolhColors.green,
      );
    });
  }
}
