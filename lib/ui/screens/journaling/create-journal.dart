import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/constants/enum/journal/feelings.dart';
import 'package:solh/model/journal.dart';
import 'package:solh/model/user/user.dart';
import 'package:solh/services/journal/journal.dart';
import 'package:solh/services/network/network.dart';
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
  String _journalType = JournalType.Publicaly.toShortString();
  String _description = "";
  String _feelings = JournalFeelings.Happy.toShortString();
  String? _imageUrl;
  XFile? _xFile;
  File? _croppedFile;
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
                            imageQuality: 50,
                          );
                          print(_xFile!.path.toString());
                          _croppedFile = await ImageCropper.cropImage(
                              sourcePath: _xFile!.path,
                              aspectRatioPresets: [
                                // CropAspectRatioPreset.square,
                                CropAspectRatioPreset.ratio3x2,
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
                          // _xFileAsUnit8List = await _croppedFile!.readAsBytes();

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
  void initState() {
    super.initState();
    userBlocNetwork.getMyProfileSnapshot();
  }

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
              UsernameHeader(
                onTypeChanged: (value) {
                  print("Changed to $value");
                  _journalType = value;
                },
              ),
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
                  onChanged: (value) {
                    if (_description == "" || value == "") {
                      setState(() {
                        _description = value;
                      });
                    } else
                      _description = value;
                  },
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
              FeelingsContainer(
                onFeelingsChanged: (feelings) {
                  _feelings = feelings;
                  print("feelings changed to: $feelings");
                },
              ),
              SizedBox(height: 2.h),
              if (!_isImageAdded && !_isVideoAdded)
                Column(
                  children: [
                    // SolhGreenBorderButton(
                    //   child: Text(
                    //     "Pic from Diary",
                    //     style: SolhTextStyles.GreenBorderButtonText,
                    //   ),
                    //   onPressed: () => print("Pressed"),
                    // ),
                    SizedBox(height: 2.h),
                    SolhGreenBorderButton(
                        child: Text(
                          "Add Image/Video",
                          style: SolhTextStyles.GreenBorderButtonText,
                        ),
                        onPressed: _pickImage),
                  ],
                )
              else if (_isImageAdded)
                Stack(
                  children: [
                    Image.file(_croppedFile!),
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
                backgroundColor:
                    _description != "" ? SolhColors.green : SolhColors.grey,
                onPressed: _postJournal,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _postJournal() async {
    if (_description != "") {
      if (_croppedFile != null) {
        Map<String, dynamic> response = await _uploadImage();
        print(response.toString());
        if (response["success"]) {
          print(response["imageUrl"]);
          CreateJournal _createJournal = CreateJournal(
              mediaUrl: response["imageUrl"],
              description: _description,
              feelings: _feelings,
              journalType: _journalType,
              mimetype: response["mimetype"],
              location: response["imageUrl"]);
          _createJournal.postJournal();
        }
      } else {
        CreateJournal _createJournal = CreateJournal(
          description: _description,
          feelings: _feelings,
          journalType: _journalType,
        );
        _createJournal.postJournal();
      }
    }
  }

  Future<Map<String, dynamic>> _uploadImage() async {
    return await Network.uploadFileToServer(
        "${APIConstants.aws}/api/fileupload/journal-image",
        "file",
        _croppedFile!);
    // return await Network.makeHttpPostRequestWithToken(
    //     url: "${APIConstants.aws}",
    //     body: {"file": _croppedFile!.readAsBytesSync()});
  }
}

class FeelingsContainer extends StatefulWidget {
  const FeelingsContainer({
    Key? key,
    required Function(String) onFeelingsChanged,
  })  : _onFeelingsChanged = onFeelingsChanged,
        super(key: key);

  final Function(String) _onFeelingsChanged;

  @override
  State<FeelingsContainer> createState() => _FeelingsContainerState();
}

class _FeelingsContainerState extends State<FeelingsContainer> {
  String _selectedFeeling = "Happy";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        children: List.generate(
          JournalFeelings.values.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedFeeling =
                    JournalFeelings.values[index].toShortString();
                widget._onFeelingsChanged.call(_selectedFeeling);
              });
            },
            child: Container(
              constraints: BoxConstraints(
                minWidth: 8.w,
                maxWidth: 24.w,
              ),
              height: 3.8.h,
              width: JournalFeelings.values[index].toShortString().length.w * 4,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 1.5.w),
              decoration: BoxDecoration(
                  color: _selectedFeeling ==
                          JournalFeelings.values[index].toShortString()
                      ? SolhColors.green
                      : Color(0xFBFBFBFB),
                  border: Border.all(
                      color: _selectedFeeling ==
                              JournalFeelings.values[index].toShortString()
                          ? SolhColors.green
                          : Color(0xEFEFEFEF)),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text(
                JournalFeelings.values[index].toShortString(),
                style: TextStyle(
                    color: _selectedFeeling ==
                            JournalFeelings.values[index].toShortString()
                        ? Colors.white
                        : Color(0xFF666666)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UsernameHeader extends StatefulWidget {
  const UsernameHeader({Key? key, required Function(String) onTypeChanged})
      : _onTypeChanged = onTypeChanged,
        super(key: key);
  final Function(String) _onTypeChanged;

  @override
  _UsernameHeaderState createState() => _UsernameHeaderState();
}

class _UsernameHeaderState extends State<UsernameHeader> {
  String _dropdownValue = "Publicaly";

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel?>(
        stream: userBlocNetwork.userStateStream,
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData)
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
                          userSnapshot.requireData!.name,
                          style: SolhTextStyles.JournalingUsernameText.copyWith(
                              fontWeight: FontWeight.normal, fontSize: 14),
                        ),
                        Text(
                          "Happiness Maker",
                          style: SolhTextStyles.JournalingBadgeText.copyWith(
                              fontSize: 12),
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
                        widget._onTypeChanged.call(_dropdownValue);
                      },
                      style: TextStyle(color: SolhColors.green),
                      items: [
                        DropdownMenuItem(
                          child: Text("Publicaly"),
                          value: "Publicaly",
                        ),
                        DropdownMenuItem(
                          child: Text("My Diary"),
                          value: "My_Diary",
                        )
                      ]),
                )
              ],
            );
          return Container();
        });
  }
}
