class PersonalGoalModel {
  bool? success;
  List<GoalList>? goalList;
  int? milestone;
  int? milestoneReached;

  PersonalGoalModel(
      {this.success, this.goalList, this.milestone, this.milestoneReached});

  PersonalGoalModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['goalList'] != null) {
      goalList = <GoalList>[];
      json['goalList'].forEach((v) {
        goalList!.add(new GoalList.fromJson(v));
      });
    }
    milestone = json['milestone'];
    milestoneReached = json['milestoneReached'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.goalList != null) {
      data['goalList'] = this.goalList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GoalList {
  String? goalName;
  String? goalImage;
  String? sId;
  List<Activity>? activity;
  int? milestone;
  int? milestoneReached;

  GoalList(
      {this.goalName,
      this.goalImage,
      this.sId,
      this.activity,
      this.milestone,
      this.milestoneReached});

  GoalList.fromJson(Map<String, dynamic> json) {
    goalName = json['goalName'];
    goalImage = json['goalImage'];
    sId = json['_id'];
    if (json['activity'] != null) {
      activity = <Activity>[];
      json['activity'].forEach((v) {
        activity!.add(new Activity.fromJson(v));
      });
    }
    milestone = json['milestone'];
    milestoneReached = json['milestoneReached'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goalName'] = this.goalName;
    data['goalImage'] = this.goalImage;
    data['_id'] = this.sId;
    if (this.activity != null) {
      data['activity'] = this.activity!.map((v) => v.toJson()).toList();
    }
    data['milestone'] = this.milestone;
    data['milestoneReached'] = this.milestoneReached;
    return data;
  }
}

class Activity {
  String? sId;
  String? task;
  bool? isComplete;

  Activity({this.sId, this.task, this.isComplete});

  Activity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    task = json['task'];
    isComplete = json['isComplete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['task'] = this.task;
    data['isComplete'] = this.isComplete;
    return data;
  }
}
