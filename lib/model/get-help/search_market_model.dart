class SearchMarketModel {
  int? code;
  bool? success;
  List<Provider>? provider;
  List<Doctors>? doctors;
  List<Provider>? alliedProviders;
  PagesForProvider? pagesForProvider;
  PagesForAllied? pagesForAllied;
  int? totalProvider;
  int? totalAllied;

  SearchMarketModel({
    this.code,
    this.success,
    this.provider,
    this.doctors,
    this.alliedProviders,
    this.pagesForAllied,
    this.pagesForProvider,
    this.totalProvider,
    this.totalAllied,
  });

  SearchMarketModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    if (json['provider'] != null) {
      provider = <Provider>[];
      json['provider'].forEach((v) {
        provider!.add(new Provider.fromJson(v));
      });
    }
    if (json['alliedProvider'] != null) {
      alliedProviders = <Provider>[];
      json['alliedProvider'].forEach((v) {
        alliedProviders!.add(new Provider.fromJson(v));
      });
    }
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(new Doctors.fromJson(v));
      });
    }
    if (json['doctors'] != null) {
      doctors = <Doctors>[];
      json['doctors'].forEach((v) {
        doctors!.add(new Doctors.fromJson(v));
      });
    }
    totalAllied = json['totalAllied'];
    totalProvider = json['totalProvider'];

    pagesForProvider = json['pagesForProvider'] != null
        ? new PagesForProvider.fromJson(json['pagesForProvider'])
        : null;
    pagesForAllied = json['pagesForAllied'] != null
        ? new PagesForAllied.fromJson(json['pagesForAllied'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['success'] = this.success;
    if (this.provider != null) {
      data['provider'] = this.provider!.map((v) => v.toJson()).toList();
    }
    if (this.doctors != null) {
      data['doctors'] = this.doctors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctors {
  bool? offlineSession;
  String? name;
  String? organisation;
  String? addressLineOne;
  String? addressLineTwo;
  String? addressLineThree;
  String? addressLineFour;
  String? bio;
  String? contactNumber;
  String? email;
  String? sId;
  String? profilePicture;
  String? specialization;
  String? fee;
  String? feeCurrency;
  int? fee_amount;
  String? prefix;
  int? afterDiscountPrice;

  Doctors(
      {this.offlineSession,
      this.name,
      this.fee_amount,
      this.organisation,
      this.addressLineOne,
      this.addressLineTwo,
      this.addressLineThree,
      this.addressLineFour,
      this.bio,
      this.contactNumber,
      this.email,
      this.sId,
      this.fee,
      this.feeCurrency,
      this.specialization,
      this.profilePicture,
      this.afterDiscountPrice,
      this.prefix});

  Doctors.fromJson(Map<String, dynamic> json) {
    offlineSession = json['offlineSession'];
    fee = json['fee'] ?? '';
    fee_amount = json['fee_amount'];
    feeCurrency = json['feeCurrency'] ?? '';
    name = json['name'] ?? '';
    organisation = json['organisation'] ?? '';
    addressLineOne = json['addressLineOne'] ?? '';
    addressLineTwo = json['addressLineTwo'] ?? '';
    addressLineThree = json['addressLineThree'] ?? '';
    addressLineFour = json['addressLineFour'];
    bio = json['bio'] ?? '';
    contactNumber = json['contactNumber'] ?? '';
    email = json['email'] ?? '';
    sId = json['_id'] ?? '';
    profilePicture = json['profilePicture'] ?? '';
    specialization = json['specialization'] ?? '';
    prefix = json['prefix'] ?? '';
    afterDiscountPrice = json['afterDiscountPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offlineSession'] = this.offlineSession;
    data['name'] = this.name;
    data['organisation'] = this.organisation;
    data['addressLineOne'] = this.addressLineOne;
    data['addressLineTwo'] = this.addressLineTwo;
    data['addressLineThree'] = this.addressLineThree;
    data['addressLineFour'] = this.addressLineFour;
    data['bio'] = this.bio;
    data['contactNumber'] = this.contactNumber;
    data['email'] = this.email;
    data['_id'] = this.sId;
    data['profilePicture'] = this.profilePicture;
    data['specialization'] = this.specialization;
    data['prefix'] = this.prefix;
    return data;
  }
}

class Provider {
  String? sId;
  String? gender;
  List<String>? language;
  bool? offlineSession;
  List<String>? education;
  List<String>? specialization;
  String? contactNumber;
  String? country;
  String? uid;
  String? token;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? addressLineFour;
  String? addressLineOne;
  String? addressLineThree;
  String? addressLineTwo;
  String? email;
  String? name;
  String? bio;
  dynamic experience;
  String? profession;
  double? score;
  String? id;
  String? profilePicture;
  String? fee;
  String? feeCurrency;
  int? fee_amount;
  String? prefix;
  String? preview;
  int? afterDiscountPrice;
  int? demoPackageCount;
  int? recodedPackageCount;
  int? livePackageCount;
  int? totalPackageCount;

  Provider(
      {this.sId,
      this.gender,
      this.fee_amount,
      this.language,
      this.offlineSession,
      this.education,
      this.specialization,
      this.contactNumber,
      this.country,
      this.uid,
      this.token,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.addressLineFour,
      this.addressLineOne,
      this.addressLineThree,
      this.addressLineTwo,
      this.email,
      this.name,
      this.bio,
      this.experience,
      this.profession,
      this.score,
      this.id,
      this.fee,
      this.feeCurrency,
      this.prefix,
      this.profilePicture,
      this.afterDiscountPrice,
      this.demoPackageCount,
      this.livePackageCount,
      this.recodedPackageCount,
      this.totalPackageCount,
      this.preview});

  Provider.fromJson(Map<String, dynamic> json) {
    demoPackageCount = json['demoPackageCount'];
    livePackageCount = json['livePackageCount'];
    recodedPackageCount = json['recodedPackageCount'];
    totalPackageCount = json['totalPackageCount'];
    sId = json['_id'];
    gender = json['gender'];
    fee = json['fee'];
    fee_amount = json['fee_amount'];
    feeCurrency = json['feeCurrency'];
    language = json['language'] != null ? json['language'].cast<String>() : [];
    offlineSession = json['offlineSession'];
    education =
        json['education'] != null ? json['education'].cast<String>() : [];
    specialization = json['specialization'].cast<String>();
    contactNumber = json['contactNumber'];
    country = json['country'];
    uid = json['uid'];
    token = json['token'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    addressLineFour = json['addressLineFour'];
    addressLineOne = json['addressLineOne'];
    addressLineThree = json['addressLineThree'];
    addressLineTwo = json['addressLineTwo'];
    email = json['email'];
    name = json['name'];
    bio = json['bio'];
    experience = json['experience'];
    profession = json['profession']['name'];
    score = json['score'];
    id = json['id'];
    prefix = json['prefix'];
    profilePicture = json['profilePicture'];
    preview = json['preview'];
    afterDiscountPrice = json['afterDiscountPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['gender'] = this.gender;

    data['language'] = this.language;
    data['offlineSession'] = this.offlineSession;
    data['education'] = this.education;
    data['specialization'] = this.specialization;
    data['contactNumber'] = this.contactNumber;
    data['country'] = this.country;
    data['uid'] = this.uid;
    data['token'] = this.token;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['addressLineFour'] = this.addressLineFour;
    data['addressLineOne'] = this.addressLineOne;
    data['addressLineThree'] = this.addressLineThree;
    data['addressLineTwo'] = this.addressLineTwo;
    data['email'] = this.email;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['experience'] = this.experience;
    data['profession'] = this.profession;
    data['score'] = this.score;
    data['id'] = this.id;
    data['profilePicture'] = this.profilePicture;
    data['prefix'] = this.prefix;
    data['preview'] = this.preview;
    return data;
  }
}

class PagesForProvider {
  int? prev;
  int? next;

  PagesForProvider({this.prev, this.next});

  PagesForProvider.fromJson(Map<String, dynamic> json) {
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class PagesForAllied {
  int? prev;
  int? next;

  PagesForAllied({this.prev, this.next});

  PagesForAllied.fromJson(Map<String, dynamic> json) {
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}
