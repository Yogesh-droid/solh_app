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

  Future<String> createLink({
    required String createFor,
    required Map data,
  }) async {
    String url = '';
    switch (createFor) {
      case 'Provider':
        url =
            "https://solh.com/provider?provider=${data['providerId']}&creatorUserId=${data['creatorUserId']}&creationTime=${DateTime.now()}";
        break;
      case 'Group':
        url =
            "https://solh.com/group?groupId=${data['groupId']}&creatorUserId=${data['creatorUserId']}&creationTime=${DateTime.now()}";
    }

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
        final (dataType, data) = getDynamicLinkData(event.link.toString());

        print('onLink providerId $data');
        switch (dataType) {
          ///
          case 'Provider':
            if (data!["providerId"] != null || data["providerId"] != '') {
              print('try ran ${data["providerId"]}');
              try {
                await Get.find<ConsultantController>()
                    .getConsultantDataController(data["providerId"], "Rs");
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
            } else {
              throw "data is empty";
            }
            break;

          ///
          case 'Group':
            if (data!["groupId"] != null || data["groupId"] != '') {
              print('try ran ${data["groupId"]}');
              try {
                if (globalNavigatorKey.currentState != null) {
                  globalNavigatorKey.currentState!
                      .pushNamed(AppRoutes.groupDetails, arguments: {
                    "groupId": data['groupId'],
                    'isJoined': false
                  });
                } else {
                  print("current State is null");
                }
              } catch (e) {
                globalNavigatorKey.currentState!.push(MaterialPageRoute(
                  builder: (context) => BrokenLinKErrorPage(),
                ));
              }
            } else {
              throw "data is empty";
            }
            break;

          default:
            globalNavigatorKey.currentState!.push(MaterialPageRoute(
              builder: (context) => BrokenLinKErrorPage(),
            ));
        }
      });
    }
  }
}

(String?, Map?) getDynamicLinkData(String link) {
  if (link.contains("provider")) {
    return getProviderIdFromLink(link);
  } else if (link.contains("group")) {
    return getGroupIdFromLink(link);
  }
  return (null, null);
}

(String, Map) getProviderIdFromLink(String link) {
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
  return ('Provider', {"providerId": providerId});
}

(String, Map) getGroupIdFromLink(String link) {
  String groupId = '';
  List<RegExpMatch> allMatches =
      RegExp(r'(?:\?|\&)(?<key>[\w]+)(?:\=|\&?)(?<value>[\w+,.-]*)')
          .allMatches(link)
          .toList();
  for (final m in allMatches) {
    if (m[0] != null) {
      if (m[0]!.contains('group')) {
        List<RegExpMatch> providerMatch =
            RegExp(r'\b[\w-]+$').allMatches(m[0].toString()).toList();
        for (final x in providerMatch) {
          groupId = x[0].toString();
        }
      }
    }
  }
  return ('Group', {"groupId": groupId});
}
