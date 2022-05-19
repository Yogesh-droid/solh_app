import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class CreateJournal {
  String description;
  String feelings;
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
      Map<String, dynamic> apiResponse =
          await Network.makeHttpPostRequestWithToken(
                  url: "${APIConstants.api}/api/create-user-post",
                  body: groupId != ''
                      ? {
                          "description": description,
                          "mediaType": mimetype,
                          "mediaUrl": mediaUrl,
                          "feelings": feelings,
                          "journalType": journalType,
                          'postIn': 'Group',
                          "groupPostedIn": groupId
                        }
                      : {
                          "description": description,
                          "mediaType": mimetype,
                          "mediaUrl": mediaUrl,
                          "feelings": feelings,
                          "journalType": journalType
                        })
              .onError((error, stackTrace) {
        return {"error": error};
      });
      print("resposne: " + apiResponse.toString());
      return "posted";
    } else {
      Map<String, dynamic> apiResponse =
          await Network.makeHttpPostRequestWithToken(
                  url: "${APIConstants.api}/api/create-user-post",
                  body: groupId != ''
                      ? {
                          "description": description,
                          "feelings": feelings,
                          "journalType": journalType,
                          'postIn': 'Group',
                          "groupPostedIn": groupId
                        }
                      : {
                          "description": description,
                          "feelings": feelings,
                          "journalType": journalType
                        })
              .onError((error, stackTrace) {
        return {"error": error};
      });

      print("response: " + apiResponse.toString());
      return "posted";
    }
  }
}
