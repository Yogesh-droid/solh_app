class InhousePackagesCarouselModel {
  bool? success;
  List<PackageCarouselList>? packageCarouselList;

  InhousePackagesCarouselModel({this.success, this.packageCarouselList});

  InhousePackagesCarouselModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['packageCarouselList'] != null) {
      packageCarouselList = <PackageCarouselList>[];
      json['packageCarouselList'].forEach((v) {
        packageCarouselList!.add(new PackageCarouselList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.packageCarouselList != null) {
      data['packageCarouselList'] =
          this.packageCarouselList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PackageCarouselList {
  String? sId;
  String? name;
  String? description;
  String? image;
  String? status;
  int? totalPackage;
  int? orderBy;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? routeName;
  String? routeKey;

  PackageCarouselList(
      {this.sId,
      this.name,
      this.description,
      this.image,
      this.status,
      this.totalPackage,
      this.orderBy,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.routeName,
      this.routeKey});

  PackageCarouselList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    totalPackage = json['totalPackage'];
    orderBy = json['orderBy'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    routeName = json['routeName'];
    routeKey = json['routeKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['status'] = this.status;
    data['totalPackage'] = this.totalPackage;
    data['orderBy'] = this.orderBy;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['routeName'] = this.routeName;
    data['routeKey'] = this.routeKey;
    return data;
  }
}
