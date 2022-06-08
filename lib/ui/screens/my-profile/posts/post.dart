import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/bloc/journals/my-journal-bloc.dart';
import 'package:solh/model/journal.dart';
import 'package:solh/ui/screens/journaling/widgets/journal_tile.dart';
import 'package:solh/ui/screens/journaling/widgets/my_journal_tile.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import '../../../../controllers/journals/journal_page_controller.dart';
import '../../../../model/journals/journals_response_model.dart';

class PostScreen extends StatefulWidget {
  PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  JournalPageController _journalPageController = Get.find();

  @override
  void initState() {
    super.initState();
    getMyJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Posts",
              style: SolhTextStyles.AppBarText.copyWith(
                  color: Colors.black, fontSize: 18),
            ),
            Text(
              "",
              style: SolhTextStyles.SOSGreyText.copyWith(fontSize: 12),
            )
          ],
        ),
      ),
      body: StreamBuilder<List<Journals?>>(
          stream: myJournalsBloc.journalsStateStream,
          builder: (_, journalsSnapshot) {
            if (journalsSnapshot.hasData) {
              journalsSnapshot.data!.forEach((journal) {
                print(journal!.postedBy!.name);
              });
              return Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: journalsSnapshot.requireData.length,
                    itemBuilder: (_, index) {
                      print(journalsSnapshot.data![index]);
                      return JournalTile(
                        journalModel: journalsSnapshot.data![index],
                        index: index,
                        deletePost: () {},
                        isMyJournal: true,
                      );
                    }),
              );
            }
            return Center(child: MyLoader());
          }),
    );
  }

  Future<void> getMyJournals() async {
    await myJournalsBloc.getJournalsSnapshot();
  }
}
