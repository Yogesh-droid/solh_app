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
  String parentId = '';
  var repliedTo = ''.obs;
  var isLoading = false.obs;
  var hiddenReplyList = [].obs;
  var hiddenBestCommentReply = false.obs;
  var reactingToComment = false.obs;
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

    /// repliesList is list<Map<List<comments,bool>>> where bool is false by default initially as all list is hidden,
    /// when we click "show replies" then we pass true to that list

    repliesList.clear();

    getJouranalsCommentModel.value.comments!.forEach((element) {
      repliesList.value.add([]);
      hiddenReplyList.value.add(false);
    });

    isLoading.value = false;
  }

  Future<bool> addComment(
      {required String journalId, required String commentBody}) async {
    reactingToComment.value = true;
    var response = await Network.makeHttpPostRequestWithToken(
        url: "${APIConstants.api}/api/comment-on-journal",
        body: {
          "commentBody": commentBody,
          "journal": journalId,
        });
    reactingToComment.value = false;
    print(response);
    return false;
  }

  Future<bool> addReply(
      {required String parentId,
      required String journalId,
      required String commentBody,
      required String userId,
      int? index}) async {
    reactingToComment.value = true;
    var response = await Network.makeHttpPostRequestWithToken(
        url: "${APIConstants.api}/api/comment-on-journal",
        body: {
          "commentBody": commentBody,
          "journal": journalId,
          "parentId": parentId,
          "replyToUser": userId,
        });
    print(response);
    reactingToComment.value = false;
    getReply(postId: parentId, pageNo: 1, index: index);
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
      {required String journalId,
      required String commentId,
      required bool isReply}) async {
    var response = await Network.makeHttpDeleteRequestWithToken(
        url: "${APIConstants.api}/api/delete-comment-on-journal",
        body: {"commentId": commentId, "journalId": journalId});
    if (!isReply) {
      getJournalComment(postId: journalId, pageNo: pageNo);
      getJouranalsCommentModel.refresh();
    } else {
      getReply(postId: journalId, pageNo: pageNo);
    }
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
        print('index: ' + index.toString());
        print('repliesList: ' + repliesList.value.toString());
        if (GetJouranalsCommentModel.fromJson(map).comments != null &&
            GetJouranalsCommentModel.fromJson(map).comments!.length > 0) {
          repliesList.value.removeAt(index);
          repliesList.value
              .insert(index, GetJouranalsCommentModel.fromJson(map).comments);
          repliesList.refresh();
        } else {
          repliesList.value.removeAt(index);
          repliesList.value.insert(index, []);
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
