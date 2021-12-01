import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/network/network.dart';

class CreateJournal {
  String description;
  String feelings;
  String imageUrl;
  String journalType;

  CreateJournal(
      {required this.description,
      required this.feelings,
      required this.imageUrl,
      required this.journalType});

  Future<String> postJournal() async {
    Map<String, dynamic> apiResponse =
        await Network.makeHttpPostRequestWithToken(
            url: "${APIConstants.aws}/api/create-user-post",
            body: {
          "description": description,
          "image": imageUrl,
          "feelings": feelings,
          "journalType": journalType
        }).onError((error, stackTrace) {
      return {"error": error};
    });
    print("resposne: " + apiResponse.toString());
    return "posted";
  }
}
