import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/getHelp/allied_controller.dart';
import 'package:solh/controllers/profile/appointment_controller.dart';
import 'package:solh/model/get-help/packages_list_response_model.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/allied_consultant_screen.dart';
import '../../../services/utility.dart';
import '../../../widgets_constants/appbars/app-bar.dart';
import '../../../widgets_constants/constants/colors.dart';
import '../../../widgets_constants/constants/textstyles.dart';
import '../../../widgets_constants/loader/my-loader.dart';
import '../my-profile/appointments/appointment_screen.dart';
import 'booking_price_details.dart';
import 'get-help.dart';

class AlliedBookingContinueDetail extends StatelessWidget {
  AlliedBookingContinueDetail(
      {Key? key, required this.finalResult, required this.packages})
      : super(key: key);
  final FinalResult finalResult;
  final Packages packages;
  bool detailHidden = true;

  final AlliedController _alliedController = Get.find();

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
            img: finalResult.profilePicture ??
                'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
            name: finalResult.name ?? '',
            profession: finalResult.profession ?? ''),
        GetHelpDivider(),
        packageDetails(),
        GetHelpDivider(),
        BillAndCoupon(
          billAmt: packages.amount == 0 ? 'free' : "${packages.amount}",
          total: packages.amount == 0 ? 'free' : "${packages.amount} ",
        ),
        SizedBox(
          height: 30,
        ),
        SolhDeclarationWidget(),
        SizedBox(
          height: 100,
        )
      ]),
    );
  }

  Widget continueWidget(BuildContext context) {
    return ContinueBookingWidget(
        btnChild: Obx(() => _alliedController.isAlliedBooking.value
            ? MyLoader(
                radius: 8,
                strokeWidth: 2,
              )
            : Text(
                'Confirm',
                style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
              )),
        totalPayble: packages.amount == 0 ? 'Free' : "${packages.amount} ",
        onContinuePressed: () async {
          try {
            Map<String, dynamic> map =
                await _alliedController.createPackageOrder(packages);
            print('allied**** $map');
            if (map['success']) {
              // showDialog(
              //     context: context,
              //     builder: (context) {
              //       return Card(
              //         child: Container(
              //           width: double.infinity,
              //           decoration: BoxDecoration(
              //               image: DecorationImage(
              //                   fit: BoxFit.fill,
              //                   image: AssetImage(
              //                       'assets/images/ScaffoldBackgroundGreen.png'))),
              //           child: Column(children: [
              //             Image.asset('assets/images/thankripple.png'),
              //             Text(
              //               'Thank You',
              //               style: SolhTextStyles.QS_head_4.copyWith(
              //                   color: SolhColors.white),
              //             ),
              //             Padding(
              //               padding: const EdgeInsets.all(18.0),
              //               child: Text(
              //                 "Your appointment has been successfully booked on ",
              //                 style: SolhTextStyles.QS_cap_semi.copyWith(
              //                     color: Colors.white),
              //                 textAlign: TextAlign.center,
              //               ),
              //             )
              //           ]),
              //         ),
              //       );
              //     });
              Navigator.pushNamed(context, AppRoutes.paymentscreen, arguments: {
                "amount": packages.amount,
                "feeCurrency": packages.currency,
                "alliedOrderId": map['data']["alliedOrderId"],
                "appointmentId": null,
                "inhouseOrderId": null,
                "marketplaceType": "Allied",
                "paymentGateway": "Stripe",
                "paymentSource": "App",
              });
              _alliedController.isAlliedBooking(false);
              Future.delayed(Duration(seconds: 2), () {
                Get.find<AppointmentController>().getUserAppointments();
                // Navigator.pop(context);
                // Navigator.pop(context);
                // Navigator.pop(context);
                // Navigator.pop(context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => AppointmentScreen()));
              });
            } else {
              Utility.showToast(map['message']);
            }
          } on Exception catch (e) {
            print(e.toString());
          }
        });
  }

  Widget packageDetails() {
    return PackageCard(
        package: packages,
        onPackageSelect: (String id, int price) {
          if (!(_alliedController.selectedPackage.value == id)) {
            _alliedController.selectedPackage.value = id;
            _alliedController.selectedPackagePrice.value = price;
            // _alliedController.selectedPackageIndex =
            //     user!.packages!.indexOf(e);
          } else {
            _alliedController.selectedPackage.value = "";
            _alliedController.selectedPackagePrice.value = -1;
          }
        });
  }
}
