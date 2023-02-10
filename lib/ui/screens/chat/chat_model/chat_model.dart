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
  String? appointmentId;
  List<Conversation>? conversation;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? chatType;

  ChatLog(
      {this.sId,
      this.users,
      this.appointmentId,
      this.conversation,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.chatType});

  ChatLog.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    users = json['users'].cast<String>();
    appointmentId = json['appointmentId'];
    if (json['conversation'] != null) {
      conversation = <Conversation>[];
      json['conversation'].forEach((v) {
        conversation!.add(new Conversation.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    chatType = json['chatType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['users'] = this.users;
    data['appointmentId'] = this.appointmentId;
    if (this.conversation != null) {
      data['conversation'] = this.conversation!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['chatType'] = this.chatType;
    return data;
  }
}

class Conversation {
  Media? media;
  String? author;
  String? authorType;
  String? authorId;
  String? body;
  String? dateTime;
  String? conversationType;
  String? connection;
  String? fileName;
  String? sId;
  List? supportUsers;

  Conversation(
      {this.media,
      this.author,
      this.authorType,
      this.supportUsers,
      this.authorId,
      this.connection,
      this.body,
      this.dateTime,
      this.conversationType,
      this.fileName,
      this.sId});

  Conversation.fromJson(Map<String, dynamic> json) {
    media = json['media'] != null ? new Media.fromJson(json['media']) : null;
    author = json['author'] ?? '';
    authorType = json['authorType'] ?? '';
    supportUsers = json['supportUsers'] ?? [];
    authorId = json['authorId'] ?? '';
    connection = json['connection'] ?? '';
    body = json['body'] ?? '';
    dateTime = json['dateTime'];
    conversationType = json['conversationType'] ?? '';
    fileName = json['fileName'] ?? '';
    sId = json['_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.media != null) {
      data['media'] = this.media!.toJson();
    }
    data['author'] = this.author;
    data['authorType'] = this.authorType;
    data['authorId'] = this.authorId;
    data['body'] = this.body;
    data['dateTime'] = this.dateTime;
    data['conversationType'] = this.conversationType;
    data['fileName'] = this.fileName;
    data['_id'] = this.sId;
    return data;
  }
}

class Media {
  String? mediaUrl;
  String? mediaType;

  Media({this.mediaUrl, this.mediaType});

  Media.fromJson(Map<String, dynamic> json) {
    mediaUrl = json['mediaUrl'];
    mediaType = json['mediaType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mediaUrl'] = this.mediaUrl;
    data['mediaType'] = this.mediaType;
    return data;
  }
}
