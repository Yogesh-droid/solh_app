import 'package:solh/model/psychology-test/test_question_model.dart';

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
  List<TestData>? testData;
  Test? test;
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
      this.test,
      this.testData,
      this.testPicture});

  TestList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    testTitle = json['testTitle'];
    testDescription = json['testDescription'];
    testQuestionNumber = json['testQuestionNumber'];
    testDuration = json['testDuration'];
    test = json['test'] != null ? Test.fromJson(json['test']) : null;
    // testData = json['testData'] != null ? TestData.fromJson(json['testData']) : null;
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

class TestData {
  String? question;
  String? questionId;
  String? answer;
  String? answerId;
  String? sId;

  TestData(
      {this.question, this.questionId, this.answer, this.answerId, this.sId});

  TestData.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    questionId = json['questionId'];
    answer = json['answer'];
    answerId = json['answerId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['questionId'] = this.questionId;
    data['answer'] = this.answer;
    data['answerId'] = this.answerId;
    data['_id'] = this.sId;
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
  List<TestQuestionList>? testQuestionList;
  List<TestScoreInterpretation>? testScoreInterpretation;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<String>? attemptedBy;

  Test(
      {this.testPictureType,
      this.sId,
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
      this.iV,
      this.attemptedBy});

  Test.fromJson(Map<String, dynamic> json) {
    testPictureType =
        json['testPictureType'] != null ? json['testPictureType'] : null;
    sId = json['_id'];
    testTitle = json['testTitle'];
    testDescription = json['testDescription'];
    testQuestionNumber = json['testQuestionNumber'];
    testDuration = json['testDuration'];
    testStatus = json['testStatus'];
    testPicture = json['testPicture'];
    profilePictureType = json['profilePictureType'];
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
    attemptedBy = json['attemptedBy'].cast<String>();
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
    data['attemptedBy'] = this.attemptedBy;
    return data;
  }
}


/* import 'package:solh/model/psychology-test/test_question_model.dart';

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
  List<TestData>? testData;
  Test? test;
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

class TestData {
  String? question;
  String? questionId;
  String? answer;
  String? answerId;
  String? sId;

  TestData(
      {this.question, this.questionId, this.answer, this.answerId, this.sId});

  TestData.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    questionId = json['questionId'];
    answer = json['answer'];
    answerId = json['answerId'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['questionId'] = this.questionId;
    data['answer'] = this.answer;
    data['answerId'] = this.answerId;
    data['_id'] = this.sId;
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
  List<TestQuestionList>? testQuestionList;
  List<TestScoreInterpretation>? testScoreInterpretation;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<String>? attemptedBy;

  Test(
      {this.testPictureType,
      this.sId,
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
      this.iV,
      this.attemptedBy});

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
    attemptedBy = json['attemptedBy'].cast<String>();
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
    data['attemptedBy'] = this.attemptedBy;
    return data;
  }
}
 */