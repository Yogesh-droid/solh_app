class GetSpecializationResponseModel {
  List<SpecializationList>? specializationList;

  GetSpecializationResponseModel({this.specializationList});

  GetSpecializationResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['specializationList'] != null) {
      specializationList = <SpecializationList>[];
      json['specializationList'].forEach((v) {
        specializationList!.add(new SpecializationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.specializationList != null) {
      data['specializationList'] =
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

  SpecializationList({this.sId, this.name, this.slug, this.id});

  SpecializationList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['id'] = this.id;
    return data;
  }
}
