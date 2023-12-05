class MoodAnalyticsChartDataModel {
  bool? success;
  List? averages;
  bool? isWeekly;

  MoodAnalyticsChartDataModel(
      {this.success, this.averages, this.isWeekly = false});

  MoodAnalyticsChartDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['dailyAverages'] != null) {
      averages = [];
      isWeekly = false;
      json['dailyAverages'].forEach((v) {
        averages!.add(v);
      });
    }
    if (json['weeklyAverages']) {
      isWeekly = true;
      json['weeklyAverages'].forEach((v) {
        averages!.add(v);
      });
    }
  }
}
