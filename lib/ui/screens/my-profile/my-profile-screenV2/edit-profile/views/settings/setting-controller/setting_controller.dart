import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:solh/widgets_constants/constants/org_only_setting.dart';

class SettingController extends GetxController {
  var orgOnly = false.obs;

  void changeOrgOnlySetting(bool flag) {
    orgOnly.value = flag;

    OrgOnlySetting.setOrgOnly(flag);
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    var response = await OrgOnlySetting.getOrgOnly();
    if (response != null) {
      orgOnly.value = response;
    }
    super.onInit();
  }
}
