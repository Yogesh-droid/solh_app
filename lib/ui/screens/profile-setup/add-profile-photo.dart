import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/intro/intro-crousel.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class AddProfilePhotoPage extends StatefulWidget {
  const AddProfilePhotoPage(
      {Key? key, required VoidCallback onNext, required VoidCallback onBack})
      : _onNext = onNext,
        _onBack = onBack,
        super(key: key);

  final VoidCallback _onNext;
  final VoidCallback _onBack;

  @override
  State<AddProfilePhotoPage> createState() => _AddProfilePhotoPageState();
}

class _AddProfilePhotoPageState extends State<AddProfilePhotoPage> {
  XFile? _xFile;
  File? _croppedFile;

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    print("picking image");
    _xFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 640,
      maxHeight: 640,
      imageQuality: 50,
    );
    print(_xFile!.path.toString());
    _croppedFile = await ImageCropper.cropImage(
        sourcePath: _xFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Edit Image',
            activeControlsWidgetColor: SolhColors.green,
            toolbarColor: SolhColors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    // Navigator.of(context).pop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget._onBack();
        return false;
      },
      child: Scaffold(
        appBar: ProfileSetupAppBar(
          title: "Add a Profile Photo",
          onBackButton: widget._onBack,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 12.h,
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
                  SkipButton(
                    onPressed: widget._onNext,
                  ),
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
                          "${APIConstants.api}/api/fileupload/user-profile-picture",
                          "profile",
                          _croppedFile!);
                      if (response["success"]) {
                        print("image uplaoded successfully");
                        widget._onNext();
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
