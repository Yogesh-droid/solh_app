import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';
import '../../../controllers/getHelp/allied_controller.dart';
import '../../../model/get-help/inhouse_package_model.dart';
import '../../../widgets_constants/buttons/custom_buttons.dart';
import '../../../widgets_constants/constants/colors.dart';
import '../../../widgets_constants/constants/textstyles.dart';

class PackageCard extends StatelessWidget {
  PackageCard({Key? key, this.package, required this.onPackageSelect})
      : super(key: key);
  final PackageList? package;
  final Function(String, int, String) onPackageSelect;
  final AlliedController _alliedController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPackageSelect(
          package!.sId ?? '', package!.amount ?? 0, package!.currency ?? ''),
      child: Obx(
        () => Stack(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color:
                        _alliedController.selectedPackage.value == package!.sId
                            ? SolhColors.primary_green
                            : Colors.grey,
                    width:
                        _alliedController.selectedPackage.value == package!.sId
                            ? 3
                            : 0),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 20),
                    packageNameAndPrice(),
                    // SizedBox(height: 20),
                    Container(
                      // padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          packageDetails(),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // expandedPanle(package),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: SolhColors.blue_light),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${package!.currency} ${package!.amount ?? 0}",
                                      style: SolhTextStyles.QS_body_1_bold
                                          .copyWith(
                                              color: SolhColors.primary_green),
                                    ),
                                    Text(
                                      'Tax Incl.',
                                      style:
                                          SolhTextStyles.QS_cap_2_semi.copyWith(
                                              color: SolhColors.Grey_1),
                                    )
                                  ],
                                ),
                              ),
                              _alliedController.selectedPackage.value ==
                                      package!.sId
                                  ? Container(
                                      margin: EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: SolhColors.Grey_1,
                                              blurRadius: 4,
                                            ),
                                          ],
                                          shape: BoxShape.circle),
                                      child: SvgPicture.asset(
                                        "assets/images/check.svg",
                                        height: 30,
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: SolhGreenButton(
                                          height: 40,
                                          width: 70,
                                          child: AnimatedSwitcher(
                                            duration: Duration(seconds: 5),
                                            child: Text(
                                              'Select'.tr,
                                              style: SolhTextStyles.CTA
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget packageNameAndPrice() {
    return Row(
      children: [
        Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(package!.name ?? '',
                  style: SolhTextStyles.QS_body_2_semi.copyWith(
                    color: SolhColors.black,
                  )),
            )),
        // Expanded(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Text(
        //         "${package!.currency} ${package!.amount ?? 0}",
        //         style: SolhTextStyles.QS_body_1_bold.copyWith(
        //             color: SolhColors.primary_green),
        //       ),
        //       Text(
        //         'Tax Incl.',
        //         style: SolhTextStyles.QS_cap_2_semi.copyWith(
        //             color: SolhColors.Grey_1),
        //       )
        //     ],
        //   ),
        // )
      ],
    );
  }

  Widget packageDetails() {
    return aboutPackage(package!.aboutPackage ?? '', true);
  }

  Widget aboutPackage(String s, bool isHtml) {
    return isHtml
        ? Html(
            data: s,
            style: {
              "li": Style(
                fontSize: FontSize(14),
                color: SolhColors.dark_grey,
                fontWeight: FontWeight.w600,
              )
            },
          )
        : Text(
            s,
            style: SolhTextStyles.QS_cap_2_semi,
          );
  }

  Widget expandedPanle(PackageList? package) {
    return AnimatedSize(
        duration: Duration(milliseconds: 500),
        curve: Curves.linear,
        child: _alliedController.selectedPackage.value == package!.sId
            ? Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      package.benefits!.isNotEmpty
                          ? Text(
                              "Benefits ",
                              style: SolhTextStyles.QS_body_2_bold,
                            )
                          : SizedBox(),
                      SizedBox(height: 15),
                      Container(
                        child: Html(data: package.benefits ?? ''),
                      ),
                      SizedBox(height: 30),
                      // package.videoSessions!.isNotEmpty
                      //     ? Text('Video Package Includes',
                      //         style: SolhTextStyles.QS_body_2_bold)
                      //     : const SizedBox(),
                      // SizedBox(height: 20),
                      // package.videoSessions!.isNotEmpty
                      //     ? Column(
                      //         children: package.videoSessions!
                      //             .map((e) => videoPackageTile(e))
                      //             .toList())
                      //     : const SizedBox()
                    ]),
              )
            : SizedBox(
                width: double.infinity,
              ));
  }

  // Widget videoPackageTile(VideoSessions e) {
  //   return ExpansionTile(
  //     title: Row(
  //       children: [
  //         Text(
  //           "Session",
  //           style:
  //               SolhTextStyles.QS_cap_2_semi.copyWith(color: SolhColors.Grey_1),
  //         ),
  //         SizedBox(
  //           width: 10.w,
  //         ),
  //         Container(
  //           width: 50.w,
  //           child: Text(
  //             e.vName ?? '',
  //             style: SolhTextStyles.QS_cap_semi,
  //           ),
  //         )
  //       ],
  //     ),
  //     children: [
  //       Row(
  //         children: [
  //           SizedBox(
  //             width: 20.w,
  //           ),
  //           Container(
  //             width: 60.w,
  //             child: Text(
  //               e.vDescription ?? '',
  //               style: SolhTextStyles.QS_caption,
  //             ),
  //           ),
  //         ],
  //       )
  //     ],
  //     childrenPadding: EdgeInsets.all(10),
  //     iconColor: SolhColors.primary_green,
  //   );
  // }
}
