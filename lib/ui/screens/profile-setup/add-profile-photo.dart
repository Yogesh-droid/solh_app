import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/constants/enum/journal/feelings.dart';
import 'package:solh/model/journal.dart';
import 'package:solh/ui/screens/intro/intro-crousel.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';

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
  String _journalType = JournalType.Publicaly.toShortString();

  String _description = "";

  String _feelings = JournalFeelings.Happy.toShortString();

  String? _imageUrl;

  XFile? _xFile;

  Uint8List? _xFileAsUnit8List;

  File? _croppedFile;

  bool _isImageAdded = false;

  bool _isVideoAdded = false;

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              height: 20.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Choose your type"),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.photo),
                        onPressed: () async {
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
                                  toolbarTitle: 'Cropper',
                                  toolbarColor: Colors.deepOrange,
                                  toolbarWidgetColor: Colors.white,
                                  initAspectRatio:
                                      CropAspectRatioPreset.original,
                                  lockAspectRatio: false),
                              iosUiSettings: IOSUiSettings(
                                minimumAspectRatio: 1.0,
                              ));
                          Navigator.of(_).pop();
                          setState(() {
                            _isImageAdded = true;
                          });
                        },
                      ),
                      IconButton(
                        iconSize: 40,
                        icon: Icon(Icons.video_camera_back),
                        onPressed: () async {
                          print("picking video");
                          _xFile = await _picker.pickVideo(
                              source: ImageSource.gallery);
                          print(_xFile!.path.toString());

                          // _xFileAsUnit8List = await _xFile!.readAsBytes();
                          Navigator.of(_).pop();
                          setState(() {
                            _isVideoAdded = true;
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  // onPressed: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (_) => EnterDescriptionPage())
                  //         ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            )
        ],
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
