import 'package:get/get.dart';
import 'package:solh/model/journals/get_jouranal_comment_model.dart';

import '../../constants/api.dart';
import '../../services/network/error_handling.dart';
import '../../services/network/network.dart';

class JournalCommentController extends GetxController {
  var repliesList = [].obs;
  var bestCommentReplyList = [].obs;
  var getJouranalsCommentModel = GetJouranalsCommentModel().obs;
  var isReplying = false.obs;
  String commentId = '';
  var repliedTo = ''.obs;
  var isLoading = false.obs;
  var hiddenReplyList = [].obs;
  var hiddenBestCommentReply = false.obs;
  int pageNo = 1;
  int endPage = 1;

  Future<void> getJournalComment(
      {required String postId, required int pageNo}) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> map = await Network.makeHttpGetRequestWithToken(
          "${APIConstants.api}/api/get-parent?journal=$postId&page=$pageNo");
      getJouranalsCommentModel.value = GetJouranalsCommentModel.fromJson(map);
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
    getJouranalsCommentModel.value.comments!.forEach((element) {
      repliesList.value.add([]);
      hiddenReplyList.value.add(false);
    });

    isLoading.value = false;
  }

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

  Future<bool> addReply(
      {required String parentId,
      required String journalId,
      required String commentBody}) async {
    var response = await Network.makeHttpPostRequestWithToken(
        url: "${APIConstants.api}/api/comment-on-journal",
        body: {
          "commentBody": commentBody,
          "journal": journalId,
          "parentId": parentId,
        });
    print(response);
    isReplying.value = false;
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
    getJournalComment(postId: journalId, pageNo: pageNo);
    getJouranalsCommentModel.refresh();
    print(response);
    return false;
  }

  Future<void> getReply(
      {required String postId, required int pageNo, int? index}) async {
    try {
      Map<String, dynamic> map = await Network.makeHttpGetRequestWithToken(
          "${APIConstants.api}/api/get-children?parent=$postId&page=$pageNo");
      print('index: ' + index.toString());
      if (index != null) {
        if (GetJouranalsCommentModel.fromJson(map).comments != null &&
            GetJouranalsCommentModel.fromJson(map).comments!.length > 0) {
          repliesList.value.removeAt(index);
          repliesList.value
              .insert(index, GetJouranalsCommentModel.fromJson(map).comments);
          repliesList.refresh();
        }
      } else {
        bestCommentReplyList.value =
            GetJouranalsCommentModel.fromJson(map).comments!;
      }
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
