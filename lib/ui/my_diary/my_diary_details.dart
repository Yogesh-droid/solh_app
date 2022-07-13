import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/controllers/my_diary/my_diary_controller.dart';
import 'package:solh/model/journals/journals_response_model.dart';
import 'package:solh/ui/screens/journaling/create-journal.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import '../../controllers/journals/feelings_controller.dart';
import '../../widgets_constants/constants/colors.dart';

class MyDiaryDetails extends StatelessWidget {
  MyDiaryDetails({Key? key, required this.myDiary}) : super(key: key);
  final Journals myDiary;
  final JournalPageController journalPageController = Get.find();
  final MyDiaryController myDiaryController = Get.find();
  final FeelingsController feelingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: Column(children: [
        Expanded(child: getDiarydetails()),
        //getCloseBtn(context)
      ]),
      bottomNavigationBar: getBottomButtons(context),
    );
  }

  getDiarydetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('d MMM, yyyy')
                  .format(DateTime.parse(myDiary.createdAt!)),
              style: TextStyle(
                  color: SolhColors.black166,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            myDiary.feelings!.isNotEmpty
                ? Text(myDiary.feelings![0].feelingName!,
                    style: TextStyle(
                        color: SolhColors.pink224,
                        fontSize: 16,
                        fontWeight: FontWeight.w500))
                : Container(),
            SizedBox(height: 12.0),
            Text(
              myDiary.description!,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: SolhColors.grey102,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10.0),
            CachedNetworkImage(
                height: 300,
                width: double.infinity,
                imageUrl: myDiary.mediaUrl ?? '',
                placeholder: (context, url) => getImgShimmer(),
                errorWidget: (context, url, error) => Container(),
                fit: BoxFit.cover),
          ],
        ),
      ),
    );
  }

  getAppBar(BuildContext context) {
    return SolhAppBar(
        isLandingScreen: false,
        title: Text(
          "My Diary",
          style: TextStyle(color: SolhColors.black),
        ));
  }

  getBottomButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          getArrowBtn(Icons.arrow_back, () {}),
          SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: () async {
                await postPublically(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: SolhColors.green,
                ),
                height: 50,
                child: Center(
                  child: Obx(() => myDiaryController.isPosting.value
                      ? Container(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(SolhColors.white),
                          ),
                        )
                      : Text(
                          "Post Publically",
                          style: TextStyle(color: SolhColors.white),
                        )),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          getArrowBtn(Icons.arrow_forward, () {}),
        ],
      ),
    );
  }

  getCloseBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: SolhColors.green, width: 0.5),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                "Close",
                style: TextStyle(color: SolhColors.green),
              ),
            )),
      ),
    );
  }

  getArrowBtn(IconData icon, Callback callback) {
    return Container(
      width: 70,
      decoration: BoxDecoration(
        border: Border.all(color: SolhColors.green, width: 0.5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        icon: Icon(icon, color: SolhColors.green),
        onPressed: callback,
      ),
    );
  }

  Future<void> postPublically(BuildContext context) async {
    // List<String> feelings = [];
    // for (Feelings feeling in myDiary.feelings!) {
    //   feelings.add(feeling.sId!);
    // }
    // CreateJournal _createJournal = CreateJournal(
    //     description: myDiary.description ?? '',
    //     feelings: feelings,
    //     journalType: 'Publicaly',
    //     mediaUrl: myDiary.mediaUrl ?? '',
    //     mimetype: 'image/jpeg',
    //     groupId: '',
    //     postedIn: null);
    // myDiaryController.isPosting.value = true;
    // _createJournal.postJournal();
    // await myDiaryController.getMyJournals(1);
    // myDiaryController.myJournalsList.refresh();
    // journalPageController.journalsList.clear();
    // journalPageController.pageNo = 1;
    // journalPageController.endPageLimit = 1;
    // await journalPageController.getAllJournals(1);
    // journalPageController.journalsList.refresh();
    // myDiaryController.isPosting.value = false;
    // Utility.showToast('Posted Publically');
    // Navigator.pop(context);
    journalPageController.descriptionController.text =
        myDiary.description ?? '';
    journalPageController.selectedDiary.value = myDiary;
    myDiary.feelings!.forEach((element) {
      feelingsController.selectedFeelingsId.add(element.sId);
    });
    // feelingsController.selectedFeelingsId.value
    //     .add(myDiary.feelings![0].sId ?? '');
    feelingsController.selectedFeelingsId.refresh();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreatePostScreen(
                  isPostedFromDiaryDetails: true,
                )));
  }

  Widget getImgShimmer() {
    return Container(
      height: 300,
      width: double.infinity,
      child: Shimmer.fromColors(
        baseColor: SolhColors.grey239,
        highlightColor: SolhColors.grey102,
        child: Container(
          height: 300,
          width: double.infinity,
          color: SolhColors.grey239,
        ),
      ),
    );
  }
}
