import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/getHelp/consultant_controller.dart';
import 'package:solh/ui/screens/get-help/consultant_profile_page.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/my-profile/appointments/controller/appointment_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class ProfileTransferDetail extends StatefulWidget {
  ProfileTransferDetail({super.key});

  @override
  State<ProfileTransferDetail> createState() => _ProfileTransferDetailState();
}

class _ProfileTransferDetailState extends State<ProfileTransferDetail> {
  AppointmentController _appointmentController = Get.find();
  @override
  void dispose() {
    // TODO: implement dispose
    _appointmentController.profileTransferStatus.value =
        ProfileTransferStatus.Undefined;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text(
          'Profile Transferred',
          style: SolhTextStyles.QS_body_1_bold,
        ),
      ),
      body: Obx(() {
        return _appointmentController.isLoading.value
            ? Center(
                child: MyLoader(),
              )
            : CustomScrollView(slivers: [
                SliverList(
                    delegate: SliverChildListDelegate([
                  GetHelpDivider(),
                  providerCard(
                      tranferStatus: 'Transfered from',
                      imageUrl: _appointmentController
                          .profileTransferDetailModel
                          .value
                          .details!
                          .referedBy!
                          .profilePicture!,
                      name: _appointmentController.profileTransferDetailModel
                          .value.details!.referedBy!.name!,
                      date: _appointmentController
                          .profileTransferDetailModel.value.details!.createdAt!,
                      profession: _appointmentController
                          .profileTransferDetailModel
                          .value
                          .details!
                          .referedBy!
                          .profession!
                          .name!,
                      experience: _appointmentController
                          .profileTransferDetailModel
                          .value
                          .details!
                          .referedBy!
                          .experience!),
                  Icon(
                    CupertinoIcons.chevron_down,
                    size: 30,
                    color: SolhColors.primary_green,
                  ),
                  providerCard(
                      imageUrl: _appointmentController
                          .profileTransferDetailModel
                          .value
                          .details!
                          .referedTo!
                          .profilePicture!,
                      name: _appointmentController.profileTransferDetailModel
                          .value.details!.referedTo!.name!,
                      date: null,
                      profession: _appointmentController
                          .profileTransferDetailModel
                          .value
                          .details!
                          .referedTo!
                          .profession!
                          .name!,
                      experience: _appointmentController
                          .profileTransferDetailModel
                          .value
                          .details!
                          .referedTo!
                          .experience!,
                      tranferStatus: "Transfered to"),
                  GetHelpDivider(),
                  Obx(() {
                    if (_appointmentController.profileTransferStatus.value ==
                        ProfileTransferStatus.Accepted) {
                      return getApprovalOrDeclinedUI("Accepted");
                    } else if (_appointmentController
                            .profileTransferStatus.value ==
                        ProfileTransferStatus.Declined) {
                      return getApprovalOrDeclinedUI("Declined");
                    }
                    return getApprovalOrDeclinedUI(_appointmentController
                        .profileTransferDetailModel
                        .value
                        .details!
                        .userStatus!
                        .status!);
                  })
                ])),
              ]);
      }),
    );
  }
}

