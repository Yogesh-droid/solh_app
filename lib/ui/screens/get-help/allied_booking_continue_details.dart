import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/getHelp/allied_controller.dart';
import 'package:solh/model/get-help/packages_list_response_model.dart';
import 'package:solh/ui/screens/get-help/allied_consultant_screen.dart';
import '../../../services/utility.dart';
import '../../../widgets_constants/appbars/app-bar.dart';
import '../../../widgets_constants/constants/colors.dart';
import '../../../widgets_constants/constants/textstyles.dart';
import '../../../widgets_constants/loader/my-loader.dart';
import 'booking_price_details.dart';
import 'get-help.dart';

class AlliedBookingContinueDetail extends StatelessWidget {
  AlliedBookingContinueDetail(
      {Key? key, required this.finalResult, required this.packages})
      : super(key: key);
  final FinalResult finalResult;
  final Packages packages;
  final AlliedController _alliedController = Get.find();
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
        btnChild: Obx(() => _alliedController.isBookingLoading.value
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
            if (map['success']) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Card(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/ScaffoldBackgroundGreen.png'))),
                        child: Column(children: [
                          Image.asset('assets/images/thankripple.png'),
                          Text(
                            'Thank You',
                            style: SolhTextStyles.QS_head_4.copyWith(
                                color: SolhColors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              "Your appointment has been successfully booked on ",
                              style: SolhTextStyles.QS_cap_semi.copyWith(
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ]),
                      ),
                    );
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
    return PackageCard(package: packages, onPackageSelect: (s, i) {});
  }
}
