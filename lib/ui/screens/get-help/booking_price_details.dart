import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solh/controllers/getHelp/consultant_controller.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/my-profile/appointments/controller/appointment_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/default_org.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../../../controllers/getHelp/book_appointment.dart';
import '../../../routes/routes.dart';
import '../../../services/utility.dart';
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
            'Booking Online Session'.tr,
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
        DoctorNameAndImage(
            img: consultantController
                    .consultantModelController.value.provder!.profilePicture ??
                'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
            name: consultantController
                    .consultantModelController.value.provder!.name ??
                '',
            profession: consultantController
                    .consultantModelController.value.provder!.specialization ??
                ''),
        GetHelpDivider(),
        getSelectedDateTimeWidget(context),
        GetHelpDivider(),
        BillAndCoupon(
          billAmt: consultantController.consultantModelController.value.provder!
                      .afterDiscountPrice! >
                  0
              ? consultantController
                  .consultantModelController.value.provder!.afterDiscountPrice!
                  .toString()
              : consultantController.consultantModelController.value.provder!
                          .fee_amount! ==
                      0
                  ? 'Paid'
                  : "${consultantController.consultantModelController.value.provder!.feeCurrency ?? ''} ${consultantController.consultantModelController.value.provder!.fee_amount ?? ''}",
          total: consultantController.consultantModelController.value.provder!
                      .afterDiscountPrice! >
                  0
              ? consultantController
                  .consultantModelController.value.provder!.afterDiscountPrice!
                  .toString()
              : consultantController.consultantModelController.value.provder!
                          .fee_amount! ==
                      0
                  ? 'Paid'
                  : "${consultantController.consultantModelController.value.provder!.feeCurrency ?? ''} ${(consultantController.consultantModelController.value.provder!.fee_amount!)} ",
        ),
        SizedBox(
          height: 30,
        ),
        SolhDeclarationWidget(),
        SizedBox(
          height: 100,
        ),
      ]),
    );
  }

  Widget getSelectedDateTimeWidget(BuildContext context) {
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
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Change'.tr,
              style: SolhTextStyles.QS_cap_semi.copyWith(
                  color: SolhColors.primary_green),
            ),
          )
        ],
      ),
    );
  }

  Widget continueWidget(BuildContext context) {
    return ContinueBookingWidget(
        btnChild: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => bookAppointmentController.isLoading.value
                ? MyLoader(
                    radius: 8,
                    strokeWidth: 2,
                  )
                : Text(
                    'Book Now'.tr,
                    style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
                  ))
          ],
        ),
        totalPayble: consultantController.consultantModelController.value
                    .provder!.afterDiscountPrice! >
                0
            ? consultantController
                .consultantModelController.value.provder!.afterDiscountPrice!
                .toString()
            : consultantController
                        .consultantModelController.value.provder!.fee_amount! ==
                    0
                ? 'Paid'
                : "${consultantController.consultantModelController.value.provder!.feeCurrency ?? ''} ${(consultantController.consultantModelController.value.provder!.fee_amount!)} ",
        onContinuePressed: () async {
          print(consultantController
              .consultantModelController.value.provder!.type);
          // showModalBottomSheet(
          //   context: context,
          //   builder: (context) {
          //     return paymentManagement.paymentModelSheet(context);
          //   },
          // );

          Map<String, dynamic> map =
              await bookAppointmentController.bookAppointment({
            'amount': consultantController.consultantModelController.value
                        .provder!.afterDiscountPrice! >
                    0
                ? consultantController.consultantModelController.value.provder!
                    .afterDiscountPrice!
                    .toString()
                : consultantController
                    .consultantModelController.value.provder!.fee_amount!
                    .toString(),
            'currency': consultantController
                .consultantModelController.value.provder!.feeCurrency!,
            'amountOriginal': consultantController
                .consultantModelController.value.provder!.fee_amount!
                .toString(),
            'organisationId': DefaultOrg.defaultOrg ?? '',
            'currencyCode': consultantController
                    .consultantModelController.value.provder!.feeCode ??
                'INR',
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
                bookAppointmentController.selectedTimeSlotN,
                0,
                bookAppointmentController.selectedDate.value),
            'end': getdateTime(
                bookAppointmentController.selectedDay,
                bookAppointmentController.selectedTimeSlotN,
                1,
                bookAppointmentController.selectedDate.value),
            'seekerEmail':
                bookAppointmentController.emailTextEditingController.text,
            'from': bookAppointmentController.selectedTimeSlotN.split('-')[0],
            'to': bookAppointmentController.selectedTimeSlotN.split('-')[1],
            "type": "app",
            "duration": "30",
            "label":
                bookAppointmentController.catTextEditingController.value.text,
            "concern": bookAppointmentController.query ?? '',
            "anonymousSession":
                consultantController.isAnonymousBookingEnabled.value.toString(),
            "offset": bookAppointmentController.selectedOffset.value,
            "zone": bookAppointmentController.selectedTimeZone.value,
          });

          if (map['success']) {
            print("map** $map");

            Get.find<AppointmentController>().getUserAppointments();
            // await Future.delayed(Duration(seconds: 2), () {});
            // Navigator.of(context).pop();
            // Navigator.of(context).pop();
            // Navigator.of(context).pop();

            Navigator.pushNamed(context, AppRoutes.paymentscreen, arguments: {
              "amount": consultantController.consultantModelController.value
                          .provder!.afterDiscountPrice! >
                      0
                  ? consultantController.consultantModelController.value
                      .provder!.afterDiscountPrice!
                      .toString()
                  : consultantController
                      .consultantModelController.value.provder!.fee_amount
                      .toString(),
              "feeCurrency": consultantController
                      .consultantModelController.value.provder!.feeCurrency ??
                  '',
              "alliedOrderId": null,
              "appointmentId": map['data']["appointmentId"],
              "inhouseOrderId": null,
              "marketplaceType": "Appointment",
              "paymentGateway": "Stripe",
              "paymentSource": "App",
              "feeCode": consultantController
                      .consultantModelController.value.provder!.feeCode ??
                  '',
            });
          } else {
            Utility.showToast(map['message']);
          }
        });
  }
}

