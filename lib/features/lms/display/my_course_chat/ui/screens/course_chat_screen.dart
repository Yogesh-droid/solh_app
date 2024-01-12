import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/my_course_chat/data/models/course_chat_model.dart';
import 'package:solh/features/lms/display/my_course_chat/ui/controllers/get_course_chat_controller.dart';
import 'package:solh/features/lms/display/my_course_chat/ui/widgets/chat_pointed_container.dart';
import 'package:solh/features/lms/display/my_course_chat/ui/widgets/chat_text_field.dart';
import 'package:solh/features/lms/display/my_course_chat/ui/widgets/text_chat_card.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../../../../../../widgets_constants/constants/colors.dart';
import '../controllers/send_course_msg_controller.dart';

class CourseChatScreen extends StatefulWidget {
  const CourseChatScreen({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  State<CourseChatScreen> createState() => _CourseChatScreenState();
}

class _CourseChatScreenState extends State<CourseChatScreen> {
  late ScrollController scrollController;

  int pageNo = 1;

  final GetCourseChatController getCourseChatController = Get.find();
  final TextEditingController textEditingController = TextEditingController();
  final SendCourseMsgController sendCourseMsgController = Get.find();

  @override
  void initState() {
    super.initState();
    getCourseChat(widget.args['courseId'], pageNo);

    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getCourseChat(widget.args['courseId'], pageNo);
      }
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
            title: const Text("Chat", style: SolhTextStyles.QS_body_1_bold),
            isLandingScreen: false,
            isVideoCallScreen: true),
        body: Obx(() => getCourseChatController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const SizedBox(height: 20),
                  if (getCourseChatController.isLoadingMore.value)
                    const Center(child: CircularProgressIndicator()),
                  Expanded(
                    child: ListView.separated(
                      reverse: true,
                      controller: scrollController,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => ChatPointedContainer(
                          color: getCourseChatController
                                      .conversationList[index].authorType !=
                                  'provider'
                              ? SolhColors.green228
                              : SolhColors.greenShade5,
                          isMyChat: getCourseChatController
                                  .conversationList[index].authorType ==
                              'provider',
                          child: TextChatCard(
                            conversation:
                                getCourseChatController.conversationList[index],
                          )),
                      itemCount:
                          getCourseChatController.conversationList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                    ),
                  ),
                  ChatTextField(
                      onSendBtnTapped: (value) {
                        if (value.isEmpty) {
                          Utility.showToast("Please type a message");
                        } else {
                          if (sendCourseMsgController.isSending.value) {
                            return;
                          } else {
                            sendCourseMsgController.sendMessage(
                                courseId: widget.args['courseId'],
                                message: textEditingController.text);
                            getCourseChatController.conversationList.insert(
                                0,
                                Conversation(
                                    dateTime: DateTime.now().toString(),
                                    body: textEditingController.text,
                                    authorType: 'user'));
                            getCourseChatController.conversationList.refresh();
                            textEditingController.clear();
                          }
                        }
                      },
                      textEditingController: textEditingController)
                ],
              )));
  }

  Future<void> getCourseChat(String id, int page) async {
    await getCourseChatController.getCourseChat(courseId: id, pageNo: page);
    pageNo++;
  }
}
