import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/setting.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../../bloc/user-bloc.dart';

class AccountPrivacyScreen extends StatelessWidget {
  const AccountPrivacyScreen({Key? key, Map<dynamic, dynamic>? args})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          "Account Privacy".tr,
          style: TextStyle(color: Colors.black),
        ),
        isLandingScreen: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delete Account".tr,
                    style: SolhTextStyles.QS_body_1_bold,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    "Deleting your account will  delete all your posts, appointments, journals, likes & comments & all other engagements. You will have to create a new account and start your journey from the beginning if you wish to return."
                        .tr,
                    style: SolhTextStyles.QS_body_2,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Center(
                    child: SolhGreenButton(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: 6.5.h,
                        child: Text("Delete"),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => Center(
                                    child: Card(
                                      child: Container(
                                        padding: EdgeInsets.all(14.0),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(
                                                  Icons.close,
                                                  size: 30,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Text(
                                              "Delete Account".tr,
                                              style:
                                                  SolhTextStyles.QS_body_1_bold,
                                            ),
                                            SizedBox(height: 2.h),
                                            Text(
                                              '''Are you sure ? Deleting your account will  delete all your posts, appointments, journals, likes & comments & all other engagements. ''',
                                              style: SolhTextStyles.QS_body_2,
                                              textAlign: TextAlign.center,
                                            ),
                                            Spacer(),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: SolhGreenBorderButton(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.1,
                                                    height: 6.5.h,
                                                    child: Text("Cancel",
                                                        style: TextStyle(
                                                            color: SolhColors
                                                                .primary_green)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                SizedBox(width: 4.w),
                                                Expanded(
                                                  child: SolhGreenButton(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.1,
                                                    height: 6.5.h,
                                                    child: Text("Confirm"),
                                                    onPressed: () async {
                                                      await userBlocNetwork
                                                          .deleteAccount();
                                                      FirebaseAuth.instance
                                                          .signOut()
                                                          .then((value) async {
                                                        logOut();
                                                        // Navigator.popUntil(
                                                        //     context,
                                                        //     (route) =>
                                                        //         route.settings
                                                        //             .name ==
                                                        //         AppRoutes
                                                        //             .introScreen);
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 7.h),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ));
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
