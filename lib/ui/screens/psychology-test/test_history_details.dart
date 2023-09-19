import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/psychology-test/psychology_test_controller.dart';
import 'package:solh/model/psychology-test/psychology_test_model.dart';
import 'package:solh/model/psychology-test/testHistory_result_model.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/psychology-test/psychology_test_page.dart';
import 'package:solh/ui/screens/psychology-test/test_question_page.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class TestHistoryDetails extends StatelessWidget {
  TestHistoryDetails({Key? key}) : super(key: key);
  final PsychologyTestController psychologyTestController = Get.find();
  @override
  Widget build(BuildContext context) {
    return ScaffoldWithSelfAssessmentResultBackgroundArt(
      appBar: SolhAppBar(
          title: Text(
            'Result'.tr,
            style: SolhTextStyles.QS_body_1_bold,
          ),
          isLandingScreen: false),
      body: Stack(
        children: [
          SizedBox(
            height: 100.h,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Obx(() {
                      return psychologyTestController
                              .isHistoryResultLoading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : psychologyTestController.testHistoryResult.isEmpty
                              ? SizedBox()
                              : Column(
                                  children: [
                                    Text(
                                      psychologyTestController
                                              .testHistoryResult[0].result ??
                                          '',
                                      // style: SolhTextStyles.GreenBorderButtonText,
                                      style:
                                          SolhTextStyles.QS_big_body.copyWith(
                                              color: SolhColors.primary_green),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    psychologyTestController
                                                .testHistoryResult[0].image !=
                                            null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.network(
                                                psychologyTestController
                                                    .testHistoryResult[0]
                                                    .image!),
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Container(
                                      child: ReadMoreText(
                                        psychologyTestController
                                                .testHistoryResult[0]
                                                .explaination ??
                                            '',
                                        style: SolhTextStyles.QS_body_1_bold,
                                        trimMode: TrimMode.Line,
                                        trimLines: 15,
                                        textAlign: TextAlign.center,
                                        lessStyle: SolhTextStyles
                                            .JournalingDescriptionReadMoreText,
                                        moreStyle: SolhTextStyles
                                            .JournalingDescriptionReadMoreText,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    )
                                  ],
                                );
                    }),
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 18.0),
                  //   child: Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Text(
                  //       'Other Self Assessment'.tr,
                  //       style: SolhTextStyles.AppBarText,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 18.0),
                  //   child: Align(
                  //     alignment: Alignment.topLeft,
                  //     child: Container(
                  //       width: 300,
                  //       child: Text(
                  //           'It will be a guide to your therapy and to your own self-evaluation.'
                  //               .tr),
                  //     ),
                  //   ),
                  // ),
                  // Obx(() =>
                  //     psychologyTestController.testHistoryMoreTest.isNotEmpty
                  //         ? getOtherTestWidget(
                  //             psychologyTestController.testHistoryMoreTest)
                  //         : Container()),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SolhGreenButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.master),
                    width: 70.w,
                    child: Text(
                      'Back To Home',
                      style:
                          SolhTextStyles.CTA.copyWith(color: SolhColors.white),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getOtherTestWidget(List<MoreTests> testHistoryMoreTest) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: testHistoryMoreTest.length,
          itemBuilder: (context, index) {
            return QuestionContainer(
              test: TestList(
                  sId: testHistoryMoreTest[index].sId,
                  testDescription: testHistoryMoreTest[index].testDescription,
                  testDuration: testHistoryMoreTest[index].testDuration,
                  testPicture: testHistoryMoreTest[index].testPicture,
                  testQuestionNumber:
                      testHistoryMoreTest[index].testQuestionNumber,
                  testTitle: testHistoryMoreTest[index].testTitle),
              onQuestionTap: () {
                psychologyTestController.selectedQuestion.clear();
                psychologyTestController.score.clear();
                psychologyTestController.submitAnswerModelList.clear();
                psychologyTestController
                    .getQuestion(testHistoryMoreTest[index].sId ?? '');
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TestQuestionsPage(
                    id: testHistoryMoreTest[index].sId,
                    testTitle: testHistoryMoreTest[index].testTitle,
                  );
                }));
              },
            );
          }),
    );
  }
}
