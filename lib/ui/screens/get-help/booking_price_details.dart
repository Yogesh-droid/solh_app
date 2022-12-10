import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:solh/controllers/getHelp/consultant_controller.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/buttons/primary-buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';

import '../../../controllers/getHelp/book_appointment.dart';
import '../../../widgets_constants/privacy_web.dart';
import 'book_appointment.dart';

class BookingPriceDetails extends StatelessWidget {
  final ConsultantController consultantController = Get.find();
  final BookAppointmentController bookAppointmentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
          title: Text(
            'Booking Online Session',
            style: SolhTextStyles.QS_body_1_bold,
          ),
          isLandingScreen: false),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [detailsWidget(context), continueWidget(context)],
      ),
    );
  }

  Widget detailsWidget(BuildContext context) {
    return Container(
      child: ListView(children: [
        getDoctorDetails(),
        GetHelpDivider(),
        getSelectedDateTimeWidget(),
        GetHelpDivider(),
        couponAndBillwidget(),
        SizedBox(
          height: 30,
        ),
        declarationWidget(),
        SizedBox(
          height: 100,
        )
      ]),
    );
  }

  Widget getDoctorDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SimpleImageContainer(
              radius: 40,
              borderColor: SolhColors.primary_green,
              borderWidth: 1,
              imageUrl: consultantController.consultantModelController.value
                      .provder!.profilePicture ??
                  "'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y'"),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                consultantController
                        .consultantModelController.value.provder!.name ??
                    '',
                style: SolhTextStyles.QS_body_2_bold,
              ),
              Text(
                'Profession(Doctor)',
                style: SolhTextStyles.QS_caption,
              ),
            ],
          )
        ]),
      ),
    );
  }

  Widget getSelectedDateTimeWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      height: 77,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() => Text(
              DateFormat('EE, dd MMM yyyy')
                  .format(bookAppointmentController.selectedDate.value),
              style: SolhTextStyles.QS_body_semi_1)),
          VerticalDivider(endIndent: 20, indent: 20),
          Obx(() => Text(bookAppointmentController.selectedTimeSlotN.value,
              style: SolhTextStyles.CTA
                  .copyWith(color: SolhColors.primary_green))),
          Spacer(),
          TextButton(
              onPressed: () {},
              child: Text(
                'Change',
                style: SolhTextStyles.QS_cap_semi.copyWith(
                    color: SolhColors.primary_green),
              ))
        ],
      ),
    );
  }

  Widget couponAndBillwidget() {
    return Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 90,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: SolhColors.grey_3),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(children: [
                SvgPicture.asset('assets/images/offer.svg'),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Apply Coupon code',
                  style: SolhTextStyles.QS_body_semi_1,
                ),
                Spacer(),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Apply',
                      style: SolhTextStyles.QS_cap_semi.copyWith(
                          color: SolhColors.primary_green),
                    ))
              ]),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Billing Details',
                  style: SolhTextStyles.QS_body_2_bold.copyWith(
                      color: SolhColors.black),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text('Consultaion Fee',
                        style: SolhTextStyles.QS_cap_semi.copyWith(
                            color: SolhColors.Grey_1)),
                    Spacer(),
                    Text(
                        "${consultantController.consultantModelController.value.provder!.feeCurrency ?? ''} ${consultantController.consultantModelController.value.provder!.fee_amount ?? ''}",
                        style: SolhTextStyles.QS_cap_semi.copyWith(
                            color: SolhColors.Grey_1)),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text('Service Fee & Taxes',
                        style: SolhTextStyles.QS_cap_semi.copyWith(
                            color: SolhColors.Grey_1)),
                    Spacer(),
                    Text(
                        "${consultantController.consultantModelController.value.provder!.feeCurrency ?? ''} 49 ",
                        style: SolhTextStyles.QS_cap_semi.copyWith(
                            color: SolhColors.Grey_1)),
                  ],
                ),
                Divider(
                  color: SolhColors.Grey_1,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text('Total Payable',
                        style: SolhTextStyles.QS_cap_semi.copyWith(
                            color: SolhColors.black)),
                    Spacer(),
                    Text(
                        "${consultantController.consultantModelController.value.provder!.feeCurrency ?? ''} ${(consultantController.consultantModelController.value.provder!.fee_amount! + 49)} ",
                        style: SolhTextStyles.QS_cap_semi.copyWith(
                            color: SolhColors.black)),
                  ],
                ),
              ],
            )
          ],
        ));
  }

  Widget continueWidget(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20,
      ),
      decoration: BoxDecoration(color: SolhColors.card, boxShadow: [
        BoxShadow(
            offset: Offset(-2.0, -2.0),
            color: SolhColors.grey_3,
            spreadRadius: 3,
            blurRadius: 5)
      ]),
      child: Row(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "${consultantController.consultantModelController.value.provder!.feeCurrency ?? ''} ${(consultantController.consultantModelController.value.provder!.fee_amount! + 49)} ",
                style: SolhTextStyles.QS_body_semi_1.copyWith(
                    color: SolhColors.black)),
            SizedBox(
              height: 5,
            ),
            Text('Total Payable',
                style: SolhTextStyles.QS_cap_2_semi.copyWith(
                    color: SolhColors.dark_grey)),
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SolhGreenButton(
              backgroundColor: SolhColors.primary_green,
              width: 200,
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pay & confirm',
                    style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
                  )
                ],
              ),
              onPressed: () {
                // print(getdateTime(
                //     bookAppointmentController.selectedDay,
                //     bookAppointmentController.selectedTimeSlot,
                //     0,
                //     bookAppointmentController.selectedDate.value));
                // print(
                //   getdateTime(
                //       bookAppointmentController.selectedDay,
                //       bookAppointmentController.selectedTimeSlot,
                //       1,
                //       bookAppointmentController.selectedDate.value),
                // );
                print(
                  bookAppointmentController.emailTextEditingController.text,
                );
                print(
                  bookAppointmentController.selectedTimeSlot.split('-')[0],
                );
                print(bookAppointmentController.selectedTimeSlot.split('-')[1]);
                print(
                  bookAppointmentController.catTextEditingController.value.text,
                );
                print(bookAppointmentController.query ?? '');
                bookAppointmentController.bookAppointment({
                  'provider': consultantController
                              .consultantModelController.value.provder!.type ==
                          'provider'
                      ? consultantController
                          .consultantModelController.value.provder!.sId
                      : '',
                  'doctor': consultantController
                              .consultantModelController.value.provder!.type ==
                          'doctor'
                      ? consultantController
                          .consultantModelController.value.provder!.sId
                      : '',
                  'start': getdateTime(
                      bookAppointmentController.selectedDay,
                      bookAppointmentController.selectedTimeSlot,
                      0,
                      bookAppointmentController.selectedDate.value),
                  'end': getdateTime(
                      bookAppointmentController.selectedDay,
                      bookAppointmentController.selectedTimeSlot,
                      1,
                      bookAppointmentController.selectedDate.value),
                  'seekerEmail':
                      bookAppointmentController.emailTextEditingController.text,
                  'from':
                      bookAppointmentController.selectedTimeSlot.split('-')[0],
                  'to':
                      bookAppointmentController.selectedTimeSlot.split('-')[1],
                  "type": "app",
                  "duration": "30",
                  "label": bookAppointmentController
                      .catTextEditingController.value.text,
                  "concern": bookAppointmentController.query ?? ''
                });
              },
            ),
            RichText(
              text: TextSpan(
                  text: 'By confirming you agree',
                  style: SolhTextStyles.QS_cap_semi.copyWith(
                      color: SolhColors.Grey_1),
                  children: [
                    TextSpan(
                        text: '  Terms & Conditions',
                        style: SolhTextStyles.QS_cap_semi.copyWith(
                            color: SolhColors.Grey_1,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrivacyWeb(
                                    url:
                                        'https://solhapp.com/termsandcondition.html',
                                    title: 'Terms and Conditions'),
                              ),
                            );
                          })
                  ]),
            )
          ],
        )
      ]),
    );
  }

  Widget declarationWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            border: Border.all(color: SolhColors.Grey_1),
            borderRadius: BorderRadius.circular(12)),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            height: 48,
            decoration: BoxDecoration(
                color: SolhColors.primary_green,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            child: Center(
                child: Row(
              children: [
                Icon(
                  CupertinoIcons.check_mark_circled_solid,
                  color: SolhColors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Solh Promises',
                  style: SolhTextStyles.QS_body_2_bold.copyWith(
                      color: SolhColors.white),
                ),
              ],
            )),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: SolhColors.primary_green,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Complete anonymity',
                      style: SolhTextStyles.QS_caption,
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: SolhColors.primary_green,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'A safe space with no judgement',
                      style: SolhTextStyles.QS_caption,
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: SolhColors.primary_green,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'The best doctors and therapists',
                      style: SolhTextStyles.QS_caption,
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.check,
                      color: SolhColors.primary_green,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Round the clock support',
                      style: SolhTextStyles.QS_caption,
                    )
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
