class InhousePackageModel {
  bool? success;
  Carousel? carousel;
  List<PackageList>? packageList;

  InhousePackageModel({this.success, this.carousel, this.packageList});

  InhousePackageModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    carousel = json['carousel'] != null
        ? new Carousel.fromJson(json['carousel'])
        : null;
    if (json['packageList'] != null) {
      packageList = <PackageList>[];
      json['packageList'].forEach((v) {
        packageList!.add(new PackageList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.carousel != null) {
      data['carousel'] = this.carousel!.toJson();
    }
    if (this.packageList != null) {
      data['packageList'] = this.packageList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Carousel {
  String? sId;
  String? name;
  String? description;
  String? image;
  int? totalPackage;
  String? routeName;

  Carousel(
      {this.sId,
      this.name,
      this.description,
      this.image,
      this.totalPackage,
      this.routeName});

  Carousel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    totalPackage = json['totalPackage'];
    routeName = json['routeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['image'] = this.image;
    data['totalPackage'] = this.totalPackage;
    data['routeName'] = this.routeName;
    return data;
  }
}

class PackageList {
  String? sId;
  String? name;
  String? slug;
  String? duration;
  String? unitDuration;
  String? aboutPackage;
  String? packageOwner;
  String? equipment;
  String? benefits;
  String? currency;
  int? amount;
  PackageType? packageType;

  PackageList(
      {this.sId,
      this.name,
      this.slug,
      this.duration,
      this.unitDuration,
      this.equipment,
      this.aboutPackage,
      this.benefits,
      this.packageOwner,
      this.currency,
      this.amount,
      this.packageType});

  PackageList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    packageOwner = json['packageOwner'];
    equipment = json['equipment'];
    duration = json['duration'];
    unitDuration = json['unitDuration'];
    aboutPackage = json['aboutPackage'];
    benefits = json['benefits'];
    currency = json['currency'];
    amount = json['amount'];
    packageType = json['packageType'] != null
        ? new PackageType.fromJson(json['packageType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['duration'] = this.duration;
    data['unitDuration'] = this.unitDuration;
    data['aboutPackage'] = this.aboutPackage;
    data['benefits'] = this.benefits;
    data['currency'] = this.currency;
    data['amount'] = this.amount;
    if (this.packageType != null) {
      data['packageType'] = this.packageType!.toJson();
    }
    return data;
  }
}

class PackageType {
  String? sId;
  String? name;

  PackageType({this.sId, this.name});

  PackageType.fromJson(Map<String, dynamic> json) {
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
