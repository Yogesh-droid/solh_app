import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/ui/screens/profile-setupV2/part-of-an-organisation/orgainsation-model/organisation_model.dart';
import 'package:solh/ui/screens/profile-setupV2/part-of-an-organisation/service/part_of_orgination_service.dart';
import 'package:solh/widgets_constants/solh_snackbar.dart';

class PartOfAnOrganisationController extends GetxController {
  var isOrganisationsLoading = false.obs;
  var showSuggestion = false.obs;
  var organisationListModel = OrganisationListModel().obs;
  var selectedOrgList = [].obs;

  var SuggestedOrgs = OrganisationListModel().obs;
  PartOfAnOrganisationService _partOfAnOrganisationService =
      PartOfAnOrganisationService();

  var orgTextEditingCotroller = TextEditingController().obs;
  Future<void> getOrganisationListController() async {
    isOrganisationsLoading(true);
    try {
      final response = await _partOfAnOrganisationService.getOrganisationList();

      if (response['success']) {
        organisationListModel.value = OrganisationListModel.fromJson(response);
      } else {
        SolhSnackbar.error('Error', "Unable to fetch organisations");
      }
    } catch (e) {
      throw (e);
    }
    isOrganisationsLoading(false);
  }

  void createSuggestion() {
    var tempList = OrganisationListModel();
    organisationListModel.value.data!.forEach((element) {
      if (element.name!
          .toLowerCase()
          .contains(orgTextEditingCotroller.value.text.toLowerCase())) {
        if (tempList.data == null) {
          tempList.data = [Data(name: element.name, sId: element.sId)];
        } else {
          tempList..data!.add(element);
        }
      }
    });

    SuggestedOrgs.value = tempList;
  }

  bool checkIfOrgAlreadyExists(String name) {
    bool doesExist = false;
    selectedOrgList.forEach((element) {
      if (element.values.first == name) {
        doesExist = true;
      }
    });

    return doesExist;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getOrganisationListController();
    super.onInit();
  }
}
