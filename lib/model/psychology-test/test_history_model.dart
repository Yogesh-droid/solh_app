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
      data['testHistoryList'] =
          this.testHistoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestHistoryList {
  String? sId;
  String? user;
  Test? test;
  int? score;
  String? createdAt;
  String? updatedAt;
  int? iV;

  TestHistoryList(
      {this.sId,
      this.user,
      this.test,
      this.score,
      this.createdAt,
      this.updatedAt,
      this.iV});

  TestHistoryList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    test = json['test'] != null ? new Test.fromJson(json['test']) : null;
    score = json['score'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    if (this.test != null) {
      data['test'] = this.test!.toJson();
    }
    data['score'] = this.score;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Test {
  String? testPictureType;
  String? sId;
  String? testTitle;
  String? testDescription;
  int? testQuestionNumber;
  int? testDuration;
  String? testStatus;
  String? testPicture;
  String? profilePictureType;

  Test(
      {this.testPictureType,
      this.sId,
      this.testTitle,
      this.testDescription,
      this.testQuestionNumber,
      this.testDuration,
      this.testStatus,
      this.testPicture,
      this.profilePictureType});

  Test.fromJson(Map<String, dynamic> json) {
    testPictureType = json['testPictureType'];
    sId = json['_id'];
    testTitle = json['testTitle'];
    testDescription = json['testDescription'];
    testQuestionNumber = json['testQuestionNumber'];
    testDuration = json['testDuration'];
    testStatus = json['testStatus'];
    testPicture = json['testPicture'];
    profilePictureType = json['profilePictureType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testPictureType'] = this.testPictureType;
    data['_id'] = this.sId;
    data['testTitle'] = this.testTitle;
    data['testDescription'] = this.testDescription;
    data['testQuestionNumber'] = this.testQuestionNumber;
    data['testDuration'] = this.testDuration;
    data['testStatus'] = this.testStatus;
    data['testPicture'] = this.testPicture;
    data['profilePictureType'] = this.profilePictureType;
    return data;
  }
}
