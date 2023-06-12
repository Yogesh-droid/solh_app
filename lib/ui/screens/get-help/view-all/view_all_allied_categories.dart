import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/getHelp/get_help_controller.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/ui/screens/get-help/view-all/allied_consultants.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/image_container.dart';

class ViewAlAlliedCategories extends StatelessWidget {
  ViewAlAlliedCategories({super.key, Map<String, dynamic>? args})
      : onTap = args!["onTap"];

  final Function(String slug, String name) onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
          isLandingScreen: false,
          title: Text(
            'Allied Therapies'.tr,
            style:
                SolhTextStyles.QS_body_semi_1.copyWith(color: SolhColors.black),
          ),
        ),
        body: ListView(
          shrinkWrap: false,
          padding: EdgeInsets.only(top: 2.h),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AlliedTherapyGrid(
                onTap: onTap,
              ),
            ),
            // GetHelpDivider(),
            // FeaturedTherapist(),
            // GetHelpDivider(),
            // PopularPackagesList(),
            // GetHelpDivider(),
            // FeatuedPackagesList(),
            // SizedBox(
            //   height: 50,
            // )
          ],
        ));
  }
}

class AlliedTherapyGrid extends StatelessWidget {
  AlliedTherapyGrid({super.key, required this.onTap});

  final Function(String slug, String name) onTap;
  GetHelpController getHelpController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() =>
        getHelpController.getAlliedTherapyModelMore.value.specializationList ==
                null
            ? Container()
            : GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                    childAspectRatio: 2 / 2.8),
                shrinkWrap: true,
                itemCount: getHelpController
                    .getAlliedTherapyModelMore.value.specializationList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      onTap(
                          getHelpController.getAlliedTherapyModelMore.value
                                  .specializationList![index].slug ??
                              '',
                          getHelpController.getAlliedTherapyModelMore.value
                                  .specializationList![index].name ??
                              '');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: SolhColors.grey_3,
                        ),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: getHelpController
                                    .getAlliedTherapyModelMore
                                    .value
                                    .specializationList![index]
                                    .displayImage ??
                                '',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          getHelpController.getAlliedTherapyModelMore.value
                                  .specializationList![index].name ??
                              '',
                          style: SolhTextStyles.QS_cap_semi,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        )
                      ]),
                    ),
                  );
                },
              ));
  }
}

class FeaturedTherapist extends StatelessWidget {
  const FeaturedTherapist({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 18,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Therapists',
                style: SolhTextStyles.QS_body_semi_1,
              ),
              Text(
                'View All'.tr,
                style: SolhTextStyles.CTA
                    .copyWith(color: SolhColors.primary_green),
              )
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
        SizedBox(
          width: 100.w,
          height: 300,
          child: ListView.separated(
            shrinkWrap: false,
            padding: EdgeInsets.only(left: 5),
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              return FeaturedTherapistCard();
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 15,
              );
            },
          ),
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }
}

class FeaturedTherapistCard extends StatelessWidget {
  const FeaturedTherapistCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          width: 170,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: SolhColors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  spreadRadius: sqrt1_2,
                  color: Colors.black12,
                )
              ]),
          child: Stack(children: [
            SvgPicture.asset('assets/images/demo.svg'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: SimpleImageContainer(
                                // zoomEnabled: true,
                                enableborder: true,
                                enableGradientBorder: true,
                                boxFit: BoxFit.cover,
                                radius: 100,
                                imageUrl: 'https://picsum.photos/200'),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 6.w,
                                  width: 12.w,
                                  decoration: BoxDecoration(
                                      color: SolhColors.light_Bg_2,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          color: Colors.black26,
                                        )
                                      ]),
                                  child: Center(
                                      child: Icon(
                                    CupertinoIcons.play_rectangle,
                                    color: SolhColors.pink224,
                                    size: 18,
                                  )),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Therepist Name',
                        style: SolhTextStyles.QS_caption_bold,
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Profession',
                            style: SolhTextStyles.QS_cap_2_semi,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          SolhDot(),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            '07 years',
                            style: SolhTextStyles.QS_cap_2_semi,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.rectangle_stack_person_crop,
                                    color: SolhColors.primary_green,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '27',
                                    style: SolhTextStyles.QS_cap_2_semi,
                                  ),
                                ],
                              ),
                              Text(
                                "Consultations".tr,
                                style: SolhTextStyles.QS_cap_2,
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.star_fill,
                                    color: SolhColors.primary_green,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '4.5',
                                    style: SolhTextStyles.QS_cap_2_semi,
                                  ),
                                ],
                              ),
                              Text(
                                'Rating'.tr,
                                style: SolhTextStyles.QS_cap_2,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        children: [
                          Text(
                            'Recorded'.tr,
                            style: SolhTextStyles.QS_cap_2_semi.copyWith(
                                color: SolhColors.pink224),
                          ),
                          Text(
                            '+ ',
                            style: SolhTextStyles.QS_cap_2_semi,
                          ),
                          Text(
                            'Live packages',
                            style: SolhTextStyles.QS_cap_2_semi.copyWith(
                                color: SolhColors.primary_green),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(child: SizedBox()),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 170,
                    height: 44,
                    decoration: BoxDecoration(
                      color: SolhColors.blue_light,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Starting @'.tr,
                          style: SolhTextStyles.QS_cap_2_semi,
                        ),
                        Text(
                          '499',
                          style: SolhTextStyles.QS_caption_bold,
                        )
                      ],
                    )),
                  ),
                ),
              ],
            )
          ]),
        ),
      ],
    );
  }
}

