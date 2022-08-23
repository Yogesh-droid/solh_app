import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:solh/controllers/journals/feelings_controller.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/controllers/my_diary/my_diary_controller.dart';
import 'package:solh/ui/my_diary/affirmation_page.dart';
import 'package:solh/ui/my_diary/my_diary_details.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class MyDiaryListPage extends StatefulWidget {
  MyDiaryListPage({Key? key, this.isPickFromDiary}) : super(key: key);
  final bool? isPickFromDiary;

  @override
  State<MyDiaryListPage> createState() => _MyDiaryListPageState();
}

class _MyDiaryListPageState extends State<MyDiaryListPage> {
  final MyDiaryController myDiaryController = Get.find();
  final ScrollController _scrollController = ScrollController();
  final JournalPageController journalPageController = Get.find();
  final FeelingsController feelingsController = Get.find();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        myDiaryController.movingUp.value = true;
      } else {
        myDiaryController.movingUp.value = false;
        print('moving down');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: Column(children: [
        getPageDropDown(),
        Obx((() => myDiaryController.selectedElement == 'My Diary'
            ? getMyDiaryList(context)
            : getThoughttsView()))
      ]),

      /// uncomment this to show filters
      //floatingActionButton: getFilterButton(context),
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

  Widget getPageDropDown() {
    return Obx(() => AnimatedContainer(
          decoration: BoxDecoration(
              color: SolhColors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: myDiaryController.movingUp.value
                        ? SolhColors.grey
                        : SolhColors.white,
                    offset: Offset(0, 2),
                    blurRadius: myDiaryController.movingUp.value ? 4 : 0)
              ]),
          duration: Duration(milliseconds: 300),
          curve: Curves.fastOutSlowIn,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: SolhColors.green, width: 0.5),
                  borderRadius: BorderRadius.circular(50)),
              child: DropdownButtonFormField(
                icon: Icon(Icons.keyboard_arrow_down, color: SolhColors.grey),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(0),
                  labelStyle: TextStyle(color: SolhColors.green),
                  hintStyle: TextStyle(color: SolhColors.green),
                ),
                value: myDiaryController.selectedElement.value,
                items: [
                  DropdownMenuItem(
                    value: 'My Diary',
                    child: Text(
                      "Diary Entries",
                      style: TextStyle(color: SolhColors.green),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Thoughts",
                    child: Text("Affirmations",
                        style: TextStyle(color: SolhColors.green)),
                  ),
                ],
                onChanged: (value) {
                  myDiaryController.selectedElement.value = value.toString();
                },
              ),
            ),
          ),
        ));
  }

  Widget getMyDiaryList(BuildContext context) {
    return Obx(() => Container(
          height: MediaQuery.of(context).size.height -
              100 -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom -
              kToolbarHeight -
              50,
          child: ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: myDiaryController.myJournalsList.value.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: InkWell(
                    onTap: () {
                      debugPrint('onTap Ran ${widget.isPickFromDiary}');
                      if (widget.isPickFromDiary != null) {
                        journalPageController.descriptionController.text =
                            myDiaryController
                                    .myJournalsList.value[index].description ??
                                '';
                        journalPageController.selectedDiary.value =
                            myDiaryController.myJournalsList.value[index];
                        feelingsController.selectedFeelingsId.value.add(
                            myDiaryController.myJournalsList.value[index]
                                    .feelings![0].sId ??
                                '');
                        feelingsController.selectedFeelingsId.refresh();
                      } else {
                        debugPrint('my diary ran');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyDiaryDetails(
                                    myDiary: myDiaryController
                                        .myJournalsList.value[index])));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: SolhColors.grey196, width: 0.5),
                          borderRadius: BorderRadius.circular(10)),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('d MMM').format(DateTime.parse(
                                myDiaryController
                                    .myJournalsList.value[index].createdAt!)),
                            style: TextStyle(
                                color: SolhColors.black34,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 2.0),
                          myDiaryController.myJournalsList.value[index]
                                  .feelings!.isNotEmpty
                              ? Text(
                                  myDiaryController.myJournalsList.value[index]
                                      .feelings![0].feelingName!,
                                  style: TextStyle(
                                      color: SolhColors.pink224,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500))
                              : Container(),
                          SizedBox(height: 2),
                          Text(
                            myDiaryController
                                .myJournalsList.value[index].description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: SolhColors.grey102,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }

  Widget getThoughttsView() {
    return Expanded(child: AffirmationPage());
  }

  Widget getFilterButton(BuildContext context) {
    return CircleAvatar(
      radius: 21,
      backgroundColor: SolhColors.green,
      child: CircleAvatar(
        backgroundColor: SolhColors.white,
        radius: 20,
        child: IconButton(
            icon: Icon(Icons.filter_alt_outlined, color: SolhColors.green),
            onPressed: () {}),
      ),
    );
  }
}
