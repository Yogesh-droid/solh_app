import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/buttons/primary-buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../model/doctor.dart';
import '../../../widgets_constants/constants/colors.dart';

class ConsultantsTile extends StatelessWidget {
  const ConsultantsTile({Key? key, required DoctorModel doctorModel})
      : _doctorModel = doctorModel,
        super(key: key);

  final DoctorModel _doctorModel;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: EdgeInsets.symmetric(vertical: 0.5.h),
    //   decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(8),
    //       border: Border.all(color: SolhColors.grey196.withOpacity(0.4))),
    //   child: Container(
    //     decoration: BoxDecoration(
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
    //     child: Row(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Stack(
    //           children: [
    //             Container(
    //               decoration:
    //                   BoxDecoration(borderRadius: BorderRadius.circular(8)),
    //               height: 16.h,
    //               width: 25.w,
    //               child: ClipRRect(
    //                 borderRadius: BorderRadius.only(
    //                     topLeft: Radius.circular(8),
    //                     bottomLeft: Radius.circular(8)),
    //                 child: Image.network(
    //                   "https://e7.pngegg.com/pngimages/1001/748/png-clipart-doctor-raising-right-hand-illustration-physician-hospital-medicine-doctor-s-office-health-doctor-s-child-face.png",
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         SizedBox(width: 3.w),
    //         Expanded(
    //           child: Container(
    //             height: 16.h,
    //             padding: EdgeInsets.symmetric(vertical: 1.h),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceAround,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   "Dr. ${_doctorModel.name}",
    //                   style: TextStyle(fontSize: 16),
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //                 Expanded(
    //                   child: Container(
    //                     width: 100.w,
    //                     child: Text(
    //                       "${_doctorModel.bio}",
    //                       style: TextStyle(
    //                           fontSize: 12,
    //                           color: Color(0xFF666666),
    //                           fontWeight: FontWeight.w300),
    //                       overflow: TextOverflow.clip,
    //                     ),
    //                   ),
    //                 ),
    //                 // SolhGreenButton(
    //                 //   height: 4.2.h,
    //                 //   width: 40.w,
    //                 //   child: Text("Book Appointment"),
    //                 //   onPressed: () {
    //                 //     launch("tel://${_doctorModel.mobile}");
    //                 //   },
    //                 // )
    //                 SolhGreenBtn48(
    //                     onPress: () {
    //                       launch("tel://${_doctorModel.mobile}");
    //                     },
    //                     text: 'Book Appointment')
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Container(
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
              getProfileDetails(),
              getActivityDetails(),
            ],
          ),
        ));
  }

  getProfileDetails() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getProfileImg(),
              SizedBox(width: 3.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 50.w,
                    child: Text(
                      "Dr. ${_doctorModel.name}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF222222)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
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
                  Text(
                    "7 yrs of experience",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF222222),
                        fontWeight: FontWeight.w400),
                    overflow: TextOverflow.ellipsis,
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

  getProfileImg() {
    return CircleAvatar(
      radius: 46,
      backgroundColor: SolhColors.green,
      child: CircleAvatar(
        radius: 45,
        backgroundImage: NetworkImage(
          'https://e7.pngegg.com/pngimages/1001/748/png-clipart-doctor-raising-right-hand-illustration-physician-hospital-medicine-doctor-s-office-health-doctor-s-child-face.png',
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
          SolhGreenBtn48(
              onPress: () {
                launch("tel://${_doctorModel.mobile}");
              },
              text: 'Book Appointment'),
        ],
      ),
    );
  }
}
