import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/controllers/getHelp/consultant_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/errors/broken_link.dart';
import 'package:solh/services/user/session-cookie.dart';

class DynamicLinkProvider {
  DynamicLinkProvider._();

  static final instance = DynamicLinkProvider._();

  final String _uriPrefix = "https://solh.page.link";

  final String _packageName = "com.solh.app";

  Future<String> createLinkForProvider(
      {required String providerId, String creatorUserId = ''}) async {
    final String url =
        "https://solh.com/provider?provider=$providerId&creatorUserId=$creatorUserId&creationTime=${DateTime.now()}";
    print('created dynamic link $url');

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        link: Uri.parse(url),
        uriPrefix: _uriPrefix,
        androidParameters: AndroidParameters(
          packageName: _packageName,
          minimumVersion: 7,
        ),
        iosParameters: IOSParameters(
          bundleId: _packageName,
          appStoreId: '1629858813',
        ));

    final FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;

    final reflink = await link.buildShortLink(parameters);

    return reflink.shortUrl.toString();
  }

  Future<void> initDynamicLink() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
    print("$instanceLink instanceLink");
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

    if (instanceLink == null) {
      Stream<PendingDynamicLinkData> onLink =
          FirebaseDynamicLinks.instance.onLink;
      onLink.listen((event) async {
        print('onLink ${event.link}');
        await Get.find<ProfileController>().getMyProfile();
        String providerId = getProviderIdFromLink(event.link.toString());
        print('onLink providerId $providerId');
        if (providerId != '') {
          print('try ran $providerId');
          try {
            await Get.find<ConsultantController>()
                .getConsultantDataController(providerId, "Rs");
            if (globalNavigatorKey.currentState != null) {
              globalNavigatorKey.currentState!
                  .pushNamed(AppRoutes.consultantProfilePage);
            } else {
              print("current State is null");
            }
          } catch (e) {
            globalNavigatorKey.currentState!.push(MaterialPageRoute(
              builder: (context) => BrokenLinKErrorPage(),
            ));
          }
        }
      });
    }
  }
}

String getProviderIdFromLink(String link) {
  String providerId = '';
  List<RegExpMatch> allMatches =
      RegExp(r'(?:\?|\&)(?<key>[\w]+)(?:\=|\&?)(?<value>[\w+,.-]*)')
          .allMatches(link)
          .toList();
  for (final m in allMatches) {
    if (m[0] != null) {
      if (m[0]!.contains('provider')) {
        List<RegExpMatch> providerMatch =
            RegExp(r'\b[\w-]+$').allMatches(m[0].toString()).toList();
        for (final x in providerMatch) {
          providerId = x[0].toString();
        }
      }
    }
  }
  return providerId;
}
