import 'package:solh/model/psychology-test/testHistory_result_model.dart';

class TestResultModel {
  bool? success;
  Result? result;
  List<MoreTests>? moreTests;

  TestResultModel({
    this.success,
    this.result,
    this.moreTests,
  });

  TestResultModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];

    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
    if (json['moreTests'] != null) {
      moreTests = <MoreTests>[];
      json['moreTests'].forEach((v) {
        moreTests!.add(new MoreTests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    if (this.moreTests != null) {
      data['moreTests'] = this.moreTests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? testResult;
  String? explanation;
  int? score;
  String? image;

  Result({this.testResult, this.explanation, this.score, this.image});

  Result.fromJson(Map<String, dynamic> json) {
    testResult = json['testResult'];
    explanation = json['explanation'];
    score = json['score'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testResult'] = this.testResult;
    data['explanation'] = this.explanation;
    data['score'] = this.score;
    return data;
  }
}
