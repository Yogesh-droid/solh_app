import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:solh/controllers/psychology-test/psychology_test_controller.dart';
import 'package:solh/model/psychology-test/psychology_test_model.dart';
import 'package:solh/model/psychology-test/testHistory_result_model.dart';
import 'package:solh/ui/screens/psychology-test/psychology_test_page.dart';
import 'package:solh/ui/screens/psychology-test/test_question_page.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class TestHistoryDetails extends StatelessWidget {
  TestHistoryDetails({Key? key}) : super(key: key);
  final PsychologyTestController psychologyTestController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
          title: Text(
            'Result'.tr,
            style: SolhTextStyles.AppBarText,
          ),
          isLandingScreen: false),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              'Your test result is given below. It is not exact,\n but close enough.'
                  .tr,
              textAlign: TextAlign.center,
              style: SolhTextStyles.ProfileMenuGreyText,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: SolhColors.primary_green),
            child: Obx(() {
              return psychologyTestController.isHistoryResultLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Text(
                          // psychologyTestController
                          //         .testResultModel.value.result!.testResult ??
                          //     '',
                          psychologyTestController
                                  .testHistoryResult.value[0].result ??
                              '',
                          // style: SolhTextStyles.GreenBorderButtonText,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: ReadMoreText(
                            psychologyTestController
                                    .testHistoryResult.value[0].explaination ??
                                '',
                            style: SolhTextStyles.GreenButtonText,
                            trimMode: TrimMode.Line,
                            trimLines: 15,
                            textAlign: TextAlign.center,
                            lessStyle: SolhTextStyles
                                .JournalingDescriptionReadMoreText,
                            moreStyle: SolhTextStyles
                                .JournalingDescriptionReadMoreText,
                          ),
                        ),
                      ],
                    );
              // : Center(
              //     child: Text(
              //     psychologyTestController.testHistoryResult.isNotEmpty
              //         ? psychologyTestController
              //                 .testHistoryResult[0].result ??
              //             ''
              //         : 'No Result found',
              //     style: SolhTextStyles.GreenButtonText,
              //   ));
            }),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Other Self Assessment'.tr,
                style: SolhTextStyles.AppBarText,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 300,
                child: Text(
                    'It will be a guide to your therapy and to your own self-evaluation.'
                        .tr),
              ),
            ),
          ),
          Obx(() => psychologyTestController.testHistoryMoreTest.isNotEmpty
              ? getOtherTestWidget(
                  psychologyTestController.testHistoryMoreTest.value)
              : Container()),
        ],
      )),
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
