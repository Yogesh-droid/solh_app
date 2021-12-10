import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class CommentNetwork {
  Future<bool> addComment(String journalId, String commentBody) async {
    var response = await Network.makeHttpPostRequestWithToken(
        url: "${APIConstants.api}/api/comment-on-journal",
        body: {
          "commentBody": commentBody,
          "journal": journalId,
        });
    print(response);
    return false;
  }
}
