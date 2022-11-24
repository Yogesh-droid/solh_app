import 'dart:convert';
import 'package:solh/constants/api.dart';
import 'package:http/http.dart' as http;
import '../../bloc/user-bloc.dart';

class CreateJournal {
  String description;
  List<String> feelings;
  String? mimetype;
  String? mediaUrl;
  String? journalType;
  String? postedIn;
  String? groupId;
  String? postId;
  bool? isAnonymous;
  double? mediaHeight;
  double? mediaWidth;
  double? aspectRatio;

  CreateJournal(
      {this.mediaUrl,
      required this.description,
      required this.feelings,
      this.mimetype,
      required this.journalType,
      this.postedIn,
      this.groupId,
      this.postId,
      this.isAnonymous,
      this.mediaHeight,
      this.mediaWidth,
      this.aspectRatio});

  Future<String> postJournal() async {
    if (mediaUrl != null) {
      // Map<String, dynamic> apiResponse =
      //     await Network.makeHttpPostRequestWithToken(
      //             url: "${APIConstants.api}/api/create-user-post",
      //             body: groupId != ''
      //                 ? {
      //                     "description": description,
      //                     "mediaType": mimetype,
      //                     "mediaUrl": mediaUrl,
      //                     "feelings": feelings,
      //                     "journalType": journalType,
      //                     'postIn': 'Group',
      //                     "groupPostedIn": groupId
      //                   }
      //                 : {
      //                     "description": description,
      //                     "mediaType": mimetype,
      //                     "mediaUrl": mediaUrl,
      //                     "feelings": feelings,
      //                     "journalType": journalType
      //                   })
      //         .onError((error, stackTrace) {
      //   return {"error": error};
      // });
      // print("resposne: " + apiResponse.toString());
      Map<String, dynamic> body = groupId != ''
          ? {
              "description": description,
              "mediaType": mimetype,
              "mediaUrl": mediaUrl,
              "feelings": feelings,
              "journalType": journalType,
              'postIn': 'Group',
              "groupPostedIn": groupId,
              "anonymousJournal": isAnonymous,
              "mediaHeight": mediaHeight,
              "mediaWidth": mediaHeight,
              "aspectRatio": aspectRatio
            }
          : {
              "description": description,
              "mediaType": mimetype,
              "mediaUrl": mediaUrl,
              "feelings": feelings,
              "journalType": journalType,
              "anonymousJournal": isAnonymous,
              "mediaHeight": mediaHeight,
              "mediaWidth": mediaHeight,
              "aspectRatio": aspectRatio
            };
      print('${APIConstants.api}/api/create-user-post');
      print(body);

      await http.post(Uri.parse('${APIConstants.api}/api/create-user-post'),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${userBlocNetwork.getSessionCookie}',
          }).then((value) {});

      return "posted";
    } else {
      Map<String, dynamic> body = groupId != ''
          ? {
              "description": description,
              "feelings": feelings,
              "journalType": journalType,
              'postIn': 'Group',
              "groupPostedIn": groupId,
              "anonymousJournal": isAnonymous
            }
          : {
              "description": description,
              "feelings": feelings,
              "journalType": journalType,
              "anonymousJournal": isAnonymous
            };
      print('${APIConstants.api}/api/create-user-post');
      print(body);
      await http.post(Uri.parse("${APIConstants.api}/api/create-user-post"),
          body: jsonEncode(body),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${userBlocNetwork.getSessionCookie}',
          }).then((value) {});

      return "posted";
    }
  }

  Future<String> postJournalFromDiary() async {
    if (mediaUrl != null) {
      print('${APIConstants.api}/api/pick-from-diary');
      await http.put(Uri.parse('${APIConstants.api}/api/pick-from-diary'),
          body: groupId != ''
              ? jsonEncode({
                  "postId": postId,
                  "description": description,
                  "mediaType": mimetype,
                  "mediaUrl": mediaUrl,
                  "feelings": feelings,
                  "journalType": journalType,
                  'postIn': 'Group',
                  "groupPostedIn": groupId,
                  "anonymousJournal": isAnonymous,
                  "mediaHeight": mediaHeight,
                  "mediaWidth": mediaHeight,
                  "aspectRatio": aspectRatio
                })
              : jsonEncode({
                  "postId": postId,
                  "description": description,
                  "mediaType": mimetype,
                  "mediaUrl": mediaUrl,
                  "feelings": feelings,
                  "journalType": journalType,
                  "anonymousJournal": isAnonymous
                }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${userBlocNetwork.getSessionCookie}',
          }).then((value) => print(value.body));

      return "posted";
    } else {
      print('${APIConstants.api}/api/pick-from-diary');
      await http.put(Uri.parse("${APIConstants.api}/api/pick-from-diary"),
          body: groupId != ''
              ? jsonEncode({
                  "postId": postId,
                  "description": description,
                  "feelings": feelings,
                  "journalType": journalType,
                  'postIn': 'Group',
                  "groupPostedIn": groupId,
                  "anonymousJournal": isAnonymous
                })
              : jsonEncode({
                  'postId': postId,
                  "description": description,
                  "feelings": feelings,
                  "journalType": journalType,
                  "anonymousJournal": isAnonymous
                }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${userBlocNetwork.getSessionCookie}',
          }).then((value) => print(value.body));

      return "posted";
    }
  }
}
