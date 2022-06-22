import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/get-help/consultant_profile.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../model/doctor.dart';
import '../../../widgets_constants/buttons/custom_buttons.dart';
import '../../../widgets_constants/constants/colors.dart';

class ConsultantsTile extends StatelessWidget {
  const ConsultantsTile(
      {Key? key, required DoctorModel doctorModel, required this.onTap})
      : _doctorModel = doctorModel,
        super(key: key);

  final DoctorModel _doctorModel;
  final Callback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => ConsultantProfile())),
      child: Container(
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: SolhColors.grey196.withOpacity(0.4)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                getProfileDetails(context),
                getActivityDetails(),
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
                      "${_doctorModel.bio}",
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
          Text('free',
              style: TextStyle(
                  fontSize: 15,
                  color: SolhColors.green,
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
        backgroundImage: NetworkImage(
          'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
        ),
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
              color: SolhColors.green,
              size: 10,
            ),
            Text('72',
                style: TextStyle(
                  color: SolhColors.green,
                  fontSize: 12,
                )),
          ],
        ),
        SizedBox(width: 3.w),
        Row(
          children: [
            Icon(
              Icons.star_half,
              color: SolhColors.green,
              size: 10,
            ),
            Text('4.5',
                style: TextStyle(
                  color: SolhColors.green,
                  fontSize: 12,
                )),
          ],
        ),
        SizedBox(width: 3.w),
        Row(
          children: [
            Icon(
              Icons.note_alt_outlined,
              color: SolhColors.green,
              size: 10,
            ),
            Text('07',
                style: TextStyle(
                  color: SolhColors.green,
                  fontSize: 12,
                )),
          ],
        ),
      ],
    );
  }

  Widget getActivityDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Row(
          //   children: [
          //     CircleAvatar(
          //       radius: 8,
          //       backgroundColor: Colors.red,
          //     ),
          //     SizedBox(width: 3.w),
          //     Text('Active',
          //         style: TextStyle(
          //           color: SolhColors.black,
          //           fontSize: 12,
          //         )),
          //   ],
          // ),
          MaterialButton(
            onPressed: () {},
            child: Text('Call',
                style: TextStyle(
                  color: SolhColors.green,
                  fontSize: 14,
                )),
          ),
          // SolhGreenBtn48(
          //     onPress: () {
          //       launch("tel://${_doctorModel.mobile}");
          //     },
          //     text: 'Book Appointment'),
          SolhGreenButton(
            height: 6.h,
            width: 35.w,
            child: Text(
              "Book Appointment",
              style: TextStyle(fontSize: 12),
            ),
            onPressed: () {
              launchUrl(Uri.parse("tel://${8284848028}"));
            },
          )
        ],
      ),
    );
  }
}
