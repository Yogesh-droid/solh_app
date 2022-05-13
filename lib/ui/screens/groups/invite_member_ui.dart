import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/ui/screens/journaling/journaling.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../controllers/group/create_group_controller.dart';

class InviteMembersUI extends StatelessWidget {
  InviteMembersUI({Key? key}) : super(key: key);
  final CreateGroupController controller = Get.find();
  final ConnectionController connectionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: connectionController
                  .myConnectionModel.value.myConnections!.length,
              itemBuilder: (context, index) {
                return getMemberTile(context, index);
              }),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Journaling();
                }));
              },
              child: Text(
                'Skip',
                style: SolhTextStyles.GreenBorderButtonText,
              ))
        ],
      ),
    );
  }

  Widget getMemberTile(BuildContext context, int index) {
    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text(connectionController
              .myConnectionModel.value.myConnections![index].name ??
          ''),
      subtitle: Text(connectionController
              .myConnectionModel.value.myConnections![index].bio ??
          ''),
      onTap: () {
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
        onPressed: () {},
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
