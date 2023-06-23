import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/model/journals/get_jouranal_comment_model.dart';
import 'package:solh/model/journals/reaction_list_model.dart';
import 'package:solh/services/network/exceptions.dart';
import '../../constants/api.dart';
import '../../services/network/error_handling.dart';
import '../../services/network/network.dart';

class JournalCommentController extends GetxController {
  var repliesList = [].obs;
  var bestCommentReplyList = [].obs;
  var getJouranalsCommentModel = GetJouranalsCommentModel().obs;
  var commentList = <Comments>[].obs;
  var reactionlistModel = ReactionListModel().obs;
  var isReactionLoading = false.obs;
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
  var isReportingPost = false.obs;
  var getJournalcommentStatus = 0;
  var anonymousProfilePositionL = 2.0.obs;
  var anonymousProfilePositionT = 15.0.obs;
  var nomalProfilePositionL = 10.0.obs;
  var nomalProfilePositionT = 2.0.obs;
  var isAnonymousSelected = false.obs;
  var anonymousProfileRadius = 2.0.w.obs;
  var nomalProfileRadius = 4.w.obs;
  int previousPage = -2;
  int nextPage = 1;

  Future<void> getJournalComment(
      {required String postId,
      required int pageNo,
      bool? shouldRefresh,
      int? page}) async {
    if (nextPage == 0 && shouldRefresh == null && page == null) {
      print("previousPage is ${previousPage}");
      print("nextPage is ${nextPage}");
      return;
    }
    if (previousPage == -2) {
      isLoading.value = true;
    }
    try {
      print("------------------------  ${isLoading.value}");
      print("------------------------  ${previousPage}");
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/v1/get-parent?journal=$postId&pageNumber=${page ?? pageNo}");
      getJouranalsCommentModel.value = GetJouranalsCommentModel.fromJson(map);
      if (page == null) {
        commentList.addAll(getJouranalsCommentModel.value.body!.comments ?? []);
      } else {
        commentList.insert(
            0, getJouranalsCommentModel.value.body!.comments![0]);
      }
      commentList.refresh();
      nextPage = getJouranalsCommentModel.value.body!.nextPage ?? 1;
      previousPage = getJouranalsCommentModel.value.body!.previousPage ?? 0;
      getJournalcommentStatus = 0;
    } on Exceptions catch (e) {
      print(e.getStatus());
      getJournalcommentStatus = e.getStatus();
    }

    /// repliesList is list<Map<List<comments,bool>>> where bool is false by default initially as all list is hidden,
    /// when we click "show replies" then we pass true to that list

    // repliesList.clear();

    if (getJouranalsCommentModel.value.body!.comments != null) {
      getJouranalsCommentModel.value.body!.comments!.forEach((element) {
        repliesList.add([]);
        hiddenReplyList.add(false);
      });
    }
    repliesList.refresh();
    hiddenReplyList.refresh();

    isLoading.value = false;
  }

  Future<bool> addComment(
      {required String journalId, required String commentBody}) async {
    reactingToComment.value = true;
    var response = await Network.makePostRequestWithToken(
        isEncoded: true,
        url: "${APIConstants.api}/api/comment-on-journal",
        body: {
          "commentBody": commentBody,
          "journal": journalId,
          "anonymousComment": isAnonymousSelected.value
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
      Map<String, dynamic> map = await Network.makeGetRequestWithToken(
          "${APIConstants.api}/api/v1/get-children?parent=$postId");
      print('index: ' + index.toString());
      if (index != null) {
        print('index: ' + index.toString());
        print('repliesList: ' + repliesList.toString());
        if (GetJouranalsCommentModel.fromJson(map).body!.comments != null &&
            GetJouranalsCommentModel.fromJson(map).body!.comments!.length > 0) {
          repliesList.removeAt(index);
          repliesList.insert(
              index, GetJouranalsCommentModel.fromJson(map).body!.comments);
          repliesList.refresh();
        } else {
          repliesList.removeAt(index);
          repliesList.insert(index, []);
          repliesList.refresh();
        }
      } else {
        bestCommentReplyList.value =
            GetJouranalsCommentModel.fromJson(map).body!.comments!;
      }
    } on Exception catch (e) {
      ErrorHandler.handleException(e.toString());
    }
  }

  Future<bool> reportPost(
      {required String journalId,
      required String reason,
      required String type}) async {
    isReportingPost.value = true;
    var response = await Network.makeHttpPostRequestWithToken(
        url: "${APIConstants.api}/api/reportpost",
        body: {"type": type, "postId": journalId, "reason": reason});
    isReportingPost.value = false;
    print(response);
    return false;
  }

  Future<void> getReactionList() async {
    isReactionLoading(true);
    Map<String, dynamic> map = await Network.makeGetRequest(
        '${APIConstants.api}/api/custom/reaction/list');
    reactionlistModel.value = ReactionListModel.fromJson(map);
    isReactionLoading(false);
  }

  Future<String> likePost(
      {required String journalId, required String reaction}) async {
    var response = await Network.makePostRequestWithToken(
        url: "${APIConstants.api}/api/like-journal",
        body: {"post": journalId, "reaction": reaction});
    print(response);
    return response['body']['message'];
  }

  Future<bool> unLikePost({required String journalId}) async {
    var response = await Network.makeHttpDeleteRequestWithToken(
        url: "${APIConstants.api}/api/unlike-journal",
        body: {
          "postId": journalId,
        });
    print(response);
    return false;
  }

  Future<String> likeComment(
      {required String commentId, required String reaction}) async {
    print(reaction);
    var response = await Network.makePostRequestWithToken(
        url: "${APIConstants.api}/api/like-comment",
        body: {"comment": commentId, "reaction": reaction});
    print(response);
    return response['message'];
  }

  @override
  void onInit() {
    super.onInit();
    getReactionList();
  }
}
