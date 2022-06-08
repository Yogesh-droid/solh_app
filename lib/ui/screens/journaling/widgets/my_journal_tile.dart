import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../model/journals/journals_response_model.dart';

class MyJournalTile extends StatefulWidget {
  MyJournalTile(
      {Key? key,
      this.journalModel,
      required this.deletePost,
      required this.index})
      : super(key: key);

  final Journals? journalModel;
  final VoidCallback deletePost;
  final int index;
  List<String> feelingList = [];

  @override
  State<MyJournalTile> createState() => _MyJournalTileState();
}

class _MyJournalTileState extends State<MyJournalTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          widget.journalModel!.postedBy!.profilePicture!),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.journalModel!.postedBy!.name ?? '',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          widget.journalModel!.postedBy!.email ?? '',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  widget.deletePost();
                },
              ),
            ),
          ],
        ),
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 80,
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(widget.journalModel!.mediaUrl.toString()),
          fit: BoxFit.cover,
        )),
      )
    ]));
  }
}
