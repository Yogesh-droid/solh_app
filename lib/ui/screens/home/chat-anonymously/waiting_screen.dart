import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/home/chat-anonymously/chat-anon-controller/chat_anon_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({super.key});

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  ChatAnonController chatAnonController = Get.put(ChatAnonController());
  @override
  void initState() {
    // TODO: implement initState
    chatAnonController.getVolunteerController().then((value) =>
        globalNavigatorKey.currentState!
            .pushNamed(AppRoutes.chatUser, arguments: {
          "imageUrl": chatAnonController
              .chatAnonModel.value.sosChatSupport!.first.profilePicture,
          "name":
              chatAnonController.chatAnonModel.value.sosChatSupport!.first.name,
          "sId":
              chatAnonController.chatAnonModel.value.sosChatSupport!.first.sId,
          "isAnonChat": true
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyLoader(),
          Text("Searching for a counselor".tr,
              style: SolhTextStyles.CTA.copyWith(
                color: SolhColors.white,
              ))
        ],
      )),
    );
  }
}
