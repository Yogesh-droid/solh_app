import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/psychology-test/psychology_test_controller.dart';
import 'package:solh/model/psychology-test/submit_answer_model.dart';
import 'package:solh/model/psychology-test/test_question_model.dart';
import 'package:solh/ui/screens/psychology-test/test_results.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class TestQuestionsPage extends StatefulWidget {
  const TestQuestionsPage({Key? key, this.id, this.testTitle})
      : super(key: key);
  final String? id;
  final String? testTitle;

  @override
  State<TestQuestionsPage> createState() => _TestQuestionsPageState();
}

class _TestQuestionsPageState extends State<TestQuestionsPage> {
  final PsychologyTestController psychologyTestController = Get.find();
  String currentQuestion = '';
  bool isNextActive = false;
  bool isLast = false;
  late final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          setState(() {
            psychologyTestController.questionList.length == 1
                ? isLast = true
                : false;
          });
        });
        return psychologyTestController.isQuestionsLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: controller,
                      children: psychologyTestController.questionList
                          .map((e) => getQuestionView(context, e))
                          .toList(),
                      onPageChanged: (index) {
                        if (index + 1 ==
                            psychologyTestController.questionList.length) {
                          setState(() {
                            isLast = true;
                          });
                        } else {
                          isLast = false;
                        }
                        getIsNextAvailable();
                      },
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SolhGreenBorderMiniButton(
                        child: Text(
                          'Back',
                          style: SolhTextStyles.GreenBorderButtonText,
                        ),
                        onPressed: () {
                          if (controller.page != 0) {
                            controller.previousPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeOut);
                          } else {
                            return;
                          }
                        },
                      ),
                      SolhGreenMiniButton(
                        backgroundColor: isNextActive
                            ? SolhColors.primary_green
                            : SolhColors.dark_grey,
                        child: Text(isLast ? "Done" : 'Next',
                            style: SolhTextStyles.GreenButtonText),
                        onPressed: isNextActive
                            ? () {
                                if (isLast) {
                                  psychologyTestController
                                      .getTestHistoryDetails(widget.id!);
                                  psychologyTestController
                                      .submitTest(widget.id ?? '');
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return TestResultPage();
                                  }));
                                } else {
                                  controller.nextPage(
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.decelerate);
                                }
                              }
                            : () {},
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              );
      }),
    );
  }

  SolhAppBar getAppbar() {
    return SolhAppBar(
      isLandingScreen: false,
      title: Text(
        widget.testTitle ?? '',
        style: SolhTextStyles.AppBarText,
      ),
    );
  }

  Widget getQuestionView(BuildContext context, TestQuestionList e) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0, top: 30, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question ${psychologyTestController.questionList.indexOf(e) + 1}/${psychologyTestController.questionList.length}",
            style: SolhTextStyles.JournalingHintText,
          ),
          Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Text(e.question ?? '')),
          SizedBox(
            height: 20,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: e.answer!.length,
              itemBuilder: (context, index) {
                return questionTile(e.answer![index], e);
              })
        ],
      ),
    );
  }

  Widget questionTile(Answer answer, TestQuestionList testQuestion) {
    // if (psychologyTestController.selectedQuestion.value.length >
    //         psychologyTestController.questionList.value.indexOf(testQuestion) &&
    //     psychologyTestController.selectedQuestion.value[psychologyTestController
    //             .questionList.value
    //             .indexOf(testQuestion)] ==
    //         answer.title) {
    //   psychologyTestController.isNextEnabled.value = true;
    // } else {
    //   psychologyTestController.isNextEnabled.value = false;
    // }
    currentQuestion = testQuestion.question ?? '';
    return Obx(() => InkWell(
          onTap: () {
            saveTestDate(answer, testQuestion);
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: psychologyTestController.selectedQuestion.length >
                                psychologyTestController.questionList
                                    .indexOf(testQuestion) &&
                            psychologyTestController.selectedQuestion[
                                    psychologyTestController.questionList
                                        .indexOf(testQuestion)] ==
                                answer.title
                        ? SolhColors.primary_green
                        : Colors.white),
                borderRadius: BorderRadius.circular(5)),
            child: Row(children: [
              Radio(
                  value: answer.title ?? '',
                  groupValue: psychologyTestController.selectedQuestion.length >
                          psychologyTestController.questionList
                              .indexOf(testQuestion)
                      ? psychologyTestController.selectedQuestion[
                          psychologyTestController.questionList
                              .indexOf(testQuestion)]
                      : '',
                  onChanged: (value) {
                    saveTestDate(answer, testQuestion);
                  }),
              Container(
                width: MediaQuery.of(context).size.width - 90,
                child: Text(
                  answer.title ?? '',
                  style: SolhTextStyles.JournalingPostMenuText,
                ),
              )
            ]),
          ),
        ));
  }

  @override
  void initState() {
    controller = PageController(initialPage: 0);
    super.initState();
    getIsNextAvailable();
  }

  void getIsNextAvailable() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (psychologyTestController.selectedQuestion.value.length >
          controller.page!.round()) {
        setState(() {
          isNextActive = true;
        });
      } else {
        setState(() {
          isNextActive = false;
        });
      }
    });
  }

  void saveTestDate(Answer answer, TestQuestionList testQuestion) {
    SubmitAnswerModel submitAnswerModel = SubmitAnswerModel(
        answer: answer.title,
        answerId: answer.sId,
        question: testQuestion.question,
        questionId: testQuestion.sId);
    psychologyTestController.submitAnswerModelList.insert(
        psychologyTestController.questionList.value.indexOf(testQuestion),
        submitAnswerModel.toJson());
    psychologyTestController.selectedQuestion.insert(
        psychologyTestController.questionList.value.indexOf(testQuestion),
        answer.title);
    psychologyTestController.score.insert(
        psychologyTestController.questionList.value.indexOf(testQuestion),
        answer.score ?? 0);
    psychologyTestController.selectedQuestion.refresh();
    getIsNextAvailable();
  }
}
