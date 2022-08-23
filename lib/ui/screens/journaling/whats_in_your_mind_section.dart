import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/ui/screens/journaling/create-journal.dart';
import 'package:solh/ui/screens/my-profile/connections/connections.dart';
import '../../../constants/api.dart';
import '../../../controllers/mood-meter/mood_meter_controller.dart';
import '../../../services/network/network.dart';
import '../../../widgets_constants/buttons/custom_buttons.dart';
import '../../../widgets_constants/constants/colors.dart';
import '../../../widgets_constants/constants/textstyles.dart';
import '../mood-meter/mood_meter.dart';

class WhatsOnYourMindSection extends StatelessWidget {
  WhatsOnYourMindSection({
    Key? key,
  }) : super(key: key);
  XFile? _xFile;
  File? _croppedFile;
  final JournalPageController _journalPageController = Get.find();
  final MoodMeterController moodMeterController = Get.find();
  final BottomNavigatorController bottomNavigatorController = Get.find();
  @override
  Widget build(BuildContext context) {
    return
        // Obx(() {
        // return AnimatedContainer(
        //   duration: Duration(milliseconds: 300),
        //   decoration: BoxDecoration(
        //     color: Colors.white,
        // boxShadow: [
        //   BoxShadow(
        //     color: _journalPageController.isScrollingStarted.value
        //         ? Colors.black.withOpacity(0.1)
        //         : Colors.white,
        //     blurRadius: 2,
        //     spreadRadius: 2,
        //   ),
        // ],
        // ),
        // child:
        Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 30,
            vertical: MediaQuery.of(context).size.height / 80,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MoodMeter()));
                  },
                  child:
                      SvgPicture.asset('assets/icons/app-bar/mood-meter.svg')),
              SizedBox(
                width: 5,
              ),
              SolhGreenBorderMiniButton(
                  height: MediaQuery.of(context).size.height / 18,
                  width: 60.w,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ),
                  onPressed: () {
                    bottomNavigatorController.tabrouter!.setActiveIndex(1);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreatePostScreen()));
                  },
                  //AutoRouter.of(context).push(CreatePostScreenRouter()),
                  child: Obx(() {
                    return Text(
                      _journalPageController.selectedGroupId.value == ''
                          ? "What's on your mind?"
                          : "post in group",
                      style: SolhTextStyles.JournalingHintText,
                    );
                  })),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      iconSize: 24,
                      splashRadius: 20,
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        _xFile = await _picker.pickImage(
                          source: ImageSource.camera,
                          maxWidth: 640,
                          maxHeight: 640,
                          imageQuality: 50,
                        );
                        if (_xFile != null) {
                          final croppedFile = await ImageCropper().cropImage(
                              sourcePath: _xFile!.path,
                              aspectRatioPresets: [
                                CropAspectRatioPreset.square,
                                // CropAspectRatioPreset.ratio3x2,
                                // CropAspectRatioPreset.original,
                                // CropAspectRatioPreset.ratio4x3,
                                // CropAspectRatioPreset.ratio16x9
                              ],
                              compressQuality:
                                  File(_xFile!.path).lengthSync() > 600000
                                      ? 20
                                      : 100,
                              uiSettings: [
                                AndroidUiSettings(
                                    toolbarTitle: 'Edit',
                                    toolbarColor: SolhColors.white,
                                    toolbarWidgetColor: Colors.black,
                                    activeControlsWidgetColor: SolhColors.green,
                                    initAspectRatio:
                                        CropAspectRatioPreset.square,
                                    lockAspectRatio: true),
                                IOSUiSettings(
                                  minimumAspectRatio: 1.0,
                                )
                              ]);
                          _croppedFile = File(croppedFile!.path);
                        }
                        Map<String, dynamic> map =
                            await _uploadImage(isVideo: false);
                        // _xFileAsUnit8List = await _croppedFile!.readAsBytes();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CreatePostScreen(
                                  croppedFile: _croppedFile,
                                  map: map,
                                )));
                      },
                      icon: SvgPicture.asset(
                          "assets/icons/journaling/post-photo.svg"),
                      color: SolhColors.green,
                    ),
                    Container(
                      height: 3.h,
                      width: 0.2,
                      color: SolhColors.blackop05,
                    ),
                    IconButton(
                      iconSize: 24,
                      splashRadius: 20,
                      padding: EdgeInsets.zero,
                      onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Connections()))
                      },
                      icon: SvgPicture.asset("assets/images/connections.svg"),
                      color: SolhColors.green,
                    ),
                  ],
                ),
              ),
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
