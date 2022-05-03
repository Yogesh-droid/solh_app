class UserAnalyticModel {
  bool? success;
  String? message;
  int? journalLikeCount;
  int? commentCount;
  int? connectionCount;

  UserAnalyticModel(
      {this.success,
      this.message,
      this.journalLikeCount,
      this.commentCount,
      this.connectionCount});

  UserAnalyticModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    journalLikeCount = json['journalLikeCount'];
    commentCount = json['commentCount'];
    connectionCount = json['connectionCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['journalLikeCount'] = this.journalLikeCount;
    data['commentCount'] = this.commentCount;
    data['connectionCount'] = this.connectionCount;
    return data;
  }
}
