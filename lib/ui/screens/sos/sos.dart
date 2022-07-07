import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/routes/routes.gr.dart';
import 'package:solh/ui/screens/sos/emergency-consultation.dart';
import 'package:solh/ui/screens/sos/sos_controller/sos_controller.dart';
import 'package:solh/ui/screens/sos/triger-sos.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class SOSDialog extends StatelessWidget {
  SOSDialog({Key? key}) : super(key: key);

  var _controller = Get.put(SosController());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(0),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.7,
        padding: EdgeInsets.only(
          top: 2.h,
          bottom: _controller.isAdded ? 9.h : 7.h,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: _controller.isAdded
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.end,
              children: [
                if (_controller.isAdded)
                  Padding(
                    padding: EdgeInsets.only(left: 2.w),
                    child: CircleAvatar(
                      radius: 6.w,
                      backgroundColor: Color(0xFBFBFBFB),
                      child: IconButton(
                        icon: Icon(
                          CupertinoIcons.pencil,
                          color: SolhColors.green,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.black,
                    ))
              ],
            ),
            if (_controller.isAdded)
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("SOS", style: SolhTextStyles.SOSGreenHeading),
                    SizedBox(height: 0.6.h),
                    Text(
                      "Trigger SOS, ask for help immediately during any emergency",
                      textAlign: TextAlign.center,
                      style: SolhTextStyles.SOSGreyText,
                    ),
                    SizedBox(height: 2.5.h),
                    SolhGreenButton(
                      backgroundColor: SolhColors.pink224,
                      height: 6.h,
                      child: Text(
                        "Triger SOS",
                        style: TextStyle(),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (_) => SOSTriggerDialog());
                      },
                    )
                  ],
                ),
              )
            else
              Padding(
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Add SOS", style: SolhTextStyles.SOSGreenHeading),
                    SizedBox(height: 0.6.h),
                    Text(
                      "Seek immediate help during emergency with just one click",
                      textAlign: TextAlign.center,
                      style: SolhTextStyles.SOSGreyText,
                    ),
                    SizedBox(height: 1.5.h),
                    Text(
                      "No contact details found.",
                      style: TextStyle(color: Color(0xFFC4C4C4)),
                    ),
                    SizedBox(height: 2.5.h),
                    SolhGreenBorderButton(
                      height: 6.h,
                      child: Text(
                        "Add contact",
                        style: TextStyle(color: SolhColors.green),
                      ),
                      onPressed: () {
                        AutoRouter.of(context).navigate(SetupSOSScreenRouter());
                      },
                    )
                  ],
                ),
              ),
            Expanded(
              child: Divider(
                thickness: 0.1.h,
                height: 0.5.h,
                color: Color(0xFFEFEFEF),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, right: 5.w),
              child: Column(
                children: [
                  Text(
                    "Emergency Consultation",
                    style: SolhTextStyles.SOSGreenHeading,
                  ),
                  SizedBox(height: 0.6.h),
                  Text(
                    "In case of emergency, connect with best possible and instantly available Paid consultant.",
                    textAlign: TextAlign.center,
                    style: SolhTextStyles.SOSGreyText,
                  ),
                  SizedBox(height: 2.6.h),
                  SolhGreenButton(
                    height: 6.h,
                    child: Text(
                      "Consult Now",
                      style:
                          SolhTextStyles.GreenButtonText.copyWith(fontSize: 16),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return EmergencyConsultationConsentDialog();
                          });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
