import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/controllers/psychology-test/psychology_test_controller.dart';
import 'package:solh/model/psychology-test/psychology_test_model.dart';
import 'package:solh/services/dynamic_link_sevice/dynamic_link_provider.dart';
import 'package:solh/ui/screens/home/homescreen.dart';
import 'package:solh/ui/screens/psychology-test/test_history_details.dart';
import 'package:solh/ui/screens/psychology-test/test_question_page.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:solh/widgets_constants/share_button.dart';

class PsychologyTestPage extends StatefulWidget {
  const PsychologyTestPage({Key? key}) : super(key: key);

  @override
  State<PsychologyTestPage> createState() => _PsychologyTestPageState();
}

class _PsychologyTestPageState extends State<PsychologyTestPage>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  PsychologyTestController psychologyTestController = Get.find();
  bool isAtTop = true;
  late final TabController tabController;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels < 10) {
        setState(() {
          isAtTop = true;
        });
      } else {
        setState(() {
          isAtTop = false;
        });
      }
    });

    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  AppBar getAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: SolhColors.black,
          size: 24,
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Self Assessment".tr,
            style: SolhTextStyles.QS_body_1_bold,
          ),
          Expanded(
            child: SizedBox(),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return showSelfAssessmentDisclaimer(context);
                },
              );
            },
            child: Icon(
              Icons.info,
              size: 15,
              color: SolhColors.grey_2,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      elevation: isAtTop ? 0 : 5,
      actions: [
        // MaterialButton(
        //     onPressed: () {},
        //     child: Text(
        //       'Skip',
        //       style: SolhTextStyles.GreenBorderButtonText,
        //     ))
      ],
    );
  }

  getBody() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "Our Self Assessment tests help you learn more about yourself."
                        .tr,
                    style: SolhTextStyles.QS_body_2_semi,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TabBar(
            controller: tabController,
            tabs: [
              Text(
                'Discover Tests'.tr,
              ),
              Text(
                'Result History'.tr,
              )
            ],
            labelColor: SolhColors.primary_green,
            indicatorColor: SolhColors.primary_green,
            labelStyle: SolhTextStyles.QS_body_1_bold,
            labelPadding: EdgeInsets.only(bottom: 16),
            onTap: (value) {
              if (value == 1) {
                psychologyTestController.testHistorylist.clear();
                psychologyTestController.getAttendedTestList();
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: TabBarView(
                controller: tabController,
                children: [getDiscoverTest(), getAttendedTest()]),
          )
        ],
      ),
    );
  }

  getQuestionContainer({required TestList test}) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0, top: 18),
      child: InkWell(
        onTap: () {
          psychologyTestController.selectedQuestion.clear();
          psychologyTestController.score.clear();
          psychologyTestController.submitAnswerModelList.clear();
          psychologyTestController.getQuestion(test.sId ?? '');
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TestQuestionsPage(
              id: test.sId,
              testTitle: test.testTitle,
            );
          }));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: SolhColors.primary_green, width: 0.5),
              borderRadius: BorderRadius.circular(10)),
          child: Row(children: [
            Container(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: test.testPicture ?? '',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 220,
                  child: Text(
                    test.testTitle ?? '',
                    style: SolhTextStyles.GreenBorderButtonText,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ),
                Container(
                  width: 220,
                  child: Text(
                    test.testDescription ?? '',
                    style: SolhTextStyles.JournalingHintText,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  test.testQuestionNumber.toString() +
                      ' Ques (${test.testDuration} min)',
                  style: SolhTextStyles.GreenBorderButtonText,
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  getTestHistoryContainer({required Map<String, TestList> map}) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0, top: 18),
      child: InkWell(
        onTap: () {
          // psychologyTestController.getTestHistoryDetails(test.sId ?? '');
          psychologyTestController.getTestHistoryDetails(
              map.values.first.test!.sId ?? '', map.values.first.sId ?? '');
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TestHistoryDetails();
          }));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: SolhColors.primary_green, width: 0.5),
              borderRadius: BorderRadius.circular(10)),
          child: Row(children: [
            Container(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: map.values.first.test!.testPicture ?? '',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 150,
                  height: 30,
                  child: Text(
                    map.values.first.test!.testTitle ?? '',
                    style: SolhTextStyles.GreenBorderButtonText,
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ),
                Container(
                  width: 150,
                  child: Text(
                    // test.testDuration.toString(),
                    DateFormat("dd MMM yyyy")
                        .format(DateTime.parse(map.keys.first)),
                    style: SolhTextStyles.QS_body_2_semi,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: SolhColors.primary_green),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, right: 8.0, top: 8, bottom: 8),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            )
          ]),
        ),
      ),
    );
  }

  Widget getDiscoverTest() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Obx(() => psychologyTestController.isLoadingList.value
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 20),
              itemCount: psychologyTestController.testList.length,
              itemBuilder: (context, index) {
                return QuestionContainer(
                  test: psychologyTestController.testList[index],
                  onQuestionTap: () {
                    psychologyTestController.selectedQuestion.clear();
                    psychologyTestController.score.clear();
                    psychologyTestController.submitAnswerModelList.clear();
                    psychologyTestController.getQuestion(
                        psychologyTestController.testList[index].sId ?? '');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TestQuestionsPage(
                        id: psychologyTestController.testList[index].sId,
                        testTitle:
                            psychologyTestController.testList[index].testTitle,
                      );
                    }));
                  },
                );
              })),
    );
  }

  Widget getAttendedTest() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, bottom: 18),
      child: Obx(() => psychologyTestController.isTestResultLoadingList.value
          ? Center(child: CircularProgressIndicator())
          : psychologyTestController.testHistorylist.isEmpty
              ? Center(
                  child: Text('No Result found'),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(bottom: 20),
                  shrinkWrap: true,
                  itemCount: psychologyTestController.testHistorylist.length,
                  itemBuilder: (context, index) {
                    return getTestHistoryContainer(
                        map: psychologyTestController.testHistorylist[index]);
                  })),
    );
  }
}