Container providerCard({
  required String imageUrl,
  required String name,
  required String? date,
  required String profession,
  required int experience,
  required String tranferStatus,
}) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SimpleImageContainer(
                imageUrl: imageUrl,
                enableborder: true,
                radius: 60,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tranferStatus,
                    style: SolhTextStyles.QS_cap_2.copyWith(
                        color: SolhColors.Grey_1),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    name,
                    style: SolhTextStyles.QS_body_2_semi,
                  ),
                  Text(
                    profession,
                    style: SolhTextStyles.QS_cap_semi,
                  ),
                ],
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(),
              SizedBox(
                height: 25,
              ),
              date == null
                  ? Container()
                  : Row(
                      children: [
                        Icon(
                          CupertinoIcons.calendar,
                          color: SolhColors.grey_2,
                          size: 18,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          DateFormat("dd-MMMM-yy").format(
                            DateTime.parse(date),
                          ),
                          style: SolhTextStyles.QS_cap_semi,
                        ),
                      ],
                    ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget getApprovalOrDeclinedUI(String status) {
  if (status == "Pending") {
    return ApprovalUI();
  } else if (status == "Declined") {
    return declinedTransferUI();
  } else {
    return AcceptedApprovalUI();
  }
}

class ApprovalUI extends StatelessWidget {
  ApprovalUI({super.key});
  final AppointmentController _appointmentController = Get.find();

  bool isTransfering = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: SolhColors.grey_2),
                borderRadius: BorderRadius.circular(8)),
            child: Column(children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: SolhColors.green228,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.check_mark_circled_solid,
                        color: SolhColors.primary_green,
                        size: 22,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          "There is a pending request for transfer of your case history & reports.",
                          style: SolhTextStyles.QS_body_2_bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              // getApprovalPointers("Psychological Score"),
              // getApprovalPointers("Mood Analysis"),
              // getApprovalPointers("Reports & History"),
              // getApprovalPointers("Data Related to your activity"),
            ]),
          ),
          SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(() {
                return _appointmentController.isUpdatingTransferStatus.value &&
                        !isTransfering
                    ? getApproveDeclineLoadingButton(SolhColors.pink224)
                    : InkWell(
                        onTap: () {
                          isTransfering = false;
                          _appointmentController
                              .updateTransferStatusController("Declined");
                          _appointmentController.transferProfileController();
                        },
                        child: getApproveDeclineButton(
                            Icon(
                              CupertinoIcons.clear,
                              color: SolhColors.white,
                              size: 15,
                            ),
                            'DECLINE',
                            SolhColors.pink224),
                      );
              }),
              Obx(() {
                return _appointmentController.isUpdatingTransferStatus.value &&
                        isTransfering
                    ? getApproveDeclineLoadingButton(SolhColors.primary_green)
                    : InkWell(
                        onTap: () {
                          isTransfering = true;
                          _appointmentController
                              .updateTransferStatusController("Accepted");
                          _appointmentController.transferProfileController();
                        },
                        child: getApproveDeclineButton(
                            Icon(
                              CupertinoIcons.check_mark,
                              color: SolhColors.white,
                              size: 15,
                            ),
                            'APPROVE',
                            SolhColors.primary_green),
                      );
              }),
            ],
          ),
          // DocumentsUI()
        ],
      ),
    );
  }
}

class DocumentsUI extends StatelessWidget {
  DocumentsUI({super.key});
  final AppointmentController _appointmentController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 24),
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10,
          );
        },
        shrinkWrap: true,
        itemCount: _appointmentController
            .profileTransferDetailModel.value.details!.previousReport!.length,
        itemBuilder: (context, index) {
          return DoucmentTile(
            date: _appointmentController.profileTransferDetailModel.value
                .details!.previousReport![index].createdAt!,
            docName: _appointmentController.profileTransferDetailModel.value
                .details!.previousReport![index].sessionNotes!,
            docType: _appointmentController.profileTransferDetailModel.value
                .details!.previousReport![index].reportType!,
            docUrl: _appointmentController.profileTransferDetailModel.value
                .details!.previousReport![index].reportLink!,
          );
        },
      ),
    );
  }
}

class DoucmentTile extends StatefulWidget {
  DoucmentTile({
    super.key,
    required String this.docType,
    required String this.docName,
    required String this.date,
    required String this.docUrl,
  });
  final String docType;
  final String docName;
  final String date;
  final String docUrl;

  @override
  State<DoucmentTile> createState() => _DoucmentTileState();
}

class _DoucmentTileState extends State<DoucmentTile> {
  AppointmentController _appointmentController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    _appointmentController.getLocalPath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_appointmentController.downloadedAndLocalfile
            .containsKey(widget.docUrl)) {
          log(_appointmentController.downloadedAndLocalfile["${widget.docUrl}"],
              name: "fsf");

          log(getFileExtendion(widget.docType), name: "docType");
          OpenFilex.open(
            type: widget.docType,
            _appointmentController.downloadedAndLocalfile[widget.docUrl],
          ).then((value) {
            log(value.message);
          });
        } else {
          print('pressed this');
          _appointmentController.getLocalPathFromDownloadedFile(
            extension: getFileExtendion(widget.docType),
            fileName: widget.docName,
            url: widget.docUrl,
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: SolhColors.light_Bg_2,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.image,
                        color: SolhColors.Grey_1,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.docType,
                        style: SolhTextStyles.QS_caption,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 50.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.docName,
                        style: SolhTextStyles.QS_body_2_bold,
                      ),
                      Text(
                        DateFormat("dd-MMMM-yy").format(
                          DateTime.parse(widget.date),
                        ),
                        style: SolhTextStyles.QS_caption,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                return _appointmentController.isFileDownloading.value &&
                        _appointmentController.currentLoadingurl ==
                            widget.docUrl
                    ? Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                        ),
                      )
                    : (_appointmentController.downloadedAndLocalfile
                            .containsKey(widget.docUrl)
                        ? Icon(
                            Icons.done,
                            color: SolhColors.primary_green,
                          )
                        : Icon(
                            Icons.download_for_offline_outlined,
                            color: SolhColors.primary_green,
                          ));
              }),
            ),
          ],
        ),
      ),
    );
  }
}

