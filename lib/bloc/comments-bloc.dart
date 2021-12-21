import 'package:solh/constants/api.dart';
import 'package:solh/model/comment.dart';

import 'package:rxdart/rxdart.dart';
import 'package:solh/services/network/network.dart';

class CommentsBloc {
  final _commentsController = PublishSubject<List<CommentModel?>>();
  int _currentPage = 1;
  int _endPageLimit = 1;

  CommentModel? _bestComment;

  CommentModel? get bestComment {
    return _bestComment;
  }

  List<CommentModel?> _commentsList = <CommentModel?>[];

  Stream<List<CommentModel?>> get commentsStateStream =>
      _commentsController.stream;

  Future<List<CommentModel?>> _fetchDetailsFirstTime(String postId) async {
    print("getting comments for the first time...");
    _currentPage = 1;
    try {
      Map<String, dynamic> apiResponse =
          await Network.makeHttpGetRequestWithToken(
              "${APIConstants.api}/api/get-comments-of-journal/$postId");

      List<CommentModel> _comments = <CommentModel>[];
      // print("total pages: " + apiResponse["totalPages"].toString());
      // _endPageLimit = apiResponse["totalPages"];
      // print("Number of pages: $_endPageLimit");
      print("response:" + apiResponse.toString());

      print(_bestComment);
      _bestComment = CommentModel.fromJson(apiResponse["bestComment"]);
      print(_bestComment);

      for (var comment in apiResponse["comments"]) {
        print(comment["commentBody"]);
        _comments.add(CommentModel.fromJson(comment));
      }
      return _comments;
    } catch (error) {
      throw error;
    }
  }

  Future<List<CommentModel?>> _fetchDetailsNextPage() async {
    print("getting comments for the next page...");
    try {
      Map<String, dynamic> apiResponse =
          await Network.makeHttpGetRequestWithToken(
              "${APIConstants.api}/api/get-comments?page=$_currentPage");

      List<CommentModel> _comments = <CommentModel>[];
      for (var journal in apiResponse["comments"]) {
        _comments.add(CommentModel.fromJson(journal));
      }
      return _comments;
    } catch (error) {
      _currentPage--;
      throw error;
    }
  }

  Future getcommentsSnapshot(String postId) async {
    _commentsList = [];
    await _fetchDetailsFirstTime(postId).then((comments) {
      _commentsList.addAll(comments);
      return _commentsController.add(_commentsList);
    }).onError((error, stackTrace) =>
        _commentsController.sink.addError(error.toString()));
  }

  Future getNextPagecommentsSnapshot() async {
    print("fetching next page comments.............");
    _currentPage++;

    if (_currentPage <= _endPageLimit) {
      await _fetchDetailsNextPage().then((comments) {
        _commentsList.addAll(comments);
        return _commentsController.add(_commentsList);
      }).onError((error, stackTrace) =>
          _commentsController.sink.addError(error.toString()));
    } else {
      print(" end of Page  DB");
    }
  }
}

CommentsBloc commentsBloc = CommentsBloc();
