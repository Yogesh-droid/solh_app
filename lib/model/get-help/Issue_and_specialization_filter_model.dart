class IssueAndSpecializationFilterModel {
  bool? success;
  List<IssueList>? issueList;
  List<SplList>? splList;

  IssueAndSpecializationFilterModel(
      {this.success, this.issueList, this.splList});

  IssueAndSpecializationFilterModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['issueList'] != null) {
      issueList = <IssueList>[];
      json['issueList'].forEach((v) {
        issueList!.add(new IssueList.fromJson(v));
      });
    }
    if (json['splList'] != null) {
      splList = <SplList>[];
      json['splList'].forEach((v) {
        splList!.add(new SplList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.issueList != null) {
      data['issueList'] = this.issueList!.map((v) => v.toJson()).toList();
    }
    if (this.splList != null) {
      data['splList'] = this.splList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IssueList {
  String? sId;
  String? name;

  IssueList({this.sId, this.name});

  IssueList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class SplList {
  String? sId;
  String? name;
  String? id;

  SplList({this.sId, this.name, this.id});

  SplList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
