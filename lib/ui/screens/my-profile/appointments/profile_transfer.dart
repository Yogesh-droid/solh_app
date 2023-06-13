import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/get-help/view-all/allied_consultants.dart';
import 'package:solh/ui/screens/my-profile/appointments/controller/appointment_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class ProfileTransfer extends StatefulWidget {
  ProfileTransfer({super.key});

  @override
  State<ProfileTransfer> createState() => _ProfileTransferState();
}

class _ProfileTransferState extends State<ProfileTransfer> {
  final AppointmentController _appointmentController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _appointmentController.transferProfileController();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text(
          'Profile Transfer',
          style: SolhTextStyles.QS_body_2_bold,
        ),
      ),
      body: Obx(() {
        return _appointmentController.isLoading.value
            ? MyLoader()
            : ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
                itemCount: _appointmentController
                    .profileTransferModel.value.details!.length,
                separatorBuilder: (context, index) {
                  return GetHelpDivider();
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      _appointmentController.transferId = _appointmentController
                          .profileTransferModel.value.details![index].sId!;
                      _appointmentController.transferProfileDetailController(
                          _appointmentController
                              .profileTransferModel.value.details![index].sId!);
                      Navigator.of(context)
                          .pushNamed(AppRoutes.profileTransferDetail);
                    },
                    child: TransferProfileCard(
                      status: _appointmentController.profileTransferModel.value
                          .details![index].userStatus!.status!,
                      date: DateFormat("dd-MMMM-yy").format(DateTime.parse(
                          _appointmentController.profileTransferModel.value
                              .details![index].createdAt!)),
                      doc1: _appointmentController.profileTransferModel.value
                          .details![index].referedBy!.name!,
                      doc1Img: _appointmentController.profileTransferModel.value
                          .details![index].referedBy!.profilePicture!,
                      doc2Img: _appointmentController.profileTransferModel.value
                          .details![index].referedTo!.profilePicture!,
                      doc2Name: _appointmentController.profileTransferModel
                          .value.details![index].referedTo!.name!,
                    ),
                  );
                },
              );
      }),
    );
  }
}

class TransferProfileCard extends StatelessWidget {
  const TransferProfileCard(
      {super.key,
      required this.date,
      required this.doc1,
      required this.doc2Name,
      required this.doc2Img,
      required this.status,
      required this.doc1Img});
  final String date;
  final String doc1;
  final String doc1Img;
  final String doc2Img;
  final String status;
  final String doc2Name;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Transferred',
                  style: SolhTextStyles.QS_body_2_bold,
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.calendar,
                      color: SolhColors.primary_green,
                      size: 18,
                    ),
                    Text(date)
                  ],
                )
              ],
            ),
            status == "Pending"
                ? Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: SolhColors.pink224,
                        size: 14,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Attention",
                        style: SolhTextStyles.QS_caption.copyWith(
                            color: SolhColors.pink224),
                      )
                    ],
                  )
                : Container()
          ],
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "By $doc1",
                  style: SolhTextStyles.QS_cap_semi,
                ),
                SimpleImageContainer(
                  imageUrl: doc1Img,
                  radius: 25,
                )
              ],
            ),
            Row(
              children: [
                SolhDot(
                  color: SolhColors.grey_3,
                  size: 8,
                ),
                DotWidget(totalWidth: 20.w),
                Icon(
                  Icons.arrow_right,
                  color: SolhColors.primary_green,
                  size: 20,
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "To $doc2Name",
                  style: SolhTextStyles.QS_cap_semi,
                ),
                SimpleImageContainer(
                  imageUrl: doc2Img,
                  radius: 25,
                )
              ],
            ),
          ],
        )
      ]),
    );
  }
}

class DotWidget extends StatelessWidget {
  final double totalWidth, dashWidth, emptyWidth, dashHeight;

  final Color dashColor;

  DotWidget({
    super.key,
    this.totalWidth = 100,
    this.dashWidth = 7,
    this.emptyWidth = 5,
    this.dashHeight = 1,
    this.dashColor = SolhColors.primary_green,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalWidth ~/ (dashWidth + emptyWidth),
        (_) => Container(
          width: dashWidth,
          height: dashHeight,
          color: dashColor,
          margin: EdgeInsets.only(left: emptyWidth / 2, right: emptyWidth / 2),
        ),
      ),
    );
  }
}
