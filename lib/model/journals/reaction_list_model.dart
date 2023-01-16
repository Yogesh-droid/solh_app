class ReactionListModel {
  bool? success;
  List<Data>? data;

  ReactionListModel({this.success, this.data});

  ReactionListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? reactionName;
  String? reactionImage;

  Data({this.sId, this.reactionName, this.reactionImage});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    reactionName = json['reactionName'];
    reactionImage = json['reactionImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['reactionName'] = this.reactionName;
    data['reactionImage'] = this.reactionImage;
    return data;
  }
}
