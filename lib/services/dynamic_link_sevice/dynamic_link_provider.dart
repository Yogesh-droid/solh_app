import 'dart:developer';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/controllers/getHelp/consultant_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/controllers/psychology-test/psychology_test_controller.dart';
import 'package:solh/main.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/services/errors/broken_link.dart';
import 'package:solh/ui/screens/psychology-test/test_question_page.dart';
import 'package:solh/widgets_constants/buttonLoadingAnimation.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

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
            "https://solh.com/provider?provider=${data['providerId']}&creatorUserId=${data['creatorUserId']}&creationTime=${DateTime.now()}&ofl=https://www.solhapp.com/";
        break;
      case 'Group':
        url =
            "https://solh.com/group?groupId=${data['groupId']}&creatorUserId=${data['creatorUserId']}&creationTime=${DateTime.now()}";
      case 'inHousePackage':
        url =
            "https://solh.com/inHousePackage?inHousePackageId=${data['inHousePackageId']}&creatorUserId=${data['creatorUserId']}&creationTime=${DateTime.now()}";
      case 'alliedProvider':
        url =
            "https://solh.com/alliedProvider?alliedProviderId=${data['alliedProviderId']}&creatorUserId=${data['creatorUserId']}&creationTime=${DateTime.now()}";
      case 'selfAssessment':
        url =
            "https://solh.com/selfAssessment?assessmentId=${data['assessmentId']}&creatorUserId=${data['creatorUserId']}&creationTime=${DateTime.now()}";
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

    final reflink = await link
        .buildShortLink(parameters)
        .onError((error, stackTrace) => throw (error.toString()));

    return reflink.shortUrl.toString();
  }

  Future<void> initDynamicLink() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
    print("$instanceLink instanceLink");
    if (instanceLink != null) {
      showWaitingDialog();
      final Uri reflink = instanceLink.link;
      print("reflink ${reflink.path}");
      try {
        switch (reflink.path) {
          case "/provider":
            await Get.find<ConsultantController>().getConsultantDataController(
                reflink.queryParameters["provider"], "Rs");

            _routeLinks(routeName: AppRoutes.consultantProfilePage, args: {});
            break;
          case "/group":
            _routeLinks(routeName: AppRoutes.groupDetails, args: {
              "groupId": reflink.queryParameters["groupId"],
              'isJoined': false
            });
            break;
          case "/inHousePackage":
            _routeLinks(
                routeName: AppRoutes.inhousePackage,
                args: {"id": reflink.queryParameters["inHousePackageId"]});
          case "/alliedProvider":
            _routeLinks(
                routeName: AppRoutes.alliedConsultantScreen,
                args: {"id": reflink.queryParameters["alliedProviderId"]});
          case "/selfAssessment":
            await Get.find<PsychologyTestController>()
                .getQuestion(reflink.queryParameters["assessmentId"] ?? '');

            globalNavigatorKey.currentState!
                .push(MaterialPageRoute(builder: (context) {
              return TestQuestionsPage(
                id: reflink.queryParameters["assessmentId"],
                testTitle: null,
              );
            }));
        }
      } catch (e) {
        globalNavigatorKey.currentState!.push(MaterialPageRoute(
          builder: (context) => BrokenLinKErrorPage(),
        ));
        throw (e);
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
        showWaitingDialog();
        print('onLink ${event.link}');
        await Get.find<ProfileController>().getMyProfile();
        final (dataType, data) = _getDynamicLinkData(event.link.toString());

        print('onLink providerId $data');
        switch (dataType) {
          ///
          case 'Provider':
            if (data!["providerId"] != null || data["providerId"] != '') {
              print('try ran ${data["providerId"]}');
              try {
                await Get.find<ConsultantController>()
                    .getConsultantDataController(data["providerId"], "Rs");
              } catch (e) {
                globalNavigatorKey.currentState!.push(MaterialPageRoute(
                  builder: (context) => BrokenLinKErrorPage(),
                ));
                throw (e);
              }

              _routeLinks(routeName: AppRoutes.consultantProfilePage, args: {});
            } else {
              throw "data is empty for provider dynamic link";
            }
            break;

          ///
          case 'Group':
            if (data!["groupId"] != null || data["groupId"] != '') {
              _routeLinks(
                  routeName: AppRoutes.groupDetails,
                  args: {"groupId": data['groupId'], 'isJoined': false});
            } else {
              throw 'data is empty for groups dynamic link';
            }

          case 'inHousePackage':
            if (data!["inHousePackageId"] != null ||
                data["inHousePackageId"] != '') {
              _routeLinks(routeName: AppRoutes.master, args: {});
              _routeLinks(
                  routeName: AppRoutes.inhousePackage,
                  args: {"id": data['inHousePackageId']});
            } else {
              throw 'data is empty for inHousePackage dynamic link';
            }
          case 'alliedProvider':
            if (data!["alliedProviderId"] != null ||
                data["alliedProviderId"] != '') {
              _routeLinks(routeName: AppRoutes.master, args: {});
              _routeLinks(
                  routeName: AppRoutes.alliedConsultantScreen,
                  args: {"id": data['alliedProviderId']});
            } else {
              throw 'data is empty for inHousePackage dynamic link';
            }
          case 'selfAssessment':
            if (data!["assessmentId"] != null || data["assessmentId"] != '') {
              await Get.find<PsychologyTestController>()
                  .getQuestion(data['assessmentId'] ?? '');
              globalNavigatorKey.currentState!.pop();
              globalNavigatorKey.currentState!
                  .push(MaterialPageRoute(builder: (context) {
                return TestQuestionsPage(
                  id: data['assessmentId'],
                  testTitle: null,
                );
              }));
            } else {
              throw 'data is empty for inHousePackage dynamic link';
            }

          ///
          default:
            globalNavigatorKey.currentState!.push(MaterialPageRoute(
              builder: (context) => BrokenLinKErrorPage(),
            ));
        }
      });
    }
  }
}

