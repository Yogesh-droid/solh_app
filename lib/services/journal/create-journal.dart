import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:solh/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:solh/main.dart';
import 'package:solh/model/journals/journals_response_model.dart';

import 'package:solh/ui/screens/comment/comment-screen.dart';
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
          }).then((value) {
        // print("post response" + json.decode(value.body).toString());
        if (json.decode(value.body)['body']['inGroup']) {
          globalNavigatorKey.currentState!.push(
            MaterialPageRoute(
                builder: (context) => CommentScreen(
                    journalModel:
                        Journals(id: json.decode(value.body)['body']['postId']),
                    index: -1)),
          );
        }
      });

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
          }).then((value) => print("post response" + value.body));

      return "posted";
    }
  }
}
