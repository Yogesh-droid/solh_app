class GoalCatModel {
  bool? success;
  List<Categories>? categories;

  GoalCatModel({this.success, this.categories});

  GoalCatModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? sId;
  List<SampleGoal>? sampleGoal;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? iV;
  Null? parent;
  String? displayImage;

  Categories(
      {this.sId,
      this.sampleGoal,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.parent,
      this.displayImage});

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['sampleGoal'] != null) {
      sampleGoal = <SampleGoal>[];
      json['sampleGoal'].forEach((v) {
        sampleGoal!.add(new SampleGoal.fromJson(v));
      });
    }
    name = json['name'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    parent = json['parent'];
    displayImage = json['displayImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.sampleGoal != null) {
      data['sampleGoal'] = this.sampleGoal!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['parent'] = this.parent;
    data['displayImage'] = this.displayImage;
    return data;
  }
}

class SampleGoal {
  String? image;
  String? name;
  List<Activity>? activity;
  String? status;
  String? sId;

  SampleGoal({this.image, this.name, this.activity, this.status, this.sId});

  SampleGoal.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    if (json['activity'] != null) {
      activity = <Activity>[];
      json['activity'].forEach((v) {
        activity!.add(new Activity.fromJson(v));
      });
    }
    status = json['status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    if (this.activity != null) {
      data['activity'] = this.activity!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['_id'] = this.sId;
    return data;
  }
}

class Activity {
  String? task;
  String? occurence;
  String? sId;

  Activity({this.task, this.occurence, this.sId});

  Activity.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    occurence = json['occurence'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task'] = this.task;
    data['occurence'] = this.occurence;
    data['_id'] = this.sId;
    return data;
  }
}
