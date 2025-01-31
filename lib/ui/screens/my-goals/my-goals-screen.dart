import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bottom-navigation/profile_icon.dart';
import 'package:solh/controllers/goal-setting/goal_setting_controller.dart';
import 'package:solh/model/goal-setting/personal_goal_model.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/my-goals/add_select_goal.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import 'select_goal.dart';

class MyGoalsScreen extends StatefulWidget {
  const MyGoalsScreen({super.key});

  @override
  State<MyGoalsScreen> createState() => _MyGoalsScreenState();
}

class _MyGoalsScreenState extends State<MyGoalsScreen> {
  @override
  Widget build(BuildContext context) {
    return const MyGoalPage();
  }
}

class MyGoalPage extends StatefulWidget {
  const MyGoalPage({super.key});

  @override
  State<MyGoalPage> createState() => _MyGoalPageState();
}

class _MyGoalPageState extends State<MyGoalPage> {
  GoalSettingController goalSettingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 0,
            ),
            getTodayGoal(context),
            Obx(() {
              return goalSettingController.pesonalGoalModel.value.goalList !=
                          null &&
                      goalSettingController
                          .pesonalGoalModel.value.goalList!.isNotEmpty
                  ? const GetHelpDivider()
                  : Container();
            }),
            Obx(() {
              return !goalSettingController.isPersonalGoalLoading.value
                  ? GoalName()
                  : personalGoallistShimmer();
            }),
            const SizedBox(
              height: 10,
            ),

            Obx(() {
              return goalSettingController.pesonalGoalModel.value.goalList !=
                          null &&
                      goalSettingController
                          .pesonalGoalModel.value.goalList!.isNotEmpty &&
                      goalSettingController.isExpanded.value.toString() !=
                          goalSettingController
                              .pesonalGoalModel.value.goalList!.last.sId
                              .toString()
                  ? const GetHelpDivider()
                  : Container();
            }),

            // MileStone(),
            const SizedBox(
              height: 10,
            ),
            GetHelpCategory(title: "I want to work on".tr),
            IWantToWorkOn(),
          ],
        ),
      ),
    );
  }

  Widget getTodayGoal(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Goals'.tr,
                style: goalFontStyle(16.0, const Color(0xffA6A6A6)),
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: SolhColors.primary_green),
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SelectGoal()));
                        },
                        child: Row(
                          children: [
                            Text(
                              'Add'.tr,
                              style:
                                  goalFontStyle(14.0, SolhColors.primary_green),
                            ),
                            const Icon(
                              Icons.add,
                              color: SolhColors.primary_green,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   width: 20,
                  //   child: PopupMenuButton(
                  //       position: PopupMenuPosition.under,
                  //       icon: Icon(
                  //         Icons.more_vert,
                  //         color: SolhColors.primary_green,
                  //       ),
                  //       iconSize: 18,
                  //       itemBuilder: ((context) => [
                  //             PopupMenuItem(
                  //               child: Text(
                  //                 'my Goals'.tr,
                  //                 style: goalFontStyle(
                  //                     14.0, SolhColors.primary_green),
                  //               ),
                  //               value: 1,
                  //             ),
                  //             PopupMenuItem(
                  //               child: Text(
                  //                 'Settings'.tr,
                  //                 style: goalFontStyle(
                  //                     14.0, SolhColors.primary_green),
                  //               ),
                  //               value: 2,
                  //             ),
                  //           ])),
                  // ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 31.5,
          ),
          TodaysGoal(),
          const SizedBox(
            height: 24,
          ),
          SolhGreenButton(
            height: 50,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SelectGoal()));
            },
            child: Text('Add Goals +'.tr),
          ),
        ],
      ),
    );
  }

  Widget personalGoallistShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[300]!,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  SolhAppBar getAppBar() {
    return SolhAppBar(
      title: const ProfileIcon(),
      isLandingScreen: true,
      /* title: const Text("My Goals", style: SolhTextStyles.QS_body_1_bold),
      isLandingScreen: false, */
    );
  }
}

goalFontStyle(
    [size = 14.0, color = Colors.black, fontWeight = FontWeight.w400]) {
  return GoogleFonts.signika(
      fontSize: size, fontWeight: fontWeight, color: color);
}