class PopularPackagesList extends StatelessWidget {
  const PopularPackagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 18,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Packages',
                style: SolhTextStyles.QS_body_semi_1,
              ),
              Text(
                'View All'.tr,
                style: SolhTextStyles.CTA
                    .copyWith(color: SolhColors.primary_green),
              )
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
        SizedBox(
          height: 260,
          child: ListView.separated(
              padding: EdgeInsets.only(left: 10),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return PackagesHorizontalListTile();
              },
              separatorBuilder: (context, index) => SizedBox(
                    width: 15,
                  ),
              itemCount: 6),
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }
}

class FeatuedPackagesList extends StatelessWidget {
  const FeatuedPackagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 18,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Featured Packages',
                style: SolhTextStyles.QS_body_semi_1,
              ),
              Text(
                'View All'.tr,
                style: SolhTextStyles.CTA
                    .copyWith(color: SolhColors.primary_green),
              )
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
        SizedBox(
          height: 260,
          child: ListView.separated(
              padding: EdgeInsets.only(left: 10),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return PackagesHorizontalListTile();
              },
              separatorBuilder: (context, index) => SizedBox(
                    width: 15,
                  ),
              itemCount: 6),
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }
}

class PackagesHorizontalListTile extends StatelessWidget {
  const PackagesHorizontalListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: 170,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: SolhColors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              spreadRadius: sqrt1_2,
              color: Colors.black12,
            )
          ]),
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          SimpleImageContainer(
            imageUrl: "https://picsum.photos/200",
            enableborder: true,
            enableGradientBorder: true,
            radius: 90,
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Yoga',
                  style: SolhTextStyles.QS_cap_2_semi,
                ),
                Container(
                  color: SolhColors.grey_3,
                  height: 15,
                  width: 1,
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.clock,
                      size: 15,
                      color: SolhColors.primary_green,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      '4 hrs',
                      style: SolhTextStyles.QS_cap_2_semi,
                    )
                  ],
                ),
                Container(
                  color: SolhColors.grey_3,
                  height: 15,
                  width: 1,
                ),
                Row(
                  children: [
                    Icon(
                      CupertinoIcons.increase_quotelevel,
                      size: 15,
                      color: SolhColors.primary_green,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      '07',
                      style: SolhTextStyles.QS_cap_2_semi,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 45,
              child: Text(
                'Yoga For Beginners - A Little Goes a Long Way Watch',
                style: SolhTextStyles.QS_cap_semi,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "Creator Name",
            style: SolhTextStyles.QS_caption,
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.star_lefthalf_fill,
                          size: 15,
                          color: SolhColors.primary_green,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '4.5',
                          style: SolhTextStyles.QS_cap_2_semi,
                        )
                      ],
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      color: SolhColors.grey_3,
                      height: 15,
                      width: 1,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.rectangle_stack_person_crop,
                          size: 15,
                          color: SolhColors.primary_green,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          '17',
                          style: SolhTextStyles.QS_cap_2_semi,
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: SolhColors.blue_light),
                  child: Text(
                    '₹ 499',
                    style: SolhTextStyles.QS_caption_bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
