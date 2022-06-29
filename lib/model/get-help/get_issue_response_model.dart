class GetIssueResponseModel {
  List<SpecializationList>? specializationList;

  GetIssueResponseModel({this.specializationList});

  GetIssueResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['specialization'] != null) {
      specializationList = <SpecializationList>[];
      json['specialization'].forEach((v) {
        specializationList!.add(new SpecializationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.specializationList != null) {
      data['specialization'] =
          this.specializationList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SpecializationList {
  String? sId;
  String? name;
  String? slug;
  String? id;
  String? displayImage;

  SpecializationList(
      {this.sId, this.name, this.slug, this.id, this.displayImage});

  SpecializationList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    id = json['id'];
    displayImage = json['displayImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['id'] = this.id;
    data['displayImage'] = this.displayImage;
    return data;
  }
}