// ignore: must_be_immutable
class QuestionContainer extends StatelessWidget {
  QuestionContainer(
      {Key? key, required this.test, required this.onQuestionTap, this.padding})
      : super(key: key);
  final TestList test;
  final double? padding;
  final Function() onQuestionTap;

  PsychologyTestController psychologyTestController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(right: padding != null ? padding! : 18.0, top: 18),
      child: InkWell(
        onTap: onQuestionTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: SolhColors.primary_green, width: 0.5),
              borderRadius: BorderRadius.circular(10)),
          child: Row(children: [
            Container(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: test.testPicture ?? '',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 220,
                    child: Text(
                      test.testTitle ?? '',
                      style: SolhTextStyles.QS_body_1_bold.copyWith(
                          color: SolhColors.primary_green),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Container(
                    width: 220,
                    child: Text(
                      test.testDescription ?? '',
                      style: SolhTextStyles.QS_caption_bold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        test.testQuestionNumber.toString() +
                            ' Ques (${test.testDuration} min)',
                        style: SolhTextStyles.QS_caption_bold.copyWith(
                            color: SolhColors.primary_green),
                      ),
                      Obx(() {
                        return psychologyTestController.isSharingTest.value &&
                                psychologyTestController.currentSharingTest ==
                                    test.sId
                            ? Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: MyLoader(
                                  strokeWidth: 2,
                                  radius: 9,
                                ),
                              )
                            : ShareButton(
                                onTap: () async {
                                  psychologyTestController.isSharingTest(true);
                                  psychologyTestController.currentSharingTest =
                                      test.sId ?? '';
                                  String link = await DynamicLinkProvider
                                      .instance
                                      .createLink(
                                          createFor: 'selfAssessment',
                                          data: {
                                        'assessmentId': test.sId,
                                        'creatorUserId':
                                            Get.find<ProfileController>()
                                                    .myProfileModel
                                                    .value
                                                    .body!
                                                    .user!
                                                    .id ??
                                                ''
                                      });
                                  psychologyTestController.isSharingTest(false);

                                  Share.share(
                                      "Hey! I found this ${test.testTitle ?? ""} on the Solh App. Check it out! $link");
                                },
                                enableBackgroundCircle: false,
                                iconColor: SolhColors.Grey_1,
                                iconSize: 18,
                              );
                      }),
                    ],
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
