class CounsellorsCountryModel {
  bool? success;
  List<ProviderCountry>? providerCountry;

  CounsellorsCountryModel({this.success, this.providerCountry});

  CounsellorsCountryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['providerCountry'] != null) {
      providerCountry = <ProviderCountry>[];
      json['providerCountry'].forEach((v) {
        providerCountry!.add(new ProviderCountry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.providerCountry != null) {
      data['providerCountry'] =
          this.providerCountry!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProviderCountry {
  String? sId;
  String? name;
  String? code;

  ProviderCountry({this.sId, this.name, this.code});

  ProviderCountry.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}
