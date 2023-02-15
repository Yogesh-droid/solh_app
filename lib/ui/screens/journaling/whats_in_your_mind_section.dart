import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/ui/screens/journaling/create-journal.dart';
import '../../../constants/api.dart';
import '../../../controllers/mood-meter/mood_meter_controller.dart';
import '../../../services/network/network.dart';
import '../../../widgets_constants/buttons/custom_buttons.dart';
import '../../../widgets_constants/constants/colors.dart';
import '../../../widgets_constants/constants/textstyles.dart';

class WhatsOnYourMindSection extends StatelessWidget {
  WhatsOnYourMindSection({Key? key, this.w}) : super(key: key);
  XFile? _xFile;
  double? w;
  File? _croppedFile;
  final JournalPageController _journalPageController = Get.find();
  final MoodMeterController moodMeterController = Get.find();
  final BottomNavigatorController bottomNavigatorController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 30,
            vertical: MediaQuery.of(context).size.height / 80,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // InkWell(
              //     onTap: () async {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => MoodMeter()));
              //       FirebaseAnalytics.instance.logEvent(
              //           name: 'MoodMeterOpenTapped',
              //           parameters: {'Page': 'MoodMeter'});
              //     },
              //     child:
              // //         SvgPicture.asset('assets/icons/app-bar/mood-meter.svg')),
              // SizedBox(
              //   width: 5,
              // ),
              SolhGreenBorderMiniButton(
                  height: 50,
                  width: w ?? 90.w,
                  alignment: Alignment.centerLeft,
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreatePostScreen()));
                    bottomNavigatorController.activeIndex.value = 1;
                  },
                  //AutoRouter.of(context).push(CreatePostScreenRouter()),
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            _journalPageController.selectedGroupId.value == ''
                                ? "What's on your mind?"
                                : "post in group",
                            style: SolhTextStyles.QS_cap_semi,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: SolhColors.primary_green),
                          child: Center(
                            child: Icon(
                              CupertinoIcons.camera,
                              color: SolhColors.white,
                            ),
                          ),
                        )
                      ],
                    );
                  })),
              // Expanded(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              // IconButton(
              //   iconSize: 24,
              //   splashRadius: 20,
              //   padding: EdgeInsets.zero,
              //   onPressed: () async {
              //     final ImagePicker _picker = ImagePicker();
              //     _xFile = await _picker.pickImage(
              //       source: ImageSource.camera,
              //       maxWidth: 640,
              //       maxHeight: 640,
              //       imageQuality: 50,
              //     );
              //     if (_xFile != null) {
              //       final croppedFile = await ImageCropper().cropImage(
              //           sourcePath: _xFile!.path,
              //           aspectRatioPresets: [
              //             CropAspectRatioPreset.square,
              //             // CropAspectRatioPreset.ratio3x2,
              //             // CropAspectRatioPreset.original,
              //             // CropAspectRatioPreset.ratio4x3,
              //             // CropAspectRatioPreset.ratio16x9
              //           ],
              //           // compressQuality:
              //           //     File(_xFile!.path).lengthSync() > 600000
              //           //         ? 20
              //           //         : 100,
              //           compressQuality:
              //               compression(File(_xFile!.path).lengthSync()),
              //           uiSettings: [
              //             AndroidUiSettings(
              //                 toolbarTitle: 'Edit',
              //                 toolbarColor: SolhColors.white,
              //                 toolbarWidgetColor: Colors.black,
              //                 activeControlsWidgetColor:
              //                     SolhColors.primary_green,
              //                 initAspectRatio:
              //                     CropAspectRatioPreset.square,
              //                 lockAspectRatio: true),
              //             IOSUiSettings(
              //               minimumAspectRatio: 1.0,
              //             )
              //           ]);
              //       _croppedFile = File(croppedFile!.path);
              //     }
              //     Map<String, dynamic> map =
              //         await _uploadImage(isVideo: false);
              //     // _xFileAsUnit8List = await _croppedFile!.readAsBytes();
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => CreatePostScreen(
              //               croppedFile: _croppedFile,
              //               map: map,
              //             )));
              //   },
              //   icon: SvgPicture.asset(
              //       "assets/icons/journaling/post-photo.svg"),
              //   color: SolhColors.primary_green,
              // // ),
              // Container(
              //   height: 3.h,
              //   width: 0.2,
              //   color: SolhColors.blackop05,
              // ),
              // IconButton(
              //   iconSize: 24,
              //   splashRadius: 20,
              //   padding: EdgeInsets.zero,
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => Connections()));
              //   },
              //   icon: SvgPicture.asset("assets/images/connections.svg"),
              //   color: SolhColors.primary_green,
              // ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
    // );
    // });
  }

  Future<Map<String, dynamic>> _uploadImage({bool? isVideo}) async {
    return await Network.uploadFileToServer(
            "${APIConstants.api}/api/fileupload/journal-image",
            "file",
            _croppedFile!,
            isVideo: null)
        .then((value) {
      return value;
    });
  }
}
