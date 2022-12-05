import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/get-help/consultant_profile.dart';
import 'package:url_launcher/url_launcher.dart';
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
      // onTap: () => Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => ConsultantProfile(
      //           id: _doctorModel.id,
      //         ))),
      child: Container(
          height: 180,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 50.w,
                    child: Text(
                      "${_doctorModel.name}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF222222)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Container(
                  //   width: 50.w,
                  //   child: Text(
                  //     "${_doctorModel.bio}",
                  //     style: TextStyle(
                  //         fontSize: 14,
                  //         color: Color(0xFF666666),
                  //         fontWeight: FontWeight.w300),
                  //     overflow: TextOverflow.ellipsis,
                  //     maxLines: 2,
                  //   ),
                  // ),
                  // Container(
                  //   width: 50.w,
                  //   child: Text(
                  //     "${_doctorModel.bio}",
                  //     style: TextStyle(
                  //         fontSize: 14,
                  //         color: Color(0xFF666666),
                  //         fontWeight: FontWeight.w300),
                  //     overflow: TextOverflow.ellipsis,
                  //     maxLines: 2,
                  //   ),
                  // ),
                  Container(
                    width: 50.w,
                    child: Text(
                      _doctorModel.specialization != ''
                          ? "${_doctorModel.specialization}"
                          : "${_doctorModel.bio}",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                          fontWeight: FontWeight.w300),
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
            Icon(
              Icons.people,
              color: SolhColors.primary_green,
              size: 10,
            ),
            Text('0',
                style: TextStyle(
                  color: SolhColors.primary_green,
                  fontSize: 12,
                )),
          ],
        ),
        SizedBox(width: 3.w),
        Row(
          children: [
            Icon(
              Icons.star_half,
              color: SolhColors.primary_green,
              size: 10,
            ),
            Text('0',
                style: TextStyle(
                  color: SolhColors.primary_green,
                  fontSize: 12,
                )),
          ],
        ),
        SizedBox(width: 3.w),
        Row(
          children: [
            Icon(
              Icons.note_alt_outlined,
              color: SolhColors.primary_green,
              size: 10,
            ),
            Text('0',
                style: TextStyle(
                  color: SolhColors.primary_green,
                  fontSize: 12,
                )),
          ],
        ),
      ],
    );
  }

  Widget getActivityDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(
            onPressed: () {
              launchUrl(Uri.parse("tel://${8284848028}"));
            },
            // child: Container(
            //   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //   decoration: BoxDecoration(
            //       border: Border.all(color: SolhColors.green),
            //       borderRadius: BorderRadius.circular(18)),
            //   child: Row(
            //     children: [
            //       Text('Call',
            //           style: TextStyle(
            //             color: SolhColors.green,
            //             fontSize: 14,
            //           )),
            //       Icon(
            //         Icons.call,
            //         color: SolhColors.green,
            //       )
            //     ],
            //   ),
            // ),
          ),
          SolhGreenButton(
            height: 6.h,
            width: 35.w,
            child: Text(
              "Book Appointment",
              style: TextStyle(fontSize: 12),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ConsultantProfile(
                        id: _doctorModel.id,
                      )));
            },
          )
        ],
      ),
    );
  }
}
