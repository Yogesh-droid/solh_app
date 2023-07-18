import 'dart:developer';

import 'package:solh/services/shared_prefrences/shared_prefrences_singleton.dart';

class DefaultOrg {
  static String? defaultOrg = null;

  static Future<void> setDefaultOrg(String? orgId) async {
    defaultOrg = orgId;
    await Prefs.setString("defaultOrg", orgId ?? '');
    log(defaultOrg.toString(), name: 'defaultOrg');
  }

  static Future<void> getDefaultOrg() async {
    var response = await Prefs.getString("defaultOrg");
    if (response == '') {
      defaultOrg = null;
    } else {
      defaultOrg = response;
    }
    log(defaultOrg.toString(), name: 'defaultOrg');
  }
}
