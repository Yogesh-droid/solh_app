class ChatListModel {
  bool? success;
  List<ChatList>? chatList;

  ChatListModel({this.success, this.chatList});

  ChatListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
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
  String? author;
  String? chatType;

  Conversation({this.body, this.dateTime, this.author, this.chatType});

  Conversation.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    dateTime = json['dateTime'];
    author = json['author'];
    chatType = json['chatType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['dateTime'] = this.dateTime;
    data['author'] = this.author;
    return data;
  }
}

class User {
  String? name;
  String? profilePicture;
  String? sId;
  String? uid;
  String? nameAnonymous;
  String? profilePictureAnonymous;
  bool? sosChatSupportGroup;

  User(
      {this.name,
      this.profilePicture,
      this.sId,
      this.uid,
      this.nameAnonymous,
      this.sosChatSupportGroup,
      this.profilePictureAnonymous});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameAnonymous = json['nameAnonymous'];
    profilePictureAnonymous = json['profilePictureAnonymous'];
    sosChatSupportGroup = json['sosChatSupportGroup'];
    profilePicture = json['profilePicture'];
    sId = json['_id'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    data['_id'] = this.sId;
    data['uid'] = this.uid;
    return data;
  }
}
