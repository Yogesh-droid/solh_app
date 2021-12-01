import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/constants/enum/journal/feelings.dart';
import 'package:solh/model/journal.dart';
import 'package:solh/ui/screens/intro/intro-crousel.dart';
import 'package:solh/ui/screens/profile-setup/description.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';

class AddProfilePhoto extends StatefulWidget {
  const AddProfilePhoto({Key? key}) : super(key: key);

  @override
  State<AddProfilePhoto> createState() => _AddProfilePhotoState();
}

class _AddProfilePhotoState extends State<AddProfilePhoto> {
  String _journalType = JournalType.Publicaly.toShortString();

  String _description = "";

  String _feelings = JournalFeelings.Happy.toShortString();

  String? _imageUrl;

  XFile? _xFile;

  Uint8List? _xFileAsUnit8List;

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
                            imageQuality: 25,
                          );
                          print(_xFile!.path.toString());
                          _xFileAsUnit8List = await _xFile!.readAsBytes();
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
                          _xFileAsUnit8List = await _xFile!.readAsBytes();
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
    // Pick an image
    // final XFile? image =
    //     await _picker.pickImage(source: ImageSource.gallery);
    // Capture a photo
    // final XFile? photo =
    //     await _picker.pickImage(source: ImageSource.camera);
    // // Pick a video
    // final XFile? video =
    //     await _picker.pickVideo(source: ImageSource.gallery);
    // // Capture a video
    // final XFile? capturedVideo =
    //     await _picker.pickVideo(source: ImageSource.camera);
    // // Pick multiple images
    // final List<XFile>? multipleFiles =
    //     await _picker.pickMultiImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileSetupAppBar(
        title: "Add a Profile Photo",
      ),
      body: Column(
        children: [
          SizedBox(
            height: 12.h,
          ),
          if (_xFileAsUnit8List != null)
            Image.memory(_xFileAsUnit8List!)
          else
            AddProfilePictureIllustration(
              onPressed: _pickImage,
            ),
          Expanded(child: Container()),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SolhGreenButton(
                child: Text("Add Image"),
                height: 6.h,
                width: MediaQuery.of(context).size.width / 1.1,
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => DescriptionScreen())),
              ),
              SizedBox(
                height: 2.h,
              ),
              SkipButton(),
              SizedBox(
                height: 3.8.h,
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
