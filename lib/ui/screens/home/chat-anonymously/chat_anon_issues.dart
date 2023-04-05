import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/home/chat-anonymously/chat-anon-controller/chat_anon_controller.dart';
import 'package:solh/ui/screens/mood-meter/mood_meter.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/profileSetupFloatingActionButton.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';

class ChatAnonIssues extends StatefulWidget {
  ChatAnonIssues({Key? key}) : super(key: key);

  @override
  State<ChatAnonIssues> createState() => _ChatAnonIssuesState();
}

class _ChatAnonIssuesState extends State<ChatAnonIssues> {
  final ChatAnonController chatAnonController = Get.put(ChatAnonController());

  final ProfileController profileController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initialDialog(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundArt(
      floatingActionButton: Obx(() {
        return chatAnonController.isFeatchingUser.value
            ? ProfileSetupFloatingActionButton.profileSetupFloatingActionButton(
                child: SolhSmallButtonLoader(), onPressed: (() => null))
            : ProfileSetupFloatingActionButton.profileSetupFloatingActionButton(
                child: const Icon(
                  Icons.chevron_right_rounded,
                  size: 40,
                ),
                onPressed: (() async {
                  bool response =
                      await chatAnonController.getVolunteerController();
                  if (response) {
                    showGeneralDialog(
                        context: context,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Scaffold(
                              body: MoodMeter(
                            args: {
                              "continueAction": () {
                                if (profileController.myProfileModel.value.body!
                                        .user!.anonymous ==
                                    null) {
                                  Navigator.pushNamed(
                                      context, AppRoutes.anonymousProfile,
                                      arguments: {
                                        "indexOfpage": 0,
                                        "formAnonChat": true,
                                      });
                                } else {
                                  Navigator.pushNamed(
                                      context, AppRoutes.chatUser,
                                      arguments: {
                                        "imageUrl": chatAnonController
                                            .chatAnonModel
                                            .value
                                            .sosChatSupport!
                                            .first
                                            .profilePicture,
                                        "name": chatAnonController.chatAnonModel
                                            .value.sosChatSupport!.first.name,
                                        "sId": chatAnonController.chatAnonModel
                                            .value.sosChatSupport!.first.sId,
                                        "isAnonChat": true
                                      });
                                }
                              }
                            },
                          ));
                        });
                  } else {
                    SolhSnackbar.error('Error', 'Something went wrong');
                  }
                }),
              );
      }),
      appBar: SolhAppBarTanasparentOnlyBackButton(
        backButtonColor: SolhColors.black666,
        onBackButton: () => Navigator.of(context).pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            NeedSupportOnText(),
            SizedBox(
              height: 3.h,
            ),
            Expanded(
              child: ListView(
                children: [
                  IssueChips(),
                  OtherIssueList(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: FilterChip(
                      label: Text('Other'),
                      onSelected: (value) {
                        if (value) {
                          chatAnonController.showOtherissueField.value = true;
                        }
                      },
                      backgroundColor: SolhColors.grey239,
                      side: BorderSide(color: SolhColors.primary_green),
                    ),
                  ),
                  Obx(() {
                    return chatAnonController.showOtherissueField.value
                        ? Column(
                            children: [
                              TextField(
                                  controller:
                                      chatAnonController.otherIssueTextField,
                                  decoration: TextFieldStyles.greenF_greyUF_4R
                                      .copyWith(
                                          hintText: " Enter Custom issue")),
                              SizedBox(
                                height: 1.h,
                              ),
                              SolhGreenMiniButton(
                                onPressed: (() {
                                  if (chatAnonController
                                          .otherIssueTextField.text
                                          .trim() !=
                                      '') {
                                    addOtherIssues(
                                        chatAnonController,
                                        chatAnonController
                                            .otherIssueTextField.text);
                                  }

                                  chatAnonController.otherIssueTextField.text =
                                      '';
                                  chatAnonController.showOtherissueField.value =
                                      false;
                                }),
                                child: Text(
                                  'Add',
                                  style: SolhTextStyles.NormalTextWhiteS14W6,
                                ),
                              )
                            ],
                          )
                        : Container();
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NeedSupportOnText extends StatelessWidget {
  const NeedSupportOnText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Need support on',
          style: SolhTextStyles.Large2BlackTextS24W7,
        ),
        Text(
          "Give us a rough idea of the issues that you deal with on a daily basis. You may select more than one."
              .tr,
          style: SolhTextStyles.NormalTextGreyS14W5,
        ),
      ],
    );
  }
}

class IssueChips extends StatefulWidget {
  const IssueChips({Key? key}) : super(key: key);

  @override
  State<IssueChips> createState() => _IssueChipsState();
}

class _IssueChipsState extends State<IssueChips> {
  ChatAnonController chatAnonController = Get.find();

  @override
  void initState() {
    // TODO: implement initState

    chatAnonController.getNeedSupportOnIssues();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return chatAnonController.isLoadingIssues.value
          ? Center(
              child: MyLoader(),
            )
          : Wrap(
              spacing: 5,
              children: chatAnonController
                  .needSupportOnModel.value.specialization!
                  .map((e) => FilterChip(
                      onSelected: (value) {
                        print(chatAnonController.selectedIsses.toString());
                        value
                            ? addIssues(chatAnonController, e)
                            : removeIssues(chatAnonController, e);

                        setState(() {});
                      },
                      selected:
                          chatAnonController.selectedIsses.contains(e.sId),
                      selectedColor: SolhColors.primary_green,
                      backgroundColor: SolhColors.grey239,
                      checkmarkColor:
                          chatAnonController.selectedIsses.contains(e.sId)
                              ? SolhColors.white
                              : SolhColors.black,
                      label: chatAnonController.selectedIsses.contains(e.sId)
                          ? Text(
                              e.slug!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(color: SolhColors.white),
                            )
                          : Text(
                              e.slug!,
                              style: Theme.of(context).textTheme.headline1,
                            )))
                  .toList());
    });
  }
}

class OtherIssueList extends StatelessWidget {
  OtherIssueList({Key? key}) : super(key: key);
  final ChatAnonController chatAnonController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Wrap(
        spacing: 5,
        children: chatAnonController.selectedOtherIssues.value.map((element) {
          return FilterChip(
            showCheckmark: false,
            selectedColor: SolhColors.primary_green,
            label: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.cancel_outlined,
                  size: 19,
                  color: SolhColors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  element,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: SolhColors.white),
                ),
              ],
            ),
            onSelected: (Value) {
              chatAnonController.selectedOtherIssues.remove(element);
            },
            selected: true,
          );
        }).toList(),
      );
    });
  }
}

