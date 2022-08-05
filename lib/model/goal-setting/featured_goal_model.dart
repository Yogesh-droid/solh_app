class FeaturedGoalModel {
  bool? success;
  List<Goal>? goal;

  FeaturedGoalModel({this.success, this.goal});

  FeaturedGoalModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['goal'] != null) {
      goal = <Goal>[];
      json['goal'].forEach((v) {
        goal!.add(new Goal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.goal != null) {
      data['goal'] = this.goal!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Goal {
  String? sId;
  List<SampleGoal>? sampleGoal;

  Goal({this.sId, this.sampleGoal});

  Goal.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['sampleGoal'] != null) {
      sampleGoal = <SampleGoal>[];
      json['sampleGoal'].forEach((v) {
        sampleGoal!.add(new SampleGoal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.sampleGoal != null) {
      data['sampleGoal'] = this.sampleGoal!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SampleGoal {
  String? sId;
  String? name;
  String? image;
  String? status;
  bool? featured;
  List<Activity>? activity;

  SampleGoal(
      {this.sId,
      this.name,
      this.image,
      this.status,
      this.featured,
      this.activity});

  SampleGoal.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    status = json['status'];
    featured = json['featured'];
    if (json['activity'] != null) {
      activity = <Activity>[];
      json['activity'].forEach((v) {
        activity!.add(new Activity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['status'] = this.status;
    data['featured'] = this.featured;
    if (this.activity != null) {
      data['activity'] = this.activity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activity {
  String? sId;
  String? task;
  String? occurence;

  Activity({this.sId, this.task, this.occurence});

  Activity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    task = json['task'];
    occurence = json['occurence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['task'] = this.task;
    data['occurence'] = this.occurence;
    return data;
  }
}