class TodaysGoal extends StatelessWidget {
  TodaysGoal({super.key});
  final GoalSettingController _goalSettingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Today's Goals".tr,
              style:
                  goalFontStyle(24.0, const Color(0xff666666), FontWeight.w400),
            ),
            Text(
              "Track your today's goals".tr,
              style:
                  goalFontStyle(14.0, const Color(0xffA6A6A6), FontWeight.w300),
            )
          ],
        ),
        Obx(() => Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.white,
                  width: 60,
                  height: 60,
                  child: Center(
                    child: Text(
                      '${_goalSettingController.noOfGoalsCompleted.value}/${_goalSettingController.noOfGoals}\nCompleted',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 70,
                  height: 70,
                  child: CircularProgressIndicator(
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        SolhColors.primary_green),
                    backgroundColor: SolhColors.grey.withOpacity(0.5),
                    value: _goalSettingController.noOfGoalsCompleted.value == 0
                        ? 0
                        : double.parse(_goalSettingController.noOfGoalsCompleted
                                .toString()) /
                            double.parse(
                                _goalSettingController.noOfGoals.toString()),
                  ),
                ),
              ],
            ))
      ],
    );
  }
}

class GoalName extends StatelessWidget {
  GoalName({super.key});
  final GoalSettingController _goalSettingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => _goalSettingController.pesonalGoalModel.value.goalList !=
                null &&
            _goalSettingController.pesonalGoalModel.value.goalList!.isNotEmpty
        ? ExpansionPanelList(
            elevation: 0,
            dividerColor: const Color(0x30D9D9D9),
            children: _goalSettingController.pesonalGoalModel.value.goalList!
                .map((e) => getExpasionPanel(context, e))
                .toList(),
            expansionCallback: (int index, bool isExpanded) {
              _goalSettingController.isExpandedPanelExpanded.value =
                  !_goalSettingController.isExpandedPanelExpanded.value;
              if (_goalSettingController.expandedIndex.value != '' &&
                  _goalSettingController.expandedIndex.value ==
                      _goalSettingController
                          .pesonalGoalModel.value.goalList![index].sId) {
                _goalSettingController.expandedIndex.value = '';
                _goalSettingController.isExpanded.value = '';
              } else {
                _goalSettingController.expandedIndex.value =
                    _goalSettingController
                            .pesonalGoalModel.value.goalList![index].sId ??
                        '';
                _goalSettingController.isExpanded.value = _goalSettingController
                        .pesonalGoalModel.value.goalList![index].sId ??
                    '';
              }

              // _goalSettingController.isExpanded.value = _goalSettingController
              //         .pesonalGoalModel.value.goalList![index].sId ??
              //     '';
            },
          )
        : Container());
  }

  ExpansionPanel getExpasionPanel(BuildContext context, GoalList e) {
    return ExpansionPanel(
      canTapOnHeader: true,
      headerBuilder: (context, isExpanded) {
        return Column(
          children: [
            e.sId == _goalSettingController.expandedIndex.value &&
                    e.sId !=
                        _goalSettingController
                            .pesonalGoalModel.value.goalList!.first.sId
                ? const GetHelpDivider()
                : Container(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: SolhColors.greyS200),
                        borderRadius: BorderRadius.circular(8),
                        color: SolhColors.greyS200.withOpacity(0.1)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                          imageUrl: e.goalImage ?? '',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Image.asset(
                              'assets/images/no-image-available_err.png')),
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          e.goalName ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: goalFontStyle(
                            18.0,
                            const Color(0xff666666),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(() => Row(
                            children: [
                              Text(
                                  _goalSettingController.completedGoalsToday
                                          .contains(e.sId)
                                      ? 'Done for the day'
                                      : 'MileStone Achieved ${e.milestoneReached ?? 0}/${e.milestone ?? 0}',
                                  style: goalFontStyle(
                                    14.0,
                                    const Color(0xffA6A6A6),
                                    FontWeight.w300,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              _goalSettingController.completedGoalsToday
                                      .contains(e.sId)
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: SolhColors.primary_green,
                                    )
                                  : Container()
                            ],
                          )),
                    ],
                  ),
                  const Spacer(),
                  Obx(() {
                    return
                        // _goalSettingController.isExpandedPanelExpanded.value ==
                        //             true &&
                        _goalSettingController.expandedIndex.value == e.sId
                            ? SizedBox(
                                width: 30,
                                child: PopupMenuButton(
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: SolhColors.primary_green,
                                  ),
                                  itemBuilder: (context) =>
                                      <PopupMenuEntry<String>>[
                                    const PopupMenuItem(
                                      value: 'edit',
                                      child: Text('Edit'),
                                    ),
                                    const PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ],
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      //Get.toNamed('/goal-setting/edit-goal',arguments: e);
                                    } else if (value == 'delete') {
                                      showDeleteAlert(context, e);
                                    }
                                  },
                                ),
                              )
                            : const Icon(
                                Icons.arrow_drop_down_circle,
                                color: SolhColors.primary_green,
                              );
                  })
                ],
              ),
            ),
          ],
        );
      },
      body: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                e.activity!.map((e1) => getActivity(context, e1, e)).toList(),
          ),
          const GetHelpDivider()
        ],
      ),
      isExpanded: _goalSettingController.isExpanded.value.toString() ==
          e.sId?.toString(),
    );
  }

  Widget getActivity(BuildContext context, Activity e1, GoalList e) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: SolhColors.primary_green.withOpacity(0.3),
        ),
        child: InkWell(
          onTap: _goalSettingController.isUpdateGoal.value || e1.isComplete!
              ? () {}
              : () {
                  showAlertDialog(context, e.sId!, e1.sId!);
                  // _goalSettingController.updateActivity(
                  //     e.sId ?? '', e1.sId ?? '');
                },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                width: 70.w,
                child: Text(e1.task ?? '',
                    style: SolhTextStyles.ProfileMenuGreyText),
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: SolhColors.white,
                    border: Border.all(color: SolhColors.grey239)),
                child: _goalSettingController.isUpdateGoal.value
                    ? const CircularProgressIndicator(
                        strokeWidth: 2,
                      )
                    : e1.isComplete != null
                        ? e1.isComplete!
                            ? const Icon(
                                Icons.check,
                                color: SolhColors.primary_green,
                                size: 16,
                              )
                            : Container()
                        : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showAlertDialog(BuildContext context, String goalId, String activityId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Is activity completed ?',
            style: goalFontStyle(
              18.0,
              const Color(0xff666666),
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              color: SolhColors.white,
              child: const Text(
                'Not yet',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              color: SolhColors.primary_green,
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _goalSettingController.updateActivity(goalId, activityId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showDeleteAlert(BuildContext context, GoalList e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Do you sure you want to delete this goal ?',
            style: goalFontStyle(
              18.0,
              const Color(0xff666666),
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              color: SolhColors.white,
              child: const Text(
                'No',
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              color: SolhColors.primary_green,
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _goalSettingController.deleteGoal(e.sId!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

/* class MileStone extends StatefulWidget {
  const MileStone({Key? key}) : super(key: key);

  @override
  State<MileStone> createState() => _MileStoneState();
}

class _MileStoneState extends State<MileStone> {
  var type = ['checkbox', 'text'];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Color(0xffD7E6E2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Milestone outside app 1'),
            Checkbox(
                checkColor: SolhColors.green,
                activeColor: Colors.white,
                side: MaterialStateBorderSide.resolveWith((states) =>
                    BorderSide(width: 1.0, color: Color(0xffA6A6A6))),
                shape: CircleBorder(),
                value: true,
                onChanged: (value) {})
          ],
        ),
      ),
    );
  }
} */

class IWantToWorkOn extends StatelessWidget {
  IWantToWorkOn({super.key});
  final GoalSettingController _goalSettingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => _goalSettingController.loadingCat.value
        ? const Center(child: CircularProgressIndicator())
        : _goalSettingController.goalsCatModel.value.categories != null
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                child: ListView.builder(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 60),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _goalSettingController
                        .goalsCatModel.value.categories!.length,
                    shrinkWrap: true,
                    // gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    //     maxCrossAxisExtent: 200,
                    //     childAspectRatio: 3 / 1.2,
                    //     crossAxisSpacing: 20,
                    //     mainAxisSpacing: 20),
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     mainAxisSpacing: 2.5.w,
                    //     crossAxisSpacing: 2.5.w,
                    //     crossAxisCount: 2,
                    //     childAspectRatio: 2),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (() {
                          _goalSettingController.getSubCat(
                              _goalSettingController.goalsCatModel.value
                                      .categories![index].sId ??
                                  '');
                          _goalSettingController.getSampleGoal(
                              _goalSettingController.goalsCatModel.value
                                      .categories![index].sId ??
                                  '');
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AddSelectGoal()));
                        }),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffA6A6A6)),
                              borderRadius: BorderRadius.circular(
                                8,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              CircleAvatar(
                                radius: 7.8.w,
                                backgroundImage: CachedNetworkImageProvider(
                                  _goalSettingController.goalsCatModel.value
                                          .categories![index].displayImage ??
                                      '',
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Text(
                                _goalSettingController.goalsCatModel.value
                                        .categories![index].name ??
                                    '',
                                style: goalFontStyle(14.0,
                                    const Color(0xff666666), FontWeight.w400),
                              )),
                            ]),
                          ),
                        ),
                      );
                    }),
              )
            : Container());
  }
}

/* class AddGoalButton extends StatelessWidget {
  const AddGoalButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => SelectGoal())),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              width: 70.w,
              height: 48,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: SolhColors.green),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Goal',
                      style: GoogleFonts.signika(
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
} */
