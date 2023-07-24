import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';
import '../../../controllers/getHelp/consultant_controller.dart';
import '../../../widgets_constants/buttons/custom_buttons.dart';
import '../../../widgets_constants/constants/colors.dart';
import 'consultant_profile_page.dart';

class ConsultantsTile extends StatelessWidget {
  ConsultantsTile(
      {Key? key,
      required this.onTap,
      required this.id,
      required this.profilePic,
      required this.feeAmount,
      required this.currency,
      required this.prefix,
      required this.name,
      required this.specialization,
      this.bio,
      this.fee,
      this.discountedPrice})
      // : _doctorModel = doctorModel,
      : super(key: key);

  // final DoctorModel _doctorModel;
  final String id;
  final String profilePic;
  final int? feeAmount;
  final String? fee;
  final String currency;
  final String? prefix;
  final String name;
  final String specialization;
  final String? bio;
  final ConsultantController _controller = Get.put(ConsultantController());
  final Callback onTap;
  final int? discountedPrice;

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find();
    print("Discounted price is $discountedPrice");
    log("$currency currency");
    return Column(
      children: [
        InkWell(
          onTap: () {
            _controller.getConsultantDataController(id, currency);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ConsultantProfilePage();
            }));
          },
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: SolhColors.grey_2.withOpacity(0.4)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  getProfileDetails(context),
                  Container(
                    height: 12.w,
                    width: 25.w,
                    decoration: BoxDecoration(
                      color: SolhColors.greenShade3,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Starting @'.tr,
                          style: SolhTextStyles.QS_cap_semi,
                        ),
                        Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                profileController.myProfileModel.value.body!
                                            .userOrganisations!.isNotEmpty &&
                                        profileController
                                                .myProfileModel
                                                .value
                                                .body!
                                                .userOrganisations!
                                                .first
                                                .status ==
                                            'Approved' &&
                                        discountedPrice != null &&
                                        discountedPrice! > 0
                                    ? Row(
                                        children: [
                                          Text('${currency} ${discountedPrice}',
                                              style:
                                                  SolhTextStyles.QS_cap_semi),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${currency} ${feeAmount}',
                                            style: SolhTextStyles.QS_cap_semi
                                                .copyWith(
                                                    color: SolhColors.grey_2,
                                                    fontSize: 10,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                          )
                                        ],
                                      )
                                    : Text(
                                        feeAmount! > 0
                                            ? '${currency} ${feeAmount}'
                                            : (fee == null ||
                                                    fee == 'Paid' ||
                                                    fee == ''
                                                ? 'Paid'
                                                : ''),
                                        style: SolhTextStyles.QS_cap_semi),
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              )),
        ),
        GetHelpDivider()
      ],
    );
  }

  getProfileDetails(context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getProfileImg(profilePic),
          SizedBox(width: 3.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 3.h,
              ),

              RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: prefix != null ? "$prefix " : '',
                    style: Theme.of(context).textTheme.displaySmall),
                TextSpan(
                    text: "$name",
                    style: Theme.of(context).textTheme.displaySmall)
              ]))
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     prefix != null
              //         ? Text(
              //             "${prefix}",
              //             style: SolhTextStyles.QS_body_1_bold,
              //             overflow: TextOverflow.ellipsis,
              //           )
              //         : Container(),
              //     prefix != null
              //         ? prefix!.isNotEmpty
              //             ? SizedBox(
              //                 width: 5,
              //               )
              //             : Container()
              //         : Container(),
              //     Container(
              //       width: 40.w,
              //       child: Text(
              //         "${name}",
              //         style: SolhTextStyles.QS_body_1_bold,
              //         overflow: TextOverflow.ellipsis,
              //       ),
              //     ),
              //   ],
              // ),
              ,
              Container(
                width: 50.w,
                child: Text(
                  specialization != '' ? "${specialization}" : "${bio}",
                  style: SolhTextStyles.QS_cap_semi,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),

              SizedBox(height: 1.h),
              //// interaction details ////////////////////
              ///
              getInteractionDetails(),

              //// ActivityDetails ////////////////////
            ],
          ),
        ],
      ),
    );
  }

  getProfileImg(String? profilePicture) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: SimpleImageContainer(
              // zoomEnabled: true,
              enableborder: true,
              enableGradientBorder: false,
              boxFit: BoxFit.cover,
              radius: 100,
              imageUrl: profilePicture!.isNotEmpty
                  ? profilePicture
                  : "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y"),
        ),
        // Positioned(
        //   bottom: 0,
        //   right: 0,
        //   left: 0,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Container(
        //         height: 6.w,
        //         width: 12.w,
        //         decoration: BoxDecoration(
        //             color: SolhColors.white,
        //             borderRadius: BorderRadius.circular(10),
        //             boxShadow: <BoxShadow>[
        //               BoxShadow(
        //                 spreadRadius: 2,
        //                 blurRadius: 2,
        //                 color: Colors.black26,
        //               )
        //             ]),
        //         child: Center(
        //             child: SvgPicture.asset(
        //           'assets/images/verified_consultant.svg',
        //           color: SolhColors.primary_green,
        //           height: 15,
        //         )),
        //       ),
        //     ],
        //   ),
        // )
      ],
    );
  }

  Widget getInteractionDetails() {
    return Row(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/images/get_help/smile.svg',
              color: SolhColors.primary_green,
              height: 12,
            ),
            SizedBox(
              width: 5,
            ),
            Text('0',
                style: SolhTextStyles.QS_cap_semi.copyWith(
                    color: SolhColors.dark_grey))
          ],
        ),
        SizedBox(width: 3.w),
        Row(
          children: [
            Icon(
              Icons.star_half,
              color: SolhColors.primary_green,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text('0',
                style: SolhTextStyles.QS_cap_semi.copyWith(
                    color: SolhColors.dark_grey))
          ],
        ),
        SizedBox(width: 3.w),
        Row(
          children: [
            SvgPicture.asset(
              'assets/images/get_help/post.svg',
              color: SolhColors.primary_green,
              height: 12,
            ),
            SizedBox(
              width: 5,
            ),
            Text('0',
                style: SolhTextStyles.QS_cap_semi.copyWith(
                  color: SolhColors.dark_grey,
                )),
          ],
        ),
      ],
    );
  }

  Widget getActivityDetails(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SolhGreenButton(
          child: Text(
            "Book Appointment",
            textAlign: TextAlign.center,
            style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
          ),
          onPressed: () {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => ConsultantProfile(
            //           id: _doctorModel.id,
            //         )));
            _controller.getConsultantDataController(id, currency);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ConsultantProfilePage();
            }));
          },
        ),
      ),
    );
  }
}
