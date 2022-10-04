import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/psychology-test/psychology_test_controller.dart';
import 'package:solh/model/psychology-test/psychology_test_model.dart';
import 'package:solh/ui/screens/psychology-test/test_question_page.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class PsychologyTestPage extends StatefulWidget {
  const PsychologyTestPage({Key? key}) : super(key: key);

  @override
  State<PsychologyTestPage> createState() => _PsychologyTestPageState();
}

class _PsychologyTestPageState extends State<PsychologyTestPage> {
  final ScrollController scrollController = ScrollController();
  PsychologyTestController psychologyTestController = Get.find();
  bool isAtTop = true;

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
      title: Text(
        "Psychological Tests",
        style: SolhTextStyles.AppBarText,
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
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Column(
          children: [
            Text(
              "Our Psychology Tests help you understand whether certain mental health or emotional issues may be of concern to you.",
              style: SolhTextStyles.JournalingDescriptionText,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'It will be a guide to your therapy and to your own self-evaluation.',
              style: SolhTextStyles.JournalingDescriptionText,
            ),
            Obx(() => psychologyTestController.isLoadingList.value
                ? CircularProgressIndicator()
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: psychologyTestController.testList.length,
                    itemBuilder: (context, index) {
                      return getQuestionContainer(
                          test: psychologyTestController.testList[index]);
                    }))
          ],
        ),
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
              border: Border.all(color: SolhColors.grey102, width: 0.5),
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
}
