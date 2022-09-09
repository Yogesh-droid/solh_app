import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/psychology-test/psychology_test_model.dart';
import 'package:solh/model/psychology-test/test_question_model.dart';
import 'package:solh/services/network/network.dart';

class PsychologyTestController extends GetxController {
  var testList = <TestList>[].obs;
  var questionList = <TestQuestionList>[].obs;
  var isLoadingList = false.obs;
  var selectedTestname = ''.obs;

  Future<void> getTestList() async {
    isLoadingList.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        "${APIConstants.api}/api/get-test-list");

    PsychologyTestModel psychologyTestModel = PsychologyTestModel.fromJson(map);

    psychologyTestModel.testList!.forEach((element) {
      testList.value.add(element);
    });
    isLoadingList.value = false;
  }

  Future<void> getQuestion(String id) async {
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        "${APIConstants.api}/api/psychologicalTest?testId=$id");
    TestQuestionModel testQuestionModel = TestQuestionModel.fromJson(map);
    selectedTestname.value = testQuestionModel.testDetail!.testTitle ?? '';

    testQuestionModel.testDetail!.testQuestionList!.forEach((element) {
      questionList.value.add(element);
    });
    questionList.refresh();
  }

  @override
  void onInit() {
    getTestList();
    super.onInit();
  }
}
