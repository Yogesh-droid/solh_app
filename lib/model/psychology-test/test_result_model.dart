class TestResultModel {
  bool? success;
  Result? result;

  TestResultModel({this.success, this.result});

  TestResultModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? testResult;
  String? explanation;
  int? score;

  Result({this.testResult, this.explanation, this.score});

  Result.fromJson(Map<String, dynamic> json) {
    testResult = json['testResult'];
    explanation = json['explanation'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testResult'] = this.testResult;
    data['explanation'] = this.explanation;
    data['score'] = this.score;
    return data;
  }
}
