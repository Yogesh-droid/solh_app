class MessageModel {
  bool? success;
  ChatLog? chatLog;

  MessageModel({this.success, this.chatLog});

  MessageModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    chatLog =
        json['chatLog'] != null ? new ChatLog.fromJson(json['chatLog']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.chatLog != null) {
      data['chatLog'] = this.chatLog!.toJson();
    }
    return data;
  }
}

class ChatLog {
  String? sId;
  List<String>? users;
  List<Conversation>? conversation;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ChatLog(
      {this.sId,
      this.users,
      this.conversation,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ChatLog.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    users = json['users'].cast<String>();
    if (json['conversation'] != null) {
      conversation = <Conversation>[];
      json['conversation'].forEach((v) {
        conversation!.add(new Conversation.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['users'] = this.users;
    if (this.conversation != null) {
      data['conversation'] = this.conversation!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Conversation {
  String? body;
  String? dateTime;
  String? sId;
  String? author;
  String? authorType;
  String? authorId;

  Conversation(
      {this.body,
      this.dateTime,
      this.sId,
      this.author,
      this.authorType,
      this.authorId});

  Conversation.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    dateTime = json['dateTime'];
    sId = json['_id'];
    author = json['author'];
    authorType = json['authorType'];
    authorId = json['authorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['dateTime'] = this.dateTime;
    data['_id'] = this.sId;
    data['author'] = this.author;
    data['authorType'] = this.authorType;
    data['authorId'] = this.authorId;
    return data;
  }
}
