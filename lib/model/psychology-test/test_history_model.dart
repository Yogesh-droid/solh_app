import 'package:solh/model/psychology-test/psychology_test_model.dart';

class TestHistoryModel {
  bool? success;
  List<TestList>? testList;

  TestHistoryModel({this.success, this.testList});

  TestHistoryModel.fromJson(Map<String, dynamic> json) {
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

// class TestList {
//   String? sId;
//   List<TestData>? testData;
//   String? user;
//   Test? test;
//   int? score;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   TestList(
//       {this.sId,
//       this.testData,
//       this.user,
//       this.test,
//       this.score,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   TestList.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     if (json['testData'] != null) {
//       testData = <TestData>[];
//       json['testData'].forEach((v) {
//         testData!.add(new TestData.fromJson(v));
//       });
//     }
//     user = json['user'];
//     test = json['test'] != null ? new Test.fromJson(json['test']) : null;
//     score = json['score'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     if (this.testData != null) {
//       data['testData'] = this.testData!.map((v) => v.toJson()).toList();
//     }
//     data['user'] = this.user;
//     if (this.test != null) {
//       data['test'] = this.test!.toJson();
//     }
//     data['score'] = this.score;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

// class TestQuestionList {
//   String? question;
//   List<Answer>? answer;
//   String? sId;

//   TestQuestionList({this.question, this.answer, this.sId});

//   TestQuestionList.fromJson(Map<String, dynamic> json) {
//     question = json['question'];
//     if (json['answer'] != null) {
//       answer = <Answer>[];
//       json['answer'].forEach((v) {
//         answer!.add(new Answer.fromJson(v));
//       });
//     }
//     sId = json['_id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['question'] = this.question;
//     if (this.answer != null) {
//       data['answer'] = this.answer!.map((v) => v.toJson()).toList();
//     }
//     data['_id'] = this.sId;
//     return data;
//   }
// }

class Answer {
  String? title;
  int? score;
  String? sId;

  Answer({this.title, this.score, this.sId});

  Answer.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    score = json['score'];
    sId = json['_id'];
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



/* class TestHistoryModel {
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
 */