class BillAndCoupon extends StatelessWidget {
  const BillAndCoupon({Key? key, required this.billAmt, required this.total})
      : super(key: key);
  final String billAmt;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /* Container(
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
            ), */
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Billing Details'.tr,
                  style: SolhTextStyles.QS_body_2_bold.copyWith(
                      color: SolhColors.black),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text('Consultation Fee'.tr,
                        style: SolhTextStyles.QS_cap_semi.copyWith(
                            color: SolhColors.Grey_1)),
                    Spacer(),
                    Text(billAmt,
                        style: SolhTextStyles.QS_cap_semi.copyWith(
                            color: SolhColors.Grey_1)),
                  ],
                ),
                /*  SizedBox(
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
                ), */
                Divider(
                  color: SolhColors.Grey_1,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text('Total Payable'.tr,
                        style: SolhTextStyles.QS_cap_semi.copyWith(
                            color: SolhColors.black)),
                    Spacer(),
                    Text(total,
                        style: SolhTextStyles.QS_cap_semi.copyWith(
                            color: SolhColors.black)),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}

class DoctorNameAndImage extends StatelessWidget {
  const DoctorNameAndImage(
      {Key? key,
      required this.img,
      required this.name,
      required this.profession})
      : super(key: key);
  final String img;
  final String name;
  final String profession;

  @override
  Widget build(BuildContext context) {
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
            imageUrl: img,
            // imageUrl: consultantController.consultantModelController.value
            //         .provder!.profilePicture ??
            //     "'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y'"
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  // consultantController
                  //         .consultantModelController.value.provder!.name ??
                  //     '',
                  style: SolhTextStyles.QS_body_2_bold,
                ),
                Text(
                  //'Profession(Doctor)',
                  profession,
                  style: SolhTextStyles.QS_caption,
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}

class ContinueBookingWidget extends StatelessWidget {
  const ContinueBookingWidget(
      {Key? key,
      required this.btnChild,
      required this.totalPayble,
      required this.onContinuePressed})
      : super(key: key);
  final Widget btnChild;
  final String totalPayble;
  final Function() onContinuePressed;

  @override
  Widget build(BuildContext context) {
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
            Text(totalPayble,
                style: SolhTextStyles.QS_body_semi_1.copyWith(
                    color: SolhColors.black)),
            SizedBox(
              height: 5,
            ),
            Text('Total Payable'.tr,
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
              child: btnChild,
              onPressed: () async {
                onContinuePressed();
              },
            ),
            RichText(
              text: TextSpan(
                  text: 'By confirming you agree',
                  style: SolhTextStyles.QS_cap_2_semi.copyWith(
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
        ),
      ]),
    );
  }
}

class SolhDeclarationWidget extends StatelessWidget {
  const SolhDeclarationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    ),
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