addIssues(chatAnonController, e) {
  chatAnonController.selectedIsses.value.add(e.sId);
  chatAnonController.selectedIssuesName.value =
      chatAnonController.selectedIssuesName.value + '${e.name}, ';
}

removeIssues(chatAnonController, e) {
  chatAnonController.selectedIsses.value.remove(e.sId);
  chatAnonController.selectedIssuesName.value.replaceAll('${e.name}', '');
}

addOtherIssues(ChatAnonController chatAnonController, e) {
  chatAnonController.selectedOtherIssues.add(e);
  chatAnonController.selectedOtherIssuesName.value =
      chatAnonController.selectedOtherIssuesName.value + '${e}, ';
}

removeOtherIssues(ChatAnonController chatAnonController, e) {
  chatAnonController.selectedOtherIssues.value.remove(e);
  chatAnonController.selectedOtherIssuesName.value.replaceAll('${e}', '');
}

Future<void> initialDialog(BuildContext context) {
  return showGeneralDialog<void>(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return AlertDialog(
        title: Text('Disclaimer',
            style: SolhTextStyles.QS_body_1_bold.copyWith(
                color: SolhColors.primaryRed)),
        content: Text(
            'We are not a medical emergency service provider or a suicide prevention helpline. If you are suicidal, or having any similar thoughts, we suggest you immediately reach out to a suicide prevention helpline. National Suicide Prevention Lifeline @ 1-800-273-8255 or Vandrevala Foundation Helpline @ 1-860-266-2345 or Aasra @ +91-22-22754-6669.'
                .tr,
            style: SolhTextStyles.QS_body_2),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: Text(
              'Continue'.tr,
              style:
                  SolhTextStyles.CTA.copyWith(color: SolhColors.primary_green),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
