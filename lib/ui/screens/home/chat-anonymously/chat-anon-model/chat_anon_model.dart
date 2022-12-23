class ChatAnonModel {
  bool? success;
  List<SosChatSupport>? sosChatSupport;

  ChatAnonModel({this.success, this.sosChatSupport});

  ChatAnonModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['sosChatSupport'] != null) {
      sosChatSupport = <SosChatSupport>[];
      json['sosChatSupport'].forEach((v) {
        sosChatSupport!.add(new SosChatSupport.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.sosChatSupport != null) {
      data['sosChatSupport'] =
          this.sosChatSupport!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SosChatSupport {
  String? sId;
  String? name;
  String? profilePicture;
  String? profilePictureType;

  SosChatSupport(
      {this.sId, this.name, this.profilePicture, this.profilePictureType});

  SosChatSupport.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    profilePicture = json['profilePicture'];
    profilePictureType = json['profilePictureType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    data['profilePictureType'] = this.profilePictureType;
    return data;
  }
}
