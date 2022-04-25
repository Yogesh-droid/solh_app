class GetConnectionResponse {
  bool? success;
  List<Connections>? connections;

  GetConnectionResponse({this.success, this.connections});

  GetConnectionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['connections'] != null) {
      connections = <Connections>[];
      json['connections'].forEach((v) {
        connections!.add(new Connections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.connections != null) {
      data['connections'] = this.connections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Connections {
  String? name;
  String? profilePicture;
  String? bio;
  String? sId;
  String? connectionId;
  String? flag;

  Connections({this.name, this.profilePicture, this.bio, this.sId, this.flag});

  Connections.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePicture = json['profilePicture'];
    bio = json['bio'];
    sId = json['user_id'];
    connectionId = json['connection_id'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    data['bio'] = this.bio;
    data['user_id'] = this.sId;
    data['connection_id'] = this.connectionId;
    data['flag'] = this.flag;
    return data;
  }
}
