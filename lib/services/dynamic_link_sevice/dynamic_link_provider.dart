import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/controllers/getHelp/consultant_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/errors/broken_link.dart';

class DynamicLinkProvider {
  DynamicLinkProvider._();

  static final instance = DynamicLinkProvider._();

  final String _uriPrefix = "https://solh.page.link";

  final String _packageName = "com.solh.app";

  Future<String> createLinkForProvider(
      {required String providerId, String creatorUserId = ''}) async {
    final String url =
        "https://solh.com/provider?provider=$providerId&creatorUserId=$creatorUserId&creationTime=${DateTime.now()}";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        link: Uri.parse(url),
        uriPrefix: _uriPrefix,
        androidParameters:
            AndroidParameters(packageName: _packageName, minimumVersion: 7),
        iosParameters: IOSParameters(bundleId: _packageName));

    final FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;

    final reflink = await link.buildShortLink(parameters);

    return reflink.shortUrl.toString();
  }

  Future<void> initDynamicLink() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();

    if (instanceLink != null) {
      final Uri reflink = instanceLink.link;
      await Get.find<ProfileController>().getMyProfile();

      try {
        switch (reflink.path) {
          case "/provider":
            await Get.find<ConsultantController>().getConsultantDataController(
                reflink.queryParameters["provider"], "Rs");
            if (globalNavigatorKey.currentState != null) {
              globalNavigatorKey.currentState!
                  .pushNamed(AppRoutes.consultantProfilePage);
            } else {
              print("current State is null");
            }
            break;
        }
      } catch (e) {
        globalNavigatorKey.currentState!.push(MaterialPageRoute(
          builder: (context) => BrokenLinKErrorPage(),
        ));
      }

      print(
        " dynamic queryprams ${reflink.queryParameters}",
      );
      print(
        "dynamic path ${reflink.path}",
      );
    }
  }
}
