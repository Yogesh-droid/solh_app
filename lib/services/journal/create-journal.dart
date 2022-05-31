import 'dart:convert';

import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
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

  CreateJournal(
      {this.mediaUrl,
      required this.description,
      required this.feelings,
      this.mimetype,
      required this.journalType,
      this.postedIn,
      this.groupId});

  Future<String> postJournal() async {
    if (mediaUrl != null) {
      print(feelings.toString());
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

      await http.post(Uri.parse('${APIConstants.api}/api/create-user-post'),
          body: groupId != ''
              ? jsonEncode({
                  "description": description,
                  "mediaType": mimetype,
                  "mediaUrl": mediaUrl,
                  "feelings": feelings,
                  "journalType": journalType,
                  'postIn': 'Group',
                  "groupPostedIn": groupId
                })
              : jsonEncode({
                  "description": description,
                  "mediaType": mimetype,
                  "mediaUrl": mediaUrl,
                  "feelings": feelings,
                  "journalType": journalType
                }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${userBlocNetwork.getSessionCookie}',
          }).then((value) => print(value.body));

      return "posted";
    } else {
      print(feelings.toString());
      // Map<String, dynamic> apiResponse =
      //     await Network.makeHttpPostRequestWithToken(
      //             url: "${APIConstants.api}/api/create-user-post",
      //             body: groupId != ''
      //                 ? {
      //                     "description": description,
      //                     "feelings": feelings,
      //                     "journalType": journalType,
      //                     'postIn': 'Group',
      //                     "groupPostedIn": groupId
      //                   }
      //                 : {
      //                     "description": description,
      //                     "feelings": feelings,
      //                     "journalType": journalType
      //                   })
      //         .onError((error, stackTrace) {
      //   return {"error": error};
      // });
      await http.post(Uri.parse("${APIConstants.api}/api/create-user-post"),
          body: groupId != ''
              ? jsonEncode({
                  "description": description,
                  "feelings": feelings,
                  "journalType": journalType,
                  'postIn': 'Group',
                  "groupPostedIn": groupId
                })
              : jsonEncode({
                  "description": description,
                  "feelings": feelings,
                  "journalType": journalType
                }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${userBlocNetwork.getSessionCookie}',
          }).then((value) => print(value.body));

      //print("response: " + apiResponse.toString());
      return "posted";
    }
  }
}