void showWaitingDialog() {
  showDialog(
    barrierDismissible: false,
    context: globalNavigatorKey.currentContext!,
    builder: (context) {
      return SizedBox(
        height: 300,
        child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/opening_link.gif',
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonLoadingAnimation(),
                Text(
                  'Loading link data',
                  style: SolhTextStyles.QS_big_body.copyWith(
                      color: SolhColors.primary_green),
                )
              ],
            )),
      );
    },
  );
}

void _routeLinks(
    {required String routeName, required Map<String, dynamic> args}) {
  //to pop the link loading screen

  try {
    if (globalNavigatorKey.currentState != null) {
      globalNavigatorKey.currentState!.pushNamed(routeName, arguments: args);
    } else {
      print("current State is null for route $routeName");
    }
  } catch (e) {
    print("caught a error in route $routeName");

    globalNavigatorKey.currentState!.push(MaterialPageRoute(
      builder: (context) => BrokenLinKErrorPage(),
    ));
    throw (e);
  }
}

(String?, Map?) _getDynamicLinkData(String link) {
  if (link.contains("provider")) {
    return _getProviderIdFromLink(link);
  } else if (link.contains("group")) {
    return _getGroupIdFromLink(link);
  } else if (link.contains('inHousePackage')) {
    return _getInHousepackageIdFromLink(link);
  } else if (link.contains('alliedProvider')) {
    return _getAlliedProviderIdFromLink(link);
  } else if (link.contains('selfAssessment')) {
    return _getSelfAssessmentIdFromLink(link);
  }
  return (null, null);
}

// it works don't touch it
(String, Map) _getProviderIdFromLink(String link) {
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

//it also works
(String, Map) _getGroupIdFromLink(String link) {
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

(String, Map) _getInHousepackageIdFromLink(String link) {
  String groupId = '';
  List<RegExpMatch> allMatches =
      RegExp(r'(?:\?|\&)(?<key>[\w]+)(?:\=|\&?)(?<value>[\w+,.-]*)')
          .allMatches(link)
          .toList();
  for (final m in allMatches) {
    if (m[0] != null) {
      if (m[0]!.contains('inHousePackage')) {
        List<RegExpMatch> providerMatch =
            RegExp(r'\b[\w-]+$').allMatches(m[0].toString()).toList();
        for (final x in providerMatch) {
          groupId = x[0].toString();
        }
      }
    }
  }
  return ('inHousePackage', {"inHousePackageId": groupId});
}

(String, Map) _getAlliedProviderIdFromLink(String link) {
  String groupId = '';
  List<RegExpMatch> allMatches =
      RegExp(r'(?:\?|\&)(?<key>[\w]+)(?:\=|\&?)(?<value>[\w+,.-]*)')
          .allMatches(link)
          .toList();
  for (final m in allMatches) {
    if (m[0] != null) {
      if (m[0]!.contains('alliedProvider')) {
        List<RegExpMatch> providerMatch =
            RegExp(r'\b[\w-]+$').allMatches(m[0].toString()).toList();
        for (final x in providerMatch) {
          groupId = x[0].toString();
        }
      }
    }
  }
  return ('alliedProvider', {"alliedProviderId": groupId});
}

(String, Map) _getSelfAssessmentIdFromLink(String link) {
  String groupId = '';
  List<RegExpMatch> allMatches =
      RegExp(r'(?:\?|\&)(?<key>[\w]+)(?:\=|\&?)(?<value>[\w+,.-]*)')
          .allMatches(link)
          .toList();
  for (final m in allMatches) {
    if (m[0] != null) {
      if (m[0]!.contains('assessmentId')) {
        List<RegExpMatch> providerMatch =
            RegExp(r'\b[\w-]+$').allMatches(m[0].toString()).toList();
        for (final x in providerMatch) {
          groupId = x[0].toString();
        }
      }
    }
  }
  log("${('selfAssessment', {"assessmentId": groupId})}");
  return ('selfAssessment', {"assessmentId": groupId});
}
