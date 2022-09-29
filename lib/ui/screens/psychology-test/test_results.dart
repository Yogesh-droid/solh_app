import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:readmore/readmore.dart';
import 'package:solh/controllers/psychology-test/psychology_test_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class TestResultPage extends StatelessWidget {
  TestResultPage({Key? key}) : super(key: key);
  final PsychologyTestController psychologyTestController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(context),
    );
  }

  Widget getBody(BuildContext context) {
    return SingleChildScrollView(
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
                      child: Text(
                        "Your test result is given below, It is not exact, but close enogh.",
                        style: SolhTextStyles.JournalingHintText,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      elevation: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              psychologyTestController.testResultModel.value
                                      .result!.testResult ??
                                  '',
                              style: SolhTextStyles.GreenBorderButtonText,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                minHeight: 206, minWidth: double.maxFinite),
                            padding: EdgeInsets.all(8),
                            child: ReadMoreText(
                              psychologyTestController.testResultModel.value
                                      .result!.explanation ??
                                  '',
                              style: SolhTextStyles.JournalingDescriptionText,
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
                      ),
                    )
                  ]),
            )),
    );
  }

  getAppBar() {
    return SolhAppBar(
      isLandingScreen: false,
      title: Text(
        'Results',
        style: SolhTextStyles.AppBarText,
      ),
    );
  }
}
