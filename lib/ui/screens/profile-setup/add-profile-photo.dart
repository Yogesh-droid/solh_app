import 'dart:developer';
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

import '../journaling/create-journal.dart';

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

  void _pickImage(ImageSource imageSource) async {
    final ImagePicker _picker = ImagePicker();
    print("picking image");
    _xFile = await _picker.pickImage(
      source: imageSource,
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
                onPressed: () {
                  showModalSheet();
                },
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
                    onPressed: () {
                      showModalSheet();
                    },
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
                      print(_croppedFile!.path);
                      var response = await Network.uploadFileToServer(
                          "${APIConstants.api}/api/fileupload/user-profile-picture",
                          "profile",
                          _croppedFile!);
                      log("${response}",
                          name: "/api/fileupload/user-profile-picture");
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

  showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 20.h,
            child: Column(
              children: [
                Text("Choose your type"),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      iconSize: 40,
                      icon: Icon(Icons.photo),
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      },
                    ),
                    IconButton(
                      iconSize: 40,
                      icon: Icon(Icons.camera_alt),
                      onPressed: () {
                        _pickImage(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        });
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
