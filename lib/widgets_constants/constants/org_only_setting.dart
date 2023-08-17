import 'package:solh/services/shared_prefrences/shared_prefrences_singleton.dart';

class OrgOnlySetting {
  static bool? orgOnly = false;

  static Future<void> setOrgOnly(bool flag) async {
    Prefs.setBool("orgOnlySetting", flag);
  }

  static Future<bool?> getOrgOnly() async {
    orgOnly = await Prefs.getBool("orgOnlySetting");
    print("Org only value is ${OrgOnlySetting.orgOnly}");
    return orgOnly;
  }
}
