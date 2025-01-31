import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/profile/my_profile_model.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/organization/service/org_service.dart';
import 'package:solh/ui/screens/profile-setupV2/part-of-an-organisation/orgainsation-model/organisation_model.dart';
import 'package:solh/ui/screens/profile-setupV2/part-of-an-organisation/service/part_of_orgination_service.dart';
import 'package:solh/widgets_constants/constants/default_org.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';

class OrgController extends GetxController {
  ProfileController profileController = Get.find();
  var isOrgLoading = false.obs;
  var showSuggestion = false.obs;
  PartOfAnOrganisationService partOfAnOrganisationService =
      PartOfAnOrganisationService();
  OrgService orgService = OrgService();
  final orgSuggestionTextEditingController = TextEditingController().obs;
  var addingOrgs = false.obs;
  var isUpdatingOrgTeam = false.obs;

  var showDefaultSheet = false.obs;
  var showOthersheet = false.obs;
  var showBottomSheet = false.obs;
  var lastAddedOrg = ''.obs;

  RxList selectedorgs = [].obs;

  var isDeletingOrg = false.obs;

  var SuggestedOrgs = OrganisationListModel().obs;
  final organisationListModel = OrganisationListModel().obs;

  Future<void> removeAndUpdateOrg(String id) async {
    isDeletingOrg(true);
    try {
      await orgService.deleteOrgService(id);

      if (profileController.myProfileModel.value.body!.userOrganisations !=
              null &&
          profileController
              .myProfileModel.value.body!.userOrganisations!.isNotEmpty) {
        if (profileController
                .myProfileModel.value.body!.userOrganisations!.first.status ==
            'Approved') {
          DefaultOrg.setDefaultOrg(profileController.myProfileModel.value.body!
              .userOrganisations!.first.organisation!.sId!);
        } else {
          DefaultOrg.setDefaultOrg(null);
        }
      }
    } on Exception catch (e) {
      throw (e);
    }
    isDeletingOrg(false);
  }

  Future<void> getOrganisationsListController() async {
    isOrgLoading(true);
    try {
      final response = await partOfAnOrganisationService.getOrganisationList();

      if (response['success']) {
        organisationListModel.value = OrganisationListModel.fromJson(response);
      } else {
        SolhSnackbar.error('Error', "Unable to fetch organisations");
      }
    } catch (e) {
      throw (e);
    }
    isOrgLoading(false);
  }

  void createSuggestion() {
    var tempList = OrganisationListModel();
    organisationListModel.value.data!.forEach((element) {
      if (element.name!.toLowerCase().contains(
          orgSuggestionTextEditingController.value.text.toLowerCase())) {
        if (tempList.data == null) {
          tempList.data = [Data(name: element.name, sId: element.sId)];
        } else {
          tempList..data!.add(element);
        }
      }
    });

    SuggestedOrgs.value = tempList;
  }

  void addRemoveOrgs(String sId) {
    if (selectedorgs.value.contains(sId)) {
      selectedorgs.value.remove(sId);
    } else {
      selectedorgs.value.add(sId);
    }
  }

  Future<void> addOrgs() async {
    try {
      addingOrgs(true);
      List allOrgs = profileController
          .myProfileModel.value.body!.userOrganisations!
          .map((e) => e.organisation!.sId!)
          .toList();

      selectedorgs.forEach((element) {
        allOrgs.add(element);
      });
      lastAddedOrg.value = selectedorgs[0];
      await profileController
          .editProfile({'organisation': jsonEncode(allOrgs)});
      DefaultOrg.setDefaultOrg(profileController.myProfileModel.value.body!
          .userOrganisations!.first.organisation!.sId!);
      showBottomSheet.value = true;
    } catch (e) {
      throw (e);
    }
    addingOrgs(false);
  }

  Future<void> changeDefault(int index) async {
    UserOrganisations element = profileController
        .myProfileModel.value.body!.userOrganisations![index + 1];
    UserOrganisations firstItem =
        profileController.myProfileModel.value.body!.userOrganisations!.first;

    List allId = profileController.myProfileModel.value.body!.userOrganisations!
        .map((e) => e.organisation!.sId!)
        .toList();
    log(allId.toString());
    allId.removeAt(0);

    allId.remove(element.organisation!.sId);
    allId.insert(0, element.organisation!.sId);
    allId.add(firstItem.organisation!.sId);
    log(allId.toString());
    profileController.editProfile({'organisation': jsonEncode(allId)});
    await DefaultOrg.setDefaultOrg(allId.first);
    await DefaultOrg.getDefaultOrg();
  }

  Future<void> updateOrgTeamController(
      {required String userOrgId,
      required String selectedOptionId,
      required String type}) async {
    isUpdatingOrgTeam(true);
    try {
      final response = await orgService.updateOrgTeam(
        selectedOptionId: selectedOptionId,
        userOrgId: userOrgId,
        type: type,
      );
    } catch (e) {
      SolhSnackbar.error('Error', "Opps, something went wrong!");
      throw (e);
    }
    isUpdatingOrgTeam(false);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getOrganisationsListController();
    super.onInit();
  }
}
