import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            'Result',
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
              'Your test result is given below, It is not exact,\n but close enogh.',
              textAlign: TextAlign.center,
              style: SolhTextStyles.ProfileMenuGreyText,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: SolhColors.green),
            child: Obx(() {
              return psychologyTestController.isHistoryResultLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: Text(
                      psychologyTestController.testHistoryResult.isNotEmpty
                          ? psychologyTestController
                                  .testHistoryResult[0].result ??
                              ''
                          : 'No Result found',
                      style: SolhTextStyles.GreenButtonText,
                    ));
            }),
          ),
          Obx(() => psychologyTestController.testHistoryMoreTest.isNotEmpty
              ? getOtherTestWidget(
                  psychologyTestController.testHistoryMoreTest.value)
              : Container())
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
