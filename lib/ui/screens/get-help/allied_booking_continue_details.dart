import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/controllers/getHelp/allied_controller.dart';
import 'package:solh/ui/screens/my-profile/appointments/controller/appointment_controller.dart';
import 'package:solh/model/get-help/packages_list_response_model.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/get-help/allied_consultant_screen.dart';
import '../../../services/utility.dart';
import '../../../widgets_constants/appbars/app-bar.dart';
import '../../../widgets_constants/constants/colors.dart';
import '../../../widgets_constants/constants/default_org.dart';
import '../../../widgets_constants/constants/textstyles.dart';
import '../../../widgets_constants/loader/my-loader.dart';
import 'booking_price_details.dart';
import 'get-help.dart';

// ignore: must_be_immutable
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
          profession: finalResult.profession ?? '',
        ),
        GetHelpDivider(),
        packageDetails(),
        GetHelpDivider(),
        BillAndCoupon(
          billAmt: packages.amount == 0
              ? 'free'
              : "${packages.afterDiscountPrice! > 0 ? packages.afterDiscountPrice : packages.amount}",
          total: packages.amount == 0
              ? 'free'
              : "${packages.afterDiscountPrice! > 0 ? packages.afterDiscountPrice : packages.amount} ",
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
        totalPayble: packages.amount == 0
            ? 'Free'
            : "${packages.currency} ${packages.afterDiscountPrice! > 0 ? packages.afterDiscountPrice : packages.amount} ",
        onContinuePressed: () async {
          try {
            Map<String, dynamic> map =
                await _alliedController.createPackageOrder(packages);
            print('allied**** $map');
            if (map['success']) {
              Navigator.pushNamed(context, AppRoutes.paymentscreen, arguments: {
                "amount": packages.afterDiscountPrice! > 0
                    ? packages.afterDiscountPrice.toString()
                    : packages.amount.toString(),
                "feeCurrency": packages.currency,
                "alliedOrderId": map['data']["alliedOrderId"],
                "appointmentId": null,
                "inhouseOrderId": null,
                "marketplaceType": "Allied",
                'original_price': packages.amount,
                'organisation': DefaultOrg.defaultOrg ?? '',
                "paymentGateway": "Stripe",
                "paymentSource": "App",
                "feeCode": packages.feeCode
              });
              _alliedController.isAlliedBooking(false);
              Future.delayed(Duration(seconds: 2), () {
                Get.find<AppointmentController>().getUserAppointments();
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
        onPackageSelect:
            (String id, int price, int discountedPrice, String currency) {
          if (!(_alliedController.selectedPackage.value == id)) {
            _alliedController.selectedPackage.value = id;
            _alliedController.selectedPackagePrice.value = price;
            _alliedController.selectedPackageDiscountedPrice.value =
                discountedPrice;
            _alliedController.selectedCurrency.value = currency;
            // _alliedController.selectedPackageIndex =
            //     user!.packages!.indexOf(e);
          } else {
            _alliedController.selectedPackage.value = "";
            _alliedController.selectedPackagePrice.value = -1;
          }
        });
  }
}
