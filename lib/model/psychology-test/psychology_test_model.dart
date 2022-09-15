class PsychologyTestModel {
  bool? success;
  List<TestList>? testList;

  PsychologyTestModel({this.success, this.testList});

  PsychologyTestModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['testList'] != null) {
      testList = <TestList>[];
      json['testList'].forEach((v) {
        testList!.add(new TestList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.testList != null) {
      data['testList'] = this.testList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestList {
  String? sId;
  String? testTitle;
  String? testDescription;
  int? testQuestionNumber;
  int? testDuration;
  String? testPicture;

  TestList(
      {this.sId,
      this.testTitle,
      this.testDescription,
      this.testQuestionNumber,
      this.testDuration,
      this.testPicture});

  TestList.fromJson(Map<String, dynamic> json) {
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