String getFileExtendion(String ext) {
  if (ext.contains("pdf")) {
    return "pdf";
  } else if (ext.contains("jpg") || ext.contains("jpeg")) {
    return "jpeg";
  } else {
    return "";
  }
}

class AcceptedApprovalUI extends StatelessWidget {
  AcceptedApprovalUI({super.key});
  final AppointmentController _appointmentController = Get.find();
  ConsultantController _consultantController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: SolhColors.green228,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.check_mark_circled_solid,
                    size: 18,
                    color: SolhColors.primary_green,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Profile Transferred Successfully!',
                    style: SolhTextStyles.QS_body_2_bold,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                          _appointmentController.profileTransferDetailModel
                              .value.details!.referedTo!.feeCurrency!,
                          style: SolhTextStyles.QS_body_1_bold.copyWith(
                              color: SolhColors.primary_green)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        _appointmentController.profileTransferDetailModel.value
                            .details!.referedTo!.feeAmount
                            .toString(),
                        style: SolhTextStyles.QS_body_1_bold.copyWith(
                            color: SolhColors.primary_green),
                      ),
                    ],
                  ),
                  Text(
                    'Session Fee',
                    style: SolhTextStyles.QS_cap_semi,
                  )
                ],
              ),
              Container(
                height: 30,
                width: 1,
                color: SolhColors.grey_2,
              ),
              SolhGreenButton(
                  onPressed: () {
                    _consultantController.getConsultantDataController(
                        _appointmentController.profileTransferDetailModel.value
                            .details!.referedTo!.sId!);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ConsultantProfilePage()));
                  },
                  child: Text(
                    "Visit Profile",
                    style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
                  ))
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Details",
                style: SolhTextStyles.QS_body_2_bold.copyWith(
                    color: SolhColors.primary_green),
              ),
              Text(
                getDetails(
                  _appointmentController.profileTransferDetailModel.value
                      .details!.referedTo!.education!,
                ),
                style: SolhTextStyles.QS_caption,
              )
            ],
          ),
          SizedBox(
            height: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "About",
                style: SolhTextStyles.QS_body_2_bold.copyWith(
                    color: SolhColors.primary_green),
              ),
              Text(
                _appointmentController
                    .profileTransferDetailModel.value.details!.referedTo!.bio!,
                style: SolhTextStyles.QS_caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget declinedTransferUI() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    child: Container(
      decoration: BoxDecoration(
        color: SolhColors.red_shade_3,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.check_mark_circled_solid,
              size: 18,
              color: SolhColors.pink224,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Profile Transferred Declined !',
              style: SolhTextStyles.QS_body_2_bold,
            ),
          ],
        ),
      ),
    ),
  );
}

String getDetails(List details) {
  String detail = '';
  details.forEach((element) {
    detail = detail + element + " ,";
  });
  return detail;
}

Widget getApprovalPointers(String pointer) {
  return Padding(
    padding: EdgeInsets.only(left: 4.w, top: 8, bottom: 8),
    child: Row(
      children: [
        Icon(
          CupertinoIcons.check_mark,
          color: SolhColors.primary_green,
          size: 15,
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          pointer,
          style: SolhTextStyles.QS_caption,
        )
      ],
    ),
  );
}

Widget getApproveDeclineButton(
    Widget icon, String actionName, Color backgroundColor) {
  return SolhGreenButton(
    width: 100,
    height: 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          actionName,
          style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
        ),
        icon,
      ],
    ),
    backgroundColor: backgroundColor,
  );
}

Widget getApproveDeclineLoadingButton(Color backgroundColor) {
  return SolhGreenButton(
    width: 100,
    height: 40,
    child: ButtonLoadingAnimation(
      ballColor: SolhColors.white,
    ),
    backgroundColor: backgroundColor,
  );
}
