class TestQuestionModel {
  bool? success;
  TestDetail? testDetail;

  TestQuestionModel({this.success, this.testDetail});

  TestQuestionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    testDetail = json['testDetail'] != null
        ? new TestDetail.fromJson(json['testDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.testDetail != null) {
      data['testDetail'] = this.testDetail!.toJson();
    }
    return data;
  }
}

class TestDetail {
  String? sId;
  String? testTitle;
  String? testDescription;
  int? testQuestionNumber;
  int? testDuration;
  String? testStatus;
  String? testPicture;
  String? profilePictureType;
  List<TestQuestionList>? testQuestionList;
  List<TestScoreInterpretation>? testScoreInterpretation;
  String? createdAt;
  String? updatedAt;
  String? testType;
  int? iV;
  String? testDisclaimer;

  TestDetail(
      {this.sId,
      this.testTitle,
      this.testDescription,
      this.testQuestionNumber,
      this.testDuration,
      this.testStatus,
      this.testPicture,
      this.profilePictureType,
      this.testQuestionList,
      this.testScoreInterpretation,
      this.createdAt,
      this.updatedAt,
      this.testDisclaimer,
      this.iV});

  TestDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    testTitle = json['testTitle'];
    testDescription = json['testDescription'];
    testQuestionNumber = json['testQuestionNumber'];
    testDuration = json['testDuration'];
    testStatus = json['testStatus'];
    testPicture = json['testPicture'];
    profilePictureType = json['profilePictureType'];
    testType = json["testType"];
    if (json['testQuestionList'] != null) {
      testQuestionList = <TestQuestionList>[];
      json['testQuestionList'].forEach((v) {
        testQuestionList!.add(new TestQuestionList.fromJson(v));
      });
    }
    if (json['testScoreInterpretation'] != null) {
      testScoreInterpretation = <TestScoreInterpretation>[];
      json['testScoreInterpretation'].forEach((v) {
        testScoreInterpretation!.add(new TestScoreInterpretation.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    testDisclaimer = json['testDisclaimer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['testTitle'] = this.testTitle;
    data['testDescription'] = this.testDescription;
    data['testQuestionNumber'] = this.testQuestionNumber;
    data['testDuration'] = this.testDuration;
    data['testStatus'] = this.testStatus;
    data['testPicture'] = this.testPicture;
    data['profilePictureType'] = this.profilePictureType;
    if (this.testQuestionList != null) {
      data['testQuestionList'] =
          this.testQuestionList!.map((v) => v.toJson()).toList();
    }
    if (this.testScoreInterpretation != null) {
      data['testScoreInterpretation'] =
          this.testScoreInterpretation!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class TestQuestionList {
  String? question;
  List<Answer>? answer;
  String? sId;

  TestQuestionList({this.question, this.answer, this.sId});

  TestQuestionList.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    if (json['answer'] != null) {
      answer = <Answer>[];
      json['answer'].forEach((v) {
        answer!.add(new Answer.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    if (this.answer != null) {
      data['answer'] = this.answer!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class Answer {
  String? title;
  int? score;
  String? sId;
  String? image;

  Answer({this.title, this.score, this.sId});

  Answer.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    score = json['score'];
    sId = json['_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['score'] = this.score;
    data['_id'] = this.sId;
    return data;
  }
}

class TestScoreInterpretation {
  String? scoreFrom;
  String? scoreTill;
  String? testResult;
  String? testExplanations;
  String? sId;

  TestScoreInterpretation(
      {this.scoreFrom,
      this.scoreTill,
      this.testResult,
      this.testExplanations,
      this.sId});

  TestScoreInterpretation.fromJson(Map<String, dynamic> json) {
    scoreFrom = json['scoreFrom'];
    scoreTill = json['scoreTill'];
    testResult = json['testResult'];
    testExplanations = json['testExplanations'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scoreFrom'] = this.scoreFrom;
    data['scoreTill'] = this.scoreTill;
    data['testResult'] = this.testResult;
    data['testExplanations'] = this.testExplanations;
    data['_id'] = this.sId;
    return data;
  }
}
