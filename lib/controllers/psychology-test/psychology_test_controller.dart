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
  var testHistorylist = <Map<String, TestList>>[].obs;
  PsychologyTestModel? psychologyTest;
  var questionList = <TestQuestionList>[].obs;
  var testQuestionModel = TestQuestionModel().obs;
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
  var isSharingTest = false.obs;
  var currentSharingTest = '';

  Future<void> getTestList() async {
    isLoadingList.value = true;
    testList.clear();
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        "${APIConstants.api}/api/get-test-listv2");

    PsychologyTestModel psychologyTestModel = PsychologyTestModel.fromJson(map);

    psychologyTestModel.testList!.forEach((element) {
      testList.add(element);
    });
    isLoadingList.value = false;
  }

  Future<void> getAttendedTestList() async {
    isTestResultLoadingList.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        "${APIConstants.api}/api/test-taken");

    TestHistoryModel testHistoryModel = TestHistoryModel.fromJson(map);
    print("This is testTaken ${testHistoryModel.testList!.length}");

    testHistoryModel.testList!.forEach((element) {
      if (element.test != null) {
        testHistorylist.add({element.createdAt ?? "": element});
      }
    });

    isTestResultLoadingList.value = false;
  }

  Future<void> getQuestion(String id) async {
    isQuestionsLoading.value = true;
    questionList.clear();
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
        "${APIConstants.api}/api/psychologicalTest?testId=$id");
    testQuestionModel.value = TestQuestionModel.fromJson(map);
    selectedTestname.value =
        testQuestionModel.value.testDetail!.testTitle ?? '';

    testQuestionModel.value.testDetail!.testQuestionList!.forEach((element) {
      questionList.add(element);
    });
    questionList.refresh();
    isQuestionsLoading.value = false;
  }

  Future<void> submitTest(String id) async {
    isResultLoading.value = true;
    Map<String, dynamic> map = await Network.makePostRequestWithToken(
        url: '${APIConstants.api}/api/v1/app/submit-test?testId=$id',
        body: {"score": score, "testData": submitAnswerModelList},
        isEncoded: true);
    print(map);
    testResultModel.value = TestResultModel.fromJson(map);
    isResultLoading.value = false;
  }

  Future<void> getTestHistoryDetails(String id, String resultId) async {
    isHistoryResultLoading.value = true;
    Map<String, dynamic> map = await Network.makeGetRequestWithToken(
      '${APIConstants.api}/api/v1/track-result?test=$id&id=$resultId',
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
