class MyConnectionModel {
  bool? success;
  List<MyConnections>? myConnections;

  MyConnectionModel({this.success, this.myConnections});

  MyConnectionModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['myConnections'] != null) {
      myConnections = <MyConnections>[];
      json['myConnections'].forEach((v) {
        myConnections!.add(new MyConnections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.myConnections != null) {
      data['myConnections'] =
          this.myConnections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyConnections {
  String? sId;
  String? name;
  String? profilePicture;
  String? bio;
  String? userName;

  MyConnections(
      {this.sId, this.name, this.profilePicture, this.bio, this.userName});

  MyConnections.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    profilePicture = json['profilePicture'];
    bio = json['bio'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    data['bio'] = this.bio;
    data['userName'] = this.userName;
    return data;
  }
}
