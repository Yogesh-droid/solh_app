import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import '../../../../widgets_constants/constants/colors.dart';
import '../../../../widgets_constants/constants/textstyles.dart';

class CommentMenuButton extends StatelessWidget {
  CommentMenuButton({
    Key? key,
    required String commentId,
    required Journals journalModel,
    required VoidCallback? makeBestComment,
    bool? isReply,
    required Function(String id, bool? isReply) deleteJournal,
  })  : _deleteJournal = deleteJournal,
        _commentId = commentId,
        _journalModel = journalModel,
        _makeBestComment = makeBestComment,
        _isReply = isReply,
        super(key: key);

  //final VoidCallback? _deleteJournal;
  final Function(String id, bool? isReply) _deleteJournal;
  final String _commentId;
  final Journals _journalModel;
  final VoidCallback? _makeBestComment;
  final bool? _isReply;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: Icon(
          Icons.more_vert,
          size: 16,
          color: SolhColors.dark_grey,
        ),
        iconSize: 20,
        color: SolhColors.white,
        padding: EdgeInsets.zero,
        offset: Offset(10, 0),
        itemBuilder: (context) => [
              PopupMenuItem(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 20,
                    vertical: MediaQuery.of(context).size.height / 80,
                  ),
                  decoration: _journalModel.postedBy!.uid ==
                          FirebaseAuth.instance.currentUser!.uid
                      ? BoxDecoration(
                          border: Border(
                          bottom: BorderSide(color: SolhColors.grey239),
                        ))
                      : null,
                  child: Text(
                    "Delete this comment".tr,
                  ),
                ),
                onTap: () {
                  _deleteJournal(_commentId, _isReply);
                },
                value: 1,
                textStyle: SolhTextStyles.JournalingPostMenuText,
                padding: EdgeInsets.zero,
              ),
              if (_journalModel.postedBy!.uid ==
                  FirebaseAuth.instance.currentUser!.uid)
                PopupMenuItem(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 20,
                      vertical: MediaQuery.of(context).size.height / 80,
                    ),
                    child: Text(
                      "Select for best comment".tr,
                    ),
                  ),
                  onTap: _makeBestComment,
                  value: 1,
                  textStyle: SolhTextStyles.JournalingPostMenuText,
                  padding: EdgeInsets.zero,
                ),
              // PopupMenuItem(
              //   child: Container(
              //     alignment: Alignment.centerLeft,
              //     padding: EdgeInsets.symmetric(
              //       horizontal: MediaQuery.of(context).size.width / 20,
              //       vertical: MediaQuery.of(context).size.height / 80,
              //     ),
              //     decoration: BoxDecoration(
              //         border: Border(
              //       bottom: BorderSide(color: SolhColors.grey239),
              //     )),
              //     child: Text(
              //       "Don't see this post again",
              //     ),
              //   ),
              //   value: 2,
              //   textStyle: SolhTextStyles.JournalingPostMenuText,
              //   padding: EdgeInsets.zero,
              // ),
              // PopupMenuItem(
              //   child: Container(
              //     alignment: Alignment.centerLeft,
              //     padding: EdgeInsets.symmetric(
              //       horizontal: MediaQuery.of(context).size.width / 20,
              //       vertical: MediaQuery.of(context).size.height / 80,
              //     ),
              //     decoration: BoxDecoration(
              //         border: Border(
              //       bottom: BorderSide(color: SolhColors.grey239),
              //     )),
              //     child: Text(
              //       "Block this person",
              //     ),
              //   ),
              //   value: 3,
              //   textStyle: SolhTextStyles.JournalingPostMenuText,
              //   padding: EdgeInsets.zero,
              // ),
              // PopupMenuItem(
              //   child: Container(
              //     alignment: Alignment.centerLeft,
              //     padding: EdgeInsets.symmetric(
              //       horizontal: MediaQuery.of(context).size.width / 20,
              //       vertical: MediaQuery.of(context).size.height / 80,
              //     ),
              //     decoration: BoxDecoration(
              //         border: Border(
              //       bottom: BorderSide(color: SolhColors.grey239),
              //     )),
              //     child: Text(
              //       "Report this post",
              //     ),
              //   ),
              //   value: 4,
              //   textStyle: SolhTextStyles.JournalingPostMenuText,
              //   padding: EdgeInsets.zero,
              // ),
            ]);
  }
}
