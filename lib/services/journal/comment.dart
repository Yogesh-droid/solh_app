import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';

class CommentNetwork {
  Future<bool> addComment(
      {required String journalId, required String commentBody}) async {
    var response = await Network.makeHttpPostRequestWithToken(
        url: "${APIConstants.api}/api/comment-on-journal",
        body: {
          "commentBody": commentBody,
          "journal": journalId,
        });
    print(response);
    return false;
  }

  Future<bool> makeBestComment(
      {required String journalId, required String commentId}) async {
    var response = await Network.makeHttpPutRequestWithToken(
        url: "${APIConstants.api}/api/best-comment",
        body: {
          "commentId": commentId,
          "postId": journalId,
        });
    print(response);
    return false;
  }

  Future<bool> deleteComment(
      {required String journalId, required String commentId}) async {
    var response = await Network.makeHttpDeleteRequestWithToken(
        url: "${APIConstants.api}/api/delete-comment-on-journal",
        body: {"commentId": commentId, "journalId": journalId});
    print(response);
    return false;
  }
}
