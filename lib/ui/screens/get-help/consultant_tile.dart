import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../controllers/getHelp/consultant_controller.dart';
import '../../../model/doctor.dart';
import '../../../widgets_constants/buttons/custom_buttons.dart';
import '../../../widgets_constants/constants/colors.dart';
import 'consultant_profile_page.dart';

class ConsultantsTile extends StatelessWidget {
  ConsultantsTile(
      {Key? key, required DoctorModel doctorModel, required this.onTap})
      : _doctorModel = doctorModel,
        super(key: key);

  final DoctorModel _doctorModel;
  final ConsultantController _controller = Get.put(ConsultantController());
  final Callback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _controller.getConsultantDataController(_doctorModel.id);
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                getProfileDetails(context),
                getActivityDetails(context),
              ],
            ),
          )),
    );
  }

  getProfileDetails(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getProfileImg(_doctorModel.profilePicture),
              SizedBox(width: 3.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 50.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _doctorModel.prefix != null
                            ? Text(
                                "${_doctorModel.prefix}",
                                style: SolhTextStyles.QS_body_1_bold,
                                overflow: TextOverflow.ellipsis,
                              )
                            : Container(),
                        _doctorModel.prefix != null
                            ? _doctorModel.prefix!.isNotEmpty
                                ? SizedBox(
                                    width: 5,
                                  )
                                : Container()
                            : Container(),
                        Container(
                          width: 40.w,
                          child: Text(
                            "${_doctorModel.name}",
                            style: SolhTextStyles.QS_body_1_bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50.w,
                    child: Text(
                      _doctorModel.specialization != ''
                          ? "${_doctorModel.specialization}"
                          : "${_doctorModel.bio}",
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
          Text(
              _doctorModel.fee_amount! > 0
                  ? '${_doctorModel.feeCurrency} ${_doctorModel.fee_amount}'
                  : (_doctorModel.fee == null ||
                          _doctorModel.fee == 'Paid' ||
                          _doctorModel.fee == ''
                      ? 'Paid'
                      : ''),
              style: TextStyle(
                  fontSize: 15,
                  color: SolhColors.primary_green,
                  fontWeight: FontWeight.w300)),
        ],
      ),
    );
  }

  getProfileImg(String? profilePicture) {
    return CircleAvatar(
      backgroundColor: Color(0xFFD9D9D9),
      radius: 46,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 45,
        backgroundImage: CachedNetworkImageProvider(profilePicture!.isNotEmpty
            ? profilePicture
            : "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y"),
      ),
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
            _controller.getConsultantDataController(_doctorModel.id);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ConsultantProfilePage();
            }));
          },
        ),
      ),
    );
  }
}
