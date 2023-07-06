import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/model/profile/my_profile_model.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/ui/screens/my-profile/my-profile-screenV2/edit-profile/views/settings/organization/controller/org_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class OrgSetting extends StatelessWidget {
  OrgSetting({super.key});
  final ProfileController profileController = Get.find();
  final _controller = Get.put(OrgController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Text(
          'Organization',
          style: SolhTextStyles.QS_body_1_bold,
        ),
      ),
      body: Obx(() {
        return _controller.isDeletingOrg.value ||
                profileController.isProfileLoading.value
            ? Center(
                child: MyLoader(),
              )
            : ListView(
                padding: EdgeInsets.only(top: 2.h, left: 2.w, right: 2.w),
                children: [
                  InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.addOrg),
                      child: getAddOrgButton()),
                  Obx(() {
                    return profileController.myProfileModel.value.body!
                                .userOrganisations!.isEmpty ||
                            profileController.myProfileModel.value.body!
                                    .userOrganisations ==
                                null
                        ? Container()
                        : getDefaultOrg(profileController.myProfileModel.value,
                            _controller);
                  }),
                  Obx(() {
                    return profileController.myProfileModel.value.body!
                                .userOrganisations!.isNotEmpty &&
                            profileController.myProfileModel.value.body!
                                    .userOrganisations!.length >
                                1
                        ? getOtherOrgs(
                            profileController.myProfileModel.value, _controller)
                        : Container();
                  }),
                ],
              );
      }),
    );
  }
}

Widget getAddOrgButton() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: SolhColors.primary_green,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Icon(
              CupertinoIcons.add,
              color: SolhColors.white,
              size: 15,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Add',
              style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
            ),
          ],
        ),
      )
    ],
  );
}

Widget getDefaultOrg(
    MyProfileModel myProfileModel, OrgController orgController) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        height: 220,
        width: 220,
        decoration: BoxDecoration(
          color: SolhColors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 2,
              color: Colors.black12,
            ),
          ],
          border: Border.all(color: SolhColors.primary_green, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Icon(
                    Icons.check_circle_outline,
                    size: 25,
                    color: SolhColors.primary_green,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, top: 8),
                  child: InkWell(
                    onTap: () => orgController.removeAndUpdateOrg(myProfileModel
                        .body!.userOrganisations!.first.organisation!.sId!),
                    child: Icon(
                      Icons.remove_circle_outline,
                      size: 25,
                      color: SolhColors.primaryRed,
                    ),
                  ),
                ),
              ],
            ),
            CircleAvatar(
              radius: 15.w,
              backgroundImage: NetworkImage(myProfileModel
                  .body!.userOrganisations!.first.organisation!.logo!),
            ),
            Text(
              myProfileModel.body!.userOrganisations!.first.organisation!.name!,
              textAlign: TextAlign.center,
              style: SolhTextStyles.QS_caption,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget getOtherOrgs(
    MyProfileModel myProfileModel, OrgController orgController) {
  List<UserOrganisations> subList =
      myProfileModel.body!.userOrganisations!.sublist(1);
  return GridView.builder(
    padding: EdgeInsets.only(
      top: 15,
    ),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
    ),
    itemCount: subList.length,
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return Container(
        decoration: BoxDecoration(
          color: SolhColors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 2,
              color: Colors.black12,
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 8, top: 8),
                    child: InkWell(
                      onTap: () => orgController.changeDefault(index),
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: SolhColors.Grey_1, width: 1.5)),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 8, top: 8),
                  child: InkWell(
                    onTap: () => orgController.removeAndUpdateOrg(
                        subList[index].organisation!.sId ?? ''),
                    child: Icon(
                      Icons.remove_circle_outline,
                      size: 25,
                      color: SolhColors.primaryRed,
                    ),
                  ),
                ),
              ],
            ),
            CircleAvatar(
              radius: 15.w,
              backgroundImage: NetworkImage(subList[index].organisation!.logo!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                subList[index].organisation!.name!,
                textAlign: TextAlign.center,
                style: SolhTextStyles.QS_caption,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
    },
  );
}
