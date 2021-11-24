import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  XFile? _xFile;
  Uint8List? _xFileAsUnit8List;
  bool _isImageAdded = false;
  bool _isVideoAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          "Create Post",
          style: SolhTextStyles.AppBarText,
        ),
        isLandingScreen: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UsernameHeader(),
              SizedBox(height: 2.h),
              Container(
                child: TextField(
                  maxLength: 240,
                  maxLines: 6,
                  minLines: 3,
                  decoration: InputDecoration(
                      fillColor: SolhColors.grey239,
                      hintText: "What's on your mind?",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: SolhColors.green)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: SolhColors.green)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: SolhColors.green))),
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                "Feelings",
                style:
                    SolhTextStyles.JournalingDescriptionReadMoreText.copyWith(
                        color: SolhColors.grey102),
              ),
              SizedBox(
                height: 1.h,
              ),
              StaggeredGridView.countBuilder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 12,
                staggeredTileBuilder: (index) => StaggeredTile.count(1, 0.4),
                itemBuilder: (context, index) => Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 1.5.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: SolhColors.green),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Text("Happy 😊"),
                ),
                crossAxisCount: 3,
              ),
              SizedBox(height: 2.h),
              if (!_isImageAdded && !_isVideoAdded)
                Column(
                  children: [
                    SolhGreenBorderButton(
                      child: Text(
                        "Pic from Diary",
                        style: SolhTextStyles.GreenBorderButtonText,
                      ),
                      onPressed: () => print("Pressed"),
                    ),
                    SizedBox(height: 2.h),
                    SolhGreenBorderButton(
                      child: Text(
                        "Add Image/Video",
                        style: SolhTextStyles.GreenBorderButtonText,
                      ),
                      onPressed: () async {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
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
                                              _xFileAsUnit8List =
                                                  await _xFile!.readAsBytes();
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
                                              _xFileAsUnit8List =
                                                  await _xFile!.readAsBytes();
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
                      },
                    ),
                  ],
                )
              else if (_isImageAdded)
                Stack(
                  children: [
                    Image.memory(_xFileAsUnit8List!),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CircleAvatar(
                        radius: 16,
                        child: IconButton(
                          onPressed: () {
                            _xFile = null;
                            _xFileAsUnit8List = null;
                            setState(() {
                              _isImageAdded = false;
                            });
                          },
                          iconSize: 14,
                          icon: Icon(Icons.close),
                        ),
                      ),
                    )
                  ],
                )
              else
                Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CircleAvatar(
                        radius: 16,
                        child: IconButton(
                          onPressed: () {
                            _xFile = null;
                            _xFileAsUnit8List = null;
                            setState(() {
                              _isVideoAdded = false;
                            });
                          },
                          iconSize: 14,
                          icon: Icon(Icons.close),
                        ),
                      ),
                    )
                  ],
                ),
              SizedBox(height: 5.h),
              SolhGreenButton(
                child: Text("Post"),
                onPressed: () async {
                  print("pressed");
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UsernameHeader extends StatefulWidget {
  const UsernameHeader({Key? key}) : super(key: key);

  @override
  _UsernameHeaderState createState() => _UsernameHeaderState();
}

class _UsernameHeaderState extends State<UsernameHeader> {
  String _dropdownValue = "P";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 6.w,
              backgroundImage: NetworkImage(
                  "https://qph.fs.quoracdn.net/main-qimg-6d89a6af21f564db1096d6dbd060f831"),
            ),
            SizedBox(
              width: 2.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Santra Johns",
                  style: SolhTextStyles.JournalingUsernameText.copyWith(
                      fontWeight: FontWeight.normal, fontSize: 14),
                ),
                Text(
                  "Happiness Maker",
                  style:
                      SolhTextStyles.JournalingBadgeText.copyWith(fontSize: 12),
                )
              ],
            ),
          ],
        ),
        Container(
          height: 4.5.h,
          width: 35.w,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              border: Border.all(
                color: SolhColors.green,
              )),
          child: DropdownButton(
              isExpanded: true,
              icon: Icon(CupertinoIcons.chevron_down),
              iconSize: 18,
              iconEnabledColor: SolhColors.green,
              underline: SizedBox(),
              value: _dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownValue = newValue!;
                });
              },
              style: TextStyle(color: SolhColors.green),
              items: [
                DropdownMenuItem(
                  child: Text("Publicaly"),
                  value: "P",
                ),
                DropdownMenuItem(child: Text("Connections"), value: "C"),
                DropdownMenuItem(
                  child: Text("MyDiary"),
                  value: "MD",
                )
              ]),
        )
      ],
    );
  }
}
