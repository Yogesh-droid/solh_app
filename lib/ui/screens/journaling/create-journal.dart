import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/constants/enum/journal/feelings.dart';
import 'package:solh/controllers/journals/feelings_controller.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/controllers/my_diary/my_diary_controller.dart';
import 'package:solh/model/journal.dart';
import 'package:solh/model/user/user.dart';
import 'package:solh/services/journal/create-journal.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen({Key? key, this.croppedFile}) : super(key: key);
  File? croppedFile;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  JournalPageController journalPageController = Get.find();
  MyDiaryController myDiaryController = Get.find();
  FeelingsController feelingsController = Get.find();
  String _journalType = JournalType.Publicaly.toShortString();
  String _description = "";
  String _feelings = JournalFeelings.Happy.toShortString();
  XFile? _xFile;
  File? _croppedFile;
  bool _isPosting = false;
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
                            // maxWidth: 640,
                            // maxHeight: 640,
                            // imageQuality: 100,
                          );
                          if (_xFile != null)
                            _croppedFile = await ImageCropper().cropImage(
                                sourcePath: _xFile!.path,
                                aspectRatioPresets: [
                                  CropAspectRatioPreset.square,
                                  // CropAspectRatioPreset.ratio3x2,
                                  // CropAspectRatioPreset.original,
                                  // CropAspectRatioPreset.ratio4x3,
                                  // CropAspectRatioPreset.ratio16x9
                                ],
                                androidUiSettings: AndroidUiSettings(
                                    toolbarTitle: 'Edit',
                                    toolbarColor: SolhColors.white,
                                    toolbarWidgetColor: Colors.black,
                                    activeControlsWidgetColor: SolhColors.green,
                                    initAspectRatio:
                                        CropAspectRatioPreset.square,
                                    lockAspectRatio: true),
                                iosUiSettings: IOSUiSettings(
                                  minimumAspectRatio: 1.0,
                                ));
                          // _xFileAsUnit8List = await _croppedFile!.readAsBytes();

                          Navigator.of(_).pop();
                          setState(() {
                            if (_croppedFile != null) _isImageAdded = true;
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
                      ),
                      IconButton(
                          onPressed: () async {
                            _xFile = await _picker.pickImage(
                              source: ImageSource.camera,
                              maxWidth: 640,
                              maxHeight: 640,
                              imageQuality: 100,
                            );
                            if (_xFile != null)
                              _croppedFile = await ImageCropper().cropImage(
                                  sourcePath: _xFile!.path,
                                  aspectRatioPresets: [
                                    CropAspectRatioPreset.square,
                                    // CropAspectRatioPreset.ratio3x2,
                                    // CropAspectRatioPreset.original,
                                    // CropAspectRatioPreset.ratio4x3,
                                    // CropAspectRatioPreset.ratio16x9
                                  ],
                                  androidUiSettings: AndroidUiSettings(
                                      toolbarTitle: 'Edit',
                                      toolbarColor: SolhColors.white,
                                      toolbarWidgetColor: Colors.black,
                                      activeControlsWidgetColor:
                                          SolhColors.green,
                                      initAspectRatio:
                                          CropAspectRatioPreset.square,
                                      lockAspectRatio: true),
                                  iosUiSettings: IOSUiSettings(
                                    minimumAspectRatio: 1.0,
                                  ));
                            // _xFileAsUnit8List = await _croppedFile!.readAsBytes();

                            Navigator.of(_).pop();
                            setState(() {
                              if (_croppedFile != null) _isImageAdded = true;
                            });
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            size: 40,
                          ))
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
    if (widget.croppedFile != null) {
      _croppedFile = widget.croppedFile;
      _isImageAdded = true;
    }
    userBlocNetwork.getMyProfileSnapshot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          "Create Journal",
          style: SolhTextStyles.AppBarText,
        ),
        isLandingScreen: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: StreamBuilder<UserModel?>(
                stream: userBlocNetwork.userStateStream,
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasData)
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UsernameHeader(
                            userModel: userSnapshot.requireData,
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
                                  hintStyle:
                                      TextStyle(color: Color(0xFFA6A6A6)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: SolhColors.green)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: SolhColors.green)),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: SolhColors.green))),
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
                                SolhTextStyles.JournalingDescriptionReadMoreText
                                    .copyWith(color: SolhColors.grey102),
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
                                // SolhGreenBorderButton(
                                //     child: Text(
                                //       "Add Image/Video",
                                //       style:
                                //           SolhTextStyles.GreenBorderButtonText,
                                //     ),
                                //     onPressed: _pickImage),
                                InkWell(
                                  onTap: (() {
                                    _pickImage();
                                  }),
                                  child: Image.asset(
                                      'assets/images/add_image.png',
                                      width: 100.w,
                                      height: 35.h),
                                ),
                              ],
                            )
                          else if (_isImageAdded)
                            Stack(
                              children: [
                                Image.file(_croppedFile!),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    height: 35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.6),
                                      border: Border.all(
                                          color: SolhColors.green, width: 2),
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        _xFile = null;
                                        _croppedFile = null;
                                        setState(() {
                                          _isImageAdded = false;
                                        });
                                      },
                                      iconSize: 14,
                                      icon: Icon(Icons.close,
                                          color: SolhColors.black),
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
                                    radius: 17,
                                    backgroundColor: SolhColors.green,
                                    child: CircleAvatar(
                                      backgroundColor: SolhColors.white,
                                      radius: 16,
                                      child: IconButton(
                                        onPressed: () {
                                          _xFile = null;
                                          _croppedFile = null;
                                          setState(() {
                                            _isVideoAdded = false;
                                          });
                                        },
                                        iconSize: 14,
                                        icon: Icon(
                                          Icons.close,
                                          color: SolhColors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          SizedBox(height: 5.h),
                          // SolhGreenButton(
                          //   height: 6.h,
                          //   child: Text("Post"),
                          //   backgroundColor: _description != ""
                          //       ? SolhColors.green
                          //       : SolhColors.grey,
                          //   onPressed: _postJournal,
                          // ),
                          SizedBox(height: 5.h),
                        ],
                      ),
                    );
                  return Center(child: MyLoader());
                }),
          ),
          if (_isPosting)
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: SolhColors.green.withOpacity(0.25),
              child: Center(child: MyLoader()),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: SolhColors.green,
          onPressed: _postJournal,
          label: Container(
              width: MediaQuery.of(context).size.width - 20.w,
              child: Center(child: Text("Post")))),
    );
  }

  void _postJournal() async {
    if (_description != "") {
      setState(() {
        _isPosting = true;
      });
      if (_croppedFile != null) {
        Map<String, dynamic> response = await _uploadImage();
        print(response.toString());
        if (response["success"]) {
          print(response["imageUrl"]);
          CreateJournal _createJournal = CreateJournal(
            mediaUrl: response["imageUrl"],
            description: _description,
            feelings: feelingsController.selectedFeelingsId.value,
            journalType: _journalType,
            mimetype: response["mimetype"],
          );
          await _createJournal.postJournal();
          if (_journalType == 'My_Diary') {
            await myDiaryController.getMyJournals(1);
            myDiaryController.myJournalsList.refresh();
            Utility.showToast("Post added to My Diary");
          } else {
            journalPageController.journalsList.clear();
            journalPageController.pageNo = 1;
            journalPageController.endPageLimit = 1;
            await journalPageController.getAllJournals(1);
            journalPageController.journalsList.refresh();
            setState(() {
              _isPosting = false;
            });
          }

          //journalsBloc.getJournalsSnapshot();
          Navigator.pop(context);
        }
      } else {
        CreateJournal _createJournal = CreateJournal(
          description: _description,
          feelings: feelingsController.selectedFeelingsId.value,
          journalType: _journalType,
        );
        await _createJournal.postJournal();
        if (_journalType == 'My_Diary') {
          await myDiaryController.getMyJournals(1);
          myDiaryController.myJournalsList.refresh();
          Utility.showToast("Post added to My Diary");
        } else {
          journalPageController.journalsList.clear();
          journalPageController.pageNo = 1;
          journalPageController.endPageLimit = 1;
          await journalPageController.getAllJournals(1);
          journalPageController.journalsList.refresh();
          setState(() {
            _isPosting = false;
          });
        }
        //journalsBloc.getJournalsSnapshot();

        Navigator.pop(context);
      }
    }
  }

  Future<Map<String, dynamic>> _uploadImage() async {
    return await Network.uploadFileToServer(
        "${APIConstants.api}/api/fileupload/journal-image",
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
  FeelingsController feelingsController = Get.find();
  String _selectedFeeling = "Happy";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        children: List.generate(
          feelingsController.feelingsList.length,
          (index) => GestureDetector(
            onTap: () {
              setState(() {
                _selectedFeeling =
                    feelingsController.feelingsList.value[index].feelingName ??
                        '';
                widget._onFeelingsChanged.call(_selectedFeeling);
                feelingsController.selectedFeelingsId.value =
                    feelingsController.feelingsList.value[index].sId!;
              });
            },
            child: Container(
              constraints: BoxConstraints(
                minWidth: 8.w,
                maxWidth: 24.w,
              ),
              height: 3.8.h,
              width: feelingsController
                      .feelingsList.value[index].feelingName!.length.w *
                  4,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 1.5.w),
              decoration: BoxDecoration(
                  color: _selectedFeeling ==
                          feelingsController
                              .feelingsList.value[index].feelingName
                      ? SolhColors.green
                      : Color(0xFBFBFBFB),
                  border: Border.all(
                      color: _selectedFeeling ==
                              feelingsController
                                  .feelingsList.value[index].feelingName
                          ? SolhColors.green
                          : Color(0xEFEFEFEF)),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Text(
                JournalFeelings.values[index].toShortString(),
                style: TextStyle(
                    color: _selectedFeeling ==
                            feelingsController
                                .feelingsList.value[index].feelingName
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
  const UsernameHeader(
      {Key? key,
      required Function(String) onTypeChanged,
      required UserModel? userModel})
      : _onTypeChanged = onTypeChanged,
        _userModel = userModel,
        super(key: key);
  final Function(String) _onTypeChanged;
  final UserModel? _userModel;

  @override
  _UsernameHeaderState createState() => _UsernameHeaderState();
}

class _UsernameHeaderState extends State<UsernameHeader> {
  String _dropdownValue = "Publicaly";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
                radius: 6.w,
                backgroundImage: CachedNetworkImageProvider(
                  widget._userModel!.profilePicture ??
                      "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
                )),
            SizedBox(
              width: 2.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget._userModel!.name ?? "",
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
                ),
                DropdownMenuItem(
                  child: Text("Connections"),
                  value: "Connections",
                ),
              ]),
        )
      ],
    );
  }
}
