import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/psychology-test/psychology_test_controller.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/psychology-test/psychology_test_page.dart';
import 'package:solh/ui/screens/psychology-test/test_question_page.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../model/psychology-test/psychology_test_model.dart';
import '../../../model/psychology-test/testHistory_result_model.dart';
import '../../../widgets_constants/constants/colors.dart';

class TestResultPage extends StatelessWidget {
  TestResultPage({Key? key}) : super(key: key);
  final PsychologyTestController psychologyTestController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithSelfAssessmentResultBackgroundArt(
      appBar: getAppBar(context),
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Stack(
        children: [
          SizedBox(
            height: 100.h,
            child: SingleChildScrollView(
              child: Obx(() => psychologyTestController.isResultLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              width: MediaQuery.of(context).size.width - 50,
                              // child: Text(
                              //   "Your test result is given below, It is not exact, but close enogh.",
                              //   style: SolhTextStyles.JournalingHintText,
                              // ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 8),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Text(
                                      psychologyTestController.testResultModel
                                              .value.result!.testResult ??
                                          '',
                                      // style: SolhTextStyles.GreenBorderButtonText,
                                      style:
                                          SolhTextStyles.QS_big_body.copyWith(
                                              color: SolhColors.primary_green),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  psychologyTestController.testResultModel.value
                                              .result!.image !=
                                          null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                              psychologyTestController
                                                      .testResultModel
                                                      .value
                                                      .result!
                                                      .image ??
                                                  ''),
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(0),
                                    child: ReadMoreText(
                                      psychologyTestController.testResultModel
                                              .value.result!.explanation ??
                                          '',
                                      style: SolhTextStyles.QS_body_1_bold,
                                      trimMode: TrimMode.Line,
                                      trimLines: 15,
                                      lessStyle:
                                          SolhTextStyles.QS_caption.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: SolhColors.primary_green),
                                      moreStyle:
                                          SolhTextStyles.QS_caption.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: SolhColors.primary_green),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 8.0),
                            //   child: Align(
                            //     alignment: Alignment.topLeft,
                            //     child: Text(
                            //       'Other Psychological Tests',
                            //       style: SolhTextStyles.AppBarText,
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 8.0),
                            //   child: Align(
                            //     alignment: Alignment.topLeft,
                            //     child: Container(
                            //       width: 300,
                            //       child: Text(
                            //           'It will be a guide to your therapy and to your own self-evaluation.'),
                            //     ),
                            //   ),
                            // ),
                            // Obx(() => psychologyTestController
                            //         .testHistoryMoreTest.isNotEmpty
                            //     ? getOtherTestWidget(psychologyTestController
                            //             .testResultModel.value.moreTests ??
                            //         [])
                            //     : Container()),
                          ]),
                    )),
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
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.master);
                      },
                      width: 70.w,
                      child: Text(
                        'Back To Home',
                        style: SolhTextStyles.CTA
                            .copyWith(color: SolhColors.white),
                      )),
                ],
              )),
        ],
      ),
    );
  }

  getAppBar(BuildContext context) {
    return SolhAppBar(
      isLandingScreen: false,
      title: Text(
        'Results',
        style: SolhTextStyles.QS_body_1_bold,
      ),
      callback: () {
        // Navigator.popUntil(context,
        //     (route) => route.settings.name == AppRoutes.psychologyTest);
        // Navigator.pushNamedAndRemoveUntil(
        //     context, AppRoutes.psychologyTest, (route) => false);
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );
  }

  Widget getOtherTestWidget(List<MoreTests> testHistoryMoreTest) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: testHistoryMoreTest.length,
          itemBuilder: (context, index) {
            return QuestionContainer(
              padding: 0,
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

  Future<bool> _onWillPop(BuildContext context) {
    Navigator.pop(context);
    Navigator.pop(context);
    return Future.value(true);
  }
}
