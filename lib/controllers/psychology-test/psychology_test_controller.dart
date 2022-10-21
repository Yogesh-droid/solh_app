import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/psychology-test/psychology_test_model.dart';
import 'package:solh/model/psychology-test/test_history_model.dart';
import 'package:solh/model/psychology-test/test_question_model.dart';
import 'package:solh/model/psychology-test/test_result_model.dart';
import 'package:solh/services/network/network.dart';
import '../../model/psychology-test/testHistory_result_model.dart';

class PsychologyTestController extends GetxController {
  var testList = <TestList>[].obs;
  var testHistorylist = <TestHistoryList>[].obs;
  var questionList = <TestQuestionList>[].obs;
  var isLoadingList = false.obs;
  var isQuestionsLoading = false.obs;
  var selectedTestname = ''.obs;
  var selectedQuestion = [].obs;
  List<int> score = [];
  List<Map<String, dynamic>> submitAnswerModelList = [];
  var testResultModel = TestResultModel().obs;
  var isResultLoading = false.obs;
  var isHistoryResultLoading = false.obs;
  var isTestResultLoadingList = false.obs;

  var testHistoryResult = <TestResult>[].obs;
  var testHistoryMoreTest = <MoreTests>[].obs;

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

  Future<void> getAttendedTestList() async {
    isTestResultLoadingList.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        "${APIConstants.api}/api/test-taken");

    TestHistoryModel testHistoryModel = TestHistoryModel.fromJson(map);

    testHistoryModel.testHistoryList!.forEach((element) {
      testHistorylist.value.add(element);
    });
    isTestResultLoadingList.value = false;
  }

  Future<void> getQuestion(String id) async {
    isQuestionsLoading.value = true;
    questionList.clear();
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        "${APIConstants.api}/api/psychologicalTest?testId=$id");
    TestQuestionModel testQuestionModel = TestQuestionModel.fromJson(map);
    selectedTestname.value = testQuestionModel.testDetail!.testTitle ?? '';
    testQuestionModel.testDetail!.testQuestionList!.forEach((element) {
      questionList.value.add(element);
    });
    questionList.refresh();
    isQuestionsLoading.value = false;
  }

  Future<void> submitTest(String id) async {
    isResultLoading.value = true;
    Map<String, dynamic> map = await Network.makePostRequestWithToken(
        url: '${APIConstants.api}/api/app/submit-test?testId=$id',
        body: {"score": score, "testData": submitAnswerModelList},
        isEncoded: true);

    testResultModel.value = TestResultModel.fromJson(map);
    isResultLoading.value = false;
  }

  Future<void> getTestHistoryDetails(String id) async {
    isHistoryResultLoading.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
      '${APIConstants.api}/api/track-result?test=$id',
    );

    TestHistoryResultModel testHistoryResultModel =
        TestHistoryResultModel.fromJson(map);
    testHistoryResult.value = testHistoryResultModel.testResult ?? [];
    testHistoryMoreTest.value = testHistoryResultModel.moreTests ?? [];

    isHistoryResultLoading.value = false;
  }

  @override
  void onInit() {
    getTestList();
    getAttendedTestList();
    super.onInit();
  }
}
