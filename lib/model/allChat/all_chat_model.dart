class ChatListModel {
  bool? success;
  int? totalChatList;
  int? prev;
  int? next;
  int? limit;
  List<ChatList>? chatList;

  ChatListModel(
      {this.success,
      this.totalChatList,
      this.prev,
      this.next,
      this.limit,
      this.chatList});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalChatList = json['totalChatList'];
    prev = json['prev'];
    next = json['next'];
    limit = json['limit'];
    if (json['chatList'] != null) {
      chatList = <ChatList>[];
      json['chatList'].forEach((v) {
        chatList!.add(new ChatList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['totalChatList'] = this.totalChatList;
    data['prev'] = this.prev;
    data['next'] = this.next;
    data['limit'] = this.limit;
    if (this.chatList != null) {
      data['chatList'] = this.chatList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatList {
  Conversation? conversation;
  User? user;

  ChatList({this.conversation, this.user});

  ChatList.fromJson(Map<String, dynamic> json) {
    conversation = json['conversation'] != null
        ? new Conversation.fromJson(json['conversation'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.conversation != null) {
      data['conversation'] = this.conversation!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Conversation {
  String? body;
  int? dateTime;
  String? fileName;
  Media? media;
  String? chatType;
  String? connection;
  String? conversationType;
  String? author;
  String? authorId;

  Conversation(
      {this.body,
      this.dateTime,
      this.fileName,
      this.media,
      this.chatType,
      this.connection,
      this.conversationType,
      this.author,
      this.authorId});

  Conversation.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    dateTime = json['dateTime'];
    fileName = json['fileName'];
    media = json['media'] != null ? new Media.fromJson(json['media']) : null;
    chatType = json['chatType'];
    connection = json['connection'];
    conversationType = json['conversationType'];
    author = json['author'];
    authorId = json['authorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['dateTime'] = this.dateTime;
    data['fileName'] = this.fileName;
    if (this.media != null) {
      data['media'] = this.media!.toJson();
    }
    data['chatType'] = this.chatType;
    data['connection'] = this.connection;
    data['conversationType'] = this.conversationType;
    data['author'] = this.author;
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

class User {
  String? name;
  String? profilePicture;
  String? nameAnonymous;
  String? profilePictureAnonymous;
  String? sId;
  String? uid;
  String? type;
  bool? sosChatSupportGroup;

  User(
      {this.name,
      this.profilePicture,
      this.nameAnonymous,
      this.profilePictureAnonymous,
      this.sId,
      this.uid,
      this.type,
      this.sosChatSupportGroup});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profilePicture = json['profilePicture'];
    nameAnonymous = json['nameAnonymous'];
    profilePictureAnonymous = json['profilePictureAnonymous'];
    sId = json['_id'];
    uid = json['uid'];
    type = json['type'];
    sosChatSupportGroup = json['sosChatSupportGroup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    data['nameAnonymous'] = this.nameAnonymous;
    data['profilePictureAnonymous'] = this.profilePictureAnonymous;
    data['_id'] = this.sId;
    data['uid'] = this.uid;
    data['type'] = this.type;
    data['sosChatSupportGroup'] = this.sosChatSupportGroup;
    return data;
  }
}
