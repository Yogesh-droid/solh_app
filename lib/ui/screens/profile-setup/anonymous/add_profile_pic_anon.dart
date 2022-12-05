import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/profile/anon_controller.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/intro/intro-crousel.dart';
import 'package:solh/ui/screens/profile-setup/anonymous/anon_landing_page.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import '../../../../widgets_constants/constants/textstyles.dart';
import '../../journaling/create-journal.dart';

class AddProfilePicAnon extends StatefulWidget {
  const AddProfilePicAnon({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProfilePicAnon> createState() => _AddProfilePhotoPageState();
}

class _AddProfilePhotoPageState extends State<AddProfilePicAnon> {
  XFile? _xFile;
  File? _croppedFile;
  AnonController anonController = Get.find();

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    print("picking image");
    _xFile = await _picker.pickImage(
      source: ImageSource.gallery,
      // maxWidth: 640,
      // maxHeight: 640,
      // imageQuality: 50,
    );
    print(_xFile!.path.toString());
    if (_xFile != null) {
      final croppedFile = await ImageCropper().cropImage(
          sourcePath: _xFile!.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
          // compressQuality: File(_xFile!.path).lengthSync() > 600000 ? 20 : 100,
          compressQuality: compression(File(_xFile!.path).lengthSync()),
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Edit',
                toolbarColor: SolhColors.white,
                toolbarWidgetColor: Colors.black,
                activeControlsWidgetColor: SolhColors.primary_green,
                initAspectRatio: CropAspectRatioPreset.square,
                lockAspectRatio: true),
            IOSUiSettings(
              minimumAspectRatio: 1.0,
            )
          ]);
      _croppedFile = File(croppedFile!.path);
    }
    // Navigator.of(context).pop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        //widget._onBack();
        return true;
      },
      child: Scaffold(
        appBar: ProfileSetupAppBar(
          title: "Add a Profile Photo",
          onBackButton: () {
            Navigator.of(context).pop();
          },
        ),
        body: Column(
          children: [
            Text(
              "Add a profile photo help other people build the right first impression of your anonymous profile",
              style: SolhTextStyles.ProfileSetupSubHeading,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 3.5.h,
            ),
            if (_croppedFile != null)
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30.5.w,
                    child: CircleAvatar(
                      radius: 30.w,
                      backgroundImage: FileImage(_croppedFile!),
                    ),
                  ),
                  Positioned(
                      top: -2.h,
                      right: 0,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              _croppedFile = null;
                            });
                          },
                          icon: Icon(Icons.close)))
                ],
              )
            else
              AddProfilePictureIllustration(
                onPressed: _pickImage,
              ),
            Expanded(child: Container()),
            if (_croppedFile == null)
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SolhGreenButton(
                    child: Text("Add Image"),
                    height: 6.h,
                    width: MediaQuery.of(context).size.width / 1.1,
                    onPressed: _pickImage,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  SkipButton(onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AnonLandingPage(),
                      ),
                    );
                  }),
                  SizedBox(
                    height: 6.h,
                  ),
                ],
              )
            else
              Column(
                children: [
                  SolhGreenButton(
                    child: Text("Next"),
                    height: 6.h,
                    width: MediaQuery.of(context).size.width / 1.1,
                    onPressed: () async {
                      var response = await Network.uploadFileToServer(
                          "${APIConstants.api}/api/fileupload/anonymous",
                          "file",
                          _croppedFile!);
                      if (response["success"]) {
                        print("image uplaoded successfully");
                        anonController.avtarImageUrl.value =
                            response["imageUrl"];
                        anonController.avtarType.value = response["mimetype"];
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AnonLandingPage(),
                          ),
                        );
                        //widget._onNext();
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}

class AddProfilePictureIllustration extends StatelessWidget {
  const AddProfilePictureIllustration({
    Key? key,
    required VoidCallback onPressed,
  })  : _onPressed = onPressed,
        super(key: key);

  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onPressed,
      child: Container(
        child: Stack(
          children: [
            SvgPicture.asset("assets/icons/profile-setup/profile.svg"),
            Positioned(
                right: 0,
                bottom: 0,
                child: SvgPicture.asset("assets/icons/profile-setup/add.svg"))
          ],
        ),
      ),
    );
  }
}
