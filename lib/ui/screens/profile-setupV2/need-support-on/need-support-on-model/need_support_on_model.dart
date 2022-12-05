class NeedSupportOnModel {
  bool? success;
  List<Specialization>? specialization;

  NeedSupportOnModel({this.success, this.specialization});

  NeedSupportOnModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['specialization'] != null) {
      specialization = <Specialization>[];
      json['specialization'].forEach((v) {
        specialization!.add(new Specialization.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.specialization != null) {
      data['specialization'] =
          this.specialization!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Specialization {
  String? sId;
  String? name;
  String? slug;

  Specialization({this.sId, this.name, this.slug});

  Specialization.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}
