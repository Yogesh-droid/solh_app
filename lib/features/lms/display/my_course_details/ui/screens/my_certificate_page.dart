import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MyCertificatePage extends StatelessWidget {
  const MyCertificatePage({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
          title: const Text("Download Certificate",
              style: SolhTextStyles.QS_body_2_semi),
          isLandingScreen: false,
          isVideoCallScreen: true),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/certificate_bg.png"),
                fit: BoxFit.fill)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(imageUrl: args['imageUrl'] ?? ''),
            const SizedBox(height: 20),
            Text("Congratulations",
                style: SolhTextStyles.QS_big_body.copyWith(
                    color: SolhColors.primary_green)),
            const SizedBox(height: 15),
            Text("You Completed the course",
                style:
                    GoogleFonts.quicksand(textStyle: SolhTextStyles.QS_body_2)),
            const SizedBox(height: 20),
            SolhGreenButton(
                child: Text(
              "Get Your Certificate",
              style: SolhTextStyles.CTA.copyWith(color: Colors.white),
            ))
          ],
        )),
      ),
    );
  }
}
