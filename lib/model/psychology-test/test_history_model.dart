class TestHistoryModel {
  bool? success;
  List<TestHistoryList>? testHistoryList;

  TestHistoryModel({this.success, this.testHistoryList});

  TestHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['testList'] != null) {
      testHistoryList = <TestHistoryList>[];
      json['testList'].forEach((v) {
        testHistoryList!.add(new TestHistoryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.testHistoryList != null) {
      data['testList'] = this.testHistoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestHistoryList {
  String? sId;
  String? testTitle;
  String? testDescription;
  int? testQuestionNumber;
  int? testDuration;
  String? testPicture;

  TestHistoryList(
      {this.sId,
      this.testTitle,
      this.testDescription,
      this.testQuestionNumber,
      this.testDuration,
      this.testPicture});

  TestHistoryList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    testTitle = json['testTitle'];
    testDescription = json['testDescription'];
    testQuestionNumber = json['testQuestionNumber'];
    testDuration = json['testDuration'];
    testPicture = json['testPicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['testTitle'] = this.testTitle;
    data['testDescription'] = this.testDescription;
    data['testQuestionNumber'] = this.testQuestionNumber;
    data['testDuration'] = this.testDuration;
    data['testPicture'] = this.testPicture;
    return data;
  }
}
