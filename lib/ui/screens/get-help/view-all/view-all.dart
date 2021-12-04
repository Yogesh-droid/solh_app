import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/doctors-bloc.dart';
import 'package:solh/model/doctor.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    doctorsBlocNetwork.getDoctorsSnapshot();
    return StreamBuilder<List<DoctorModel?>>(
        stream: doctorsBlocNetwork.doctorsStateStream,
        builder: (context, doctorsSnapshot) {
          if (doctorsSnapshot.hasData)
            return Scaffold(
                backgroundColor: Color(0xFFF6F6F8),
                appBar: SolhAppBar(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Consultants",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Text(
                        "${doctorsSnapshot.requireData.length} Consultants",
                        style:
                            TextStyle(fontSize: 15, color: Color(0xFFA6A6A6)),
                      )
                    ],
                  ),
                  isLandingScreen: false,
                ),
                body: ListView.builder(
                  itemCount: doctorsSnapshot.requireData.length,
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                  itemBuilder: (_, index) =>
                      doctorsSnapshot.requireData[index]!.bio != ""
                          ? ConsultantsTile(
                              doctorModel: doctorsSnapshot.requireData[index]!,
                            )
                          : Container(),
                ));
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}

class ConsultantsTile extends StatelessWidget {
  const ConsultantsTile({Key? key, required DoctorModel doctorModel})
      : _doctorModel = doctorModel,
        super(key: key);

  final DoctorModel _doctorModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.5.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: SolhColors.grey196.withOpacity(0.4))),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(8)),
                  height: 16.h,
                  width: 25.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)),
                    child: Image.network(
                      "https://e7.pngegg.com/pngimages/1001/748/png-clipart-doctor-raising-right-hand-illustration-physician-hospital-medicine-doctor-s-office-health-doctor-s-child-face.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: 0,
                //   child: Container(
                //     height: 2.5.h,
                //     width: 25.w,
                //     color: Colors.white70,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         CircleAvatar(
                //           backgroundColor: Color(0xFFE1555A),
                //           radius: 1.4.w,
                //         ),
                //         SizedBox(
                //           width: 1.5.w,
                //         ),
                //         Text("Active")
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Container(
                height: 16.h,
                padding: EdgeInsets.symmetric(vertical: 1.h),
                // color: Colors.black12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr. ${_doctorModel.name}",
                      style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Expanded(
                      child: Container(
                        width: 100.w,
                        child: Text(
                          "${_doctorModel.bio}",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF666666),
                              fontWeight: FontWeight.w300),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                    // Text(
                    //   "07 Year of Experience",
                    //   style: TextStyle(fontSize: 12),
                    // ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.only(right: 8.0),
                    //       child: Row(
                    //         children: [
                    //           Icon(
                    //             Icons.people,
                    //             color: SolhColors.green,
                    //             size: 18,
                    //           ),
                    //           Text(
                    //             "72",
                    //             style: SolhTextStyles.GreenBorderButtonText,
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.only(right: 8.0),
                    //       child: Row(
                    //         children: [
                    //           SvgPicture.asset(
                    //               "assets/icons/consultants/ratings.svg"),
                    //           Text(
                    //             "4.5",
                    //             style: TextStyle(color: SolhColors.green),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     Row(
                    //       children: [
                    //         SvgPicture.asset(
                    //             "assets/icons/consultants/review.svg"),
                    //         Text("07",
                    //             style: TextStyle(color: SolhColors.green)),
                    //       ],
                    //     )
                    //   ],
                    // ),
                    Row(
                      // mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "View Profile",
                          style: TextStyle(color: SolhColors.green),
                        ),
                        SolhGreenButton(
                            height: 4.8.h,
                            width: 40.w,
                            child: Text("Book Appointment"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
