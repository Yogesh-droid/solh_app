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
import 'package:video_player/video_player.dart';
import 'package:video_trimmer/video_trimmer.dart';
import '../../../model/journals/journals_response_model.dart';
import 'trimmer_view.dart';

class CreatePostScreen extends StatefulWidget {
  CreatePostScreen(
      {Key? key, this.croppedFile, this.map, this.isPostedFromDiaryDetails})
      : super(key: key);
  File? croppedFile;
  Map<String, dynamic>? map;
  Trimmer trimmer = Trimmer();
  final bool? isPostedFromDiaryDetails;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  JournalPageController journalPageController = Get.find();
  MyDiaryController myDiaryController = Get.find();
  FeelingsController feelingsController = Get.find();
  String _journalType = JournalType.Publicaly.toShortString();
  TextEditingController _customFeelingController = TextEditingController();
  TextEditingController _searchController = TextEditingController();
  FocusNode _customFeelingFocusNode = FocusNode();
  FocusNode _searchFeelingFocusNode = FocusNode();
  XFile? _xFile;
  File? _croppedFile;
  bool? isVideoPicked;
  bool _isPosting = false;
  bool _isImageAdded = false;
  bool _isVideoAdded = false;
  Map<String, dynamic> imgUploadResponse = {};

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
                                uiSettings: [
                                  AndroidUiSettings(
                                      toolbarTitle: 'Edit',
                                      toolbarColor: SolhColors.white,
                                      toolbarWidgetColor: Colors.black,
                                      activeControlsWidgetColor:
                                          SolhColors.green,
                                      initAspectRatio:
                                          CropAspectRatioPreset.square,
                                      lockAspectRatio: true),
                                  IOSUiSettings(
                                    minimumAspectRatio: 1.0,
                                  )
                                ]);

                            _croppedFile = File(croppedFile!.path);

                            setState(() {
                              if (_croppedFile != null) _isImageAdded = true;
                            });
                            Navigator.pop(context);
                            imgUploadResponse =
                                await _uploadImage(isVideo: false);
                          }

                          // _xFileAsUnit8List = await _croppedFile!.readAsBytes();
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

                          ////////////////////////////////////////////////////////////
                          /// For video trimming

                          if (_xFile != null) {
                            widget.trimmer
                                .loadVideo(videoFile: File(_xFile!.path));
                            imgUploadResponse =
                                await Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return TrimmerView(File(_xFile!.path));
                              }),
                            );
                            Navigator.pop(context);
                          }

                          ////////////////////////////////////////////////////////////
                          ///

                          // _xFileAsUnit8List = await _xFile!.readAsBytes();
                          // Navigator.of(_).pop();
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
                            if (_xFile != null) {
                              final croppedFile = await ImageCropper()
                                  .cropImage(
                                      sourcePath: _xFile!.path,
                                      aspectRatioPresets: [
                                    CropAspectRatioPreset.square,
                                    // CropAspectRatioPreset.ratio3x2,
                                    // CropAspectRatioPreset.original,
                                    // CropAspectRatioPreset.ratio4x3,
                                    // CropAspectRatioPreset.ratio16x9
                                  ],
                                      uiSettings: [
                                    AndroidUiSettings(
                                        toolbarTitle: 'Edit',
                                        toolbarColor: SolhColors.white,
                                        toolbarWidgetColor: Colors.black,
                                        activeControlsWidgetColor:
                                            SolhColors.green,
                                        initAspectRatio:
                                            CropAspectRatioPreset.square,
                                        lockAspectRatio: true),
                                    IOSUiSettings(
                                      minimumAspectRatio: 1.0,
                                    )
                                  ]);

                              _croppedFile = File(croppedFile!.path);

                              setState(() {
                                if (_croppedFile != null) _isImageAdded = true;
                              });
                              Navigator.pop(context);

                              imgUploadResponse =
                                  await _uploadImage(isVideo: false);
                            }
                            // _xFileAsUnit8List = await _croppedFile!.readAsBytes();
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
  }

  @override
  void initState() {
    super.initState();
    if (widget.isPostedFromDiaryDetails == null) {
      journalPageController.selectedDiary.value = Journals();
      _customFeelingController.clear();
      feelingsController.selectedFeelingsId.value.clear();
      _searchController.clear();
      journalPageController.descriptionController.clear();
    }

    if (widget.croppedFile != null) {
      _croppedFile = widget.croppedFile;
      _isImageAdded = true;
    }
    if (widget.map != null) {
      print("map is not null + " + widget.map.toString());
      imgUploadResponse = widget.map!;
    }
    userBlocNetwork.getMyProfileSnapshot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
          title: Text(
              journalPageController.selectedGroupId.value == ''
                  ? "Create Journal"
                  : "Post in group",
              style: SolhTextStyles.JournalingUsernameText),
          isLandingScreen: false,
          isDiaryBtnShown: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: StreamBuilder<UserModel?>(
                  stream: userBlocNetwork.userStateStream,
                  builder: (context, userSnapshot) {
                    if (userSnapshot.hasData)
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 2.h),
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
                                controller:
                                    journalPageController.descriptionController,
                                maxLength: 240,
                                maxLines: 6,
                                minLines: 3,
                                decoration: InputDecoration(
                                    fillColor: SolhColors.grey239,
                                    hintText: "What's on your mind?",
                                    hintStyle:
                                        TextStyle(color: Color(0xFFA6A6A6)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: SolhColors.green)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: SolhColors.green)),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: SolhColors.green))),
                                onChanged: (value) async {
                                  if (value == '@') {
                                    await showMenu(
                                      context: context,
                                      position: RelativeRect.fromLTRB(
                                          200, 150, 100, 100),
                                      items: [
                                        PopupMenuItem(
                                          value: 1,
                                          child: Text(
                                            "ROHIT",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto',
                                                color: Colors.green),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 2,
                                          child: Text(
                                            "REKHA",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto',
                                                color: Colors.green),
                                          ),
                                        ),
                                        PopupMenuItem(
                                          value: 3,
                                          child: Text(
                                            "DHRUV",
                                            style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Roboto',
                                                color: Colors.green),
                                          ),
                                        ),
                                      ],
                                      elevation: 8.0,
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 1.h),
                            getFeelingTitle(),
                            SizedBox(
                              height: 1.h,
                            ),
                            FeelingsContainer(
                              onFeelingsChanged: (feelings) {
                                print("feelings changed to: $feelings");
                              },
                            ),
                            SizedBox(height: 2.h),
                            getMediaContainer(),
                            SizedBox(height: 10.h),
                            getCustomFeelingTextBox(),
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
        floatingActionButton: _isPosting
            ? Container()
            : Obx(() {
                return journalPageController.isImageUploading.value
                    ? Container()
                    : Obx(() {
                        return !feelingsController
                                    .isCreatingCustomFeeling.value &&
                                !feelingsController.isSearching.value
                            ? FloatingActionButton.extended(
                                backgroundColor: SolhColors.green,
                                onPressed: _postJournal,
                                label: Container(
                                    width: MediaQuery.of(context).size.width -
                                        20.w,
                                    child: Center(child: Text("Post"))))
                            : Container();
                      });
              }));
  }

  void _postJournal() async {
    setState(() {
      _isPosting = true;
    });
    if (_croppedFile != null ||
        journalPageController.selectedDiary.value.mediaType != null) {
      // Map<String, dynamic> response =
      //     journalPageController.selectedDiary.value.mediaType != null
      //         ? {}
      //         : await _uploadImage();
      List<String> feelings = [];
      feelingsController.selectedFeelingsId.value.forEach((element) {
        feelings.add(element);
      });
      CreateJournal _createJournal = CreateJournal(
        postId: journalPageController.selectedDiary.value.id,
        mediaUrl: journalPageController.selectedDiary.value.mediaType != null
            ? journalPageController.selectedDiary.value.mediaUrl
            : imgUploadResponse["imageUrl"],
        description: journalPageController.descriptionController.text,
        feelings: feelings,
        journalType: _journalType,
        mimetype: journalPageController.selectedDiary.value.mediaType != null
            ? journalPageController.selectedDiary.value.mediaType
            : imgUploadResponse["mimetype"],
        groupId: journalPageController.selectedGroupId.value,
      );
      print('posting + ${journalPageController.selectedDiary.value.id}');
      journalPageController.selectedDiary.value.id != null
          ? await _createJournal.postJournalFromDiary()
          : await _createJournal.postJournal();
      if (_journalType == 'My_Diary') {
        await myDiaryController.getMyJournals(1);
        myDiaryController.myJournalsList.refresh();
        Utility.showToast("Post added to My Diary");
      } else {
        journalPageController.journalsList.clear();
        journalPageController.pageNo = 1;
        journalPageController.endPageLimit = 1;
        journalPageController.selectedGroupId.value != ''
            ? await journalPageController.getAllJournals(1,
                groupId: journalPageController.selectedGroupId.value)
            : await journalPageController.getAllJournals(1);
        journalPageController.journalsList.refresh();
        setState(() {
          _isPosting = false;
        });
      }
    } else {
      List<String> feelings = [];
      feelingsController.selectedFeelingsId.value.forEach((element) {
        feelings.add(element);
      });
      CreateJournal _createJournal = CreateJournal(
        postId: journalPageController.selectedDiary.value.id,
        description: journalPageController.descriptionController.text,
        feelings: feelings,
        journalType: _journalType,
        groupId: journalPageController.selectedGroupId.value,
      );
      print(_createJournal.groupId);
      print('posting + ${journalPageController.selectedDiary.value.id}');
      journalPageController.selectedDiary.value.id != null
          ? await _createJournal.postJournalFromDiary()
          : await _createJournal.postJournal();

      if (_journalType == 'My_Diary') {
        await myDiaryController.getMyJournals(1);
        myDiaryController.myJournalsList.refresh();
        Utility.showToast("Post added to My Diary");
      } else {
        journalPageController.journalsList.clear();
        journalPageController.pageNo = 1;
        journalPageController.endPageLimit = 1;
        //await journalPageController.getAllJournals(1);
        journalPageController.selectedGroupId.value != ''
            ? await journalPageController.getAllJournals(1,
                groupId: journalPageController.selectedGroupId.value)
            : await journalPageController.getAllJournals(1);
        journalPageController.journalsList.refresh();
        setState(() {
          _isPosting = false;
        });
      }
      //journalsBloc.getJournalsSnapshot();
    }

    Navigator.pop(context);
  }

  Future<Map<String, dynamic>> _uploadImage({bool? isVideo}) async {
    journalPageController.isImageUploading.value = true;
    print(_croppedFile!.path + " " + _croppedFile!.lengthSync().toString());
    return await Network.uploadFileToServer(
            "${APIConstants.api}/api/fileupload/journal-image",
            "file",
            _croppedFile!,
            isVideo: isVideoPicked)
        .then((value) {
      journalPageController.isImageUploading.value = false;
      return value;
    });
  }

  Widget getCustomFeelingTextBox() {
    return Obx(() {
      return feelingsController.isCreatingCustomFeeling.value
          ? Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: SolhColors.green, width: 1),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 5.w),
                      Expanded(
                        child: TextField(
                          focusNode: _customFeelingFocusNode,
                          controller: _customFeelingController,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Feeling/Emotion",
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      IconButton(
                        onPressed: () {
                          _customFeelingController.clear();
                          _customFeelingFocusNode.unfocus();
                          feelingsController.isCreatingCustomFeeling.value =
                              false;
                        },
                        icon: Icon(Icons.clear),
                      ),
                      IconButton(
                          onPressed: () {
                            if (_customFeelingController.text != "") {
                              feelingsController.createCustomFeeling(
                                  _customFeelingController.text);
                              _customFeelingController.clear();
                              _customFeelingFocusNode.unfocus();
                              feelingsController.isCreatingCustomFeeling.value =
                                  false;
                            }
                          },
                          icon: Icon(Icons.check))
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            )
          : Container();
    });
  }

  Widget getFeelingTitle() {
    return Row(
      children: [
        Text(
          "  Feelings",
          style: SolhTextStyles.JournalingDescriptionReadMoreText.copyWith(
              color: SolhColors.grey102),
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: 5.w),
            Expanded(child: Obx(() {
              return TextFormField(
                enabled: feelingsController.isSearching.value,
                focusNode: _searchFeelingFocusNode,
                controller: _searchController,
                decoration: InputDecoration(
                    hintText:
                        feelingsController.isSearching.value ? "Search" : "",
                    border: feelingsController.isSearching.value
                        ? UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: SolhColors.green, width: 1),
                          )
                        : InputBorder.none,
                    suffixIcon: feelingsController.isSearching.value
                        ? IconButton(
                            onPressed: () {
                              _searchController.clear();
                              _searchFeelingFocusNode.unfocus();
                              feelingsController.isSearching.value = false;
                            },
                            icon: Icon(Icons.clear),
                          )
                        : Container()),
                keyboardType: TextInputType.text,
              );
            })),
            Obx(() {
              return feelingsController.isSearching.value
                  ? Container()
                  : IconButton(
                      onPressed: () {
                        feelingsController.isSearching.value = true;
                        _searchFeelingFocusNode.requestFocus();
                      },
                      icon: Icon(
                        Icons.search,
                        color: SolhColors.green,
                        size: 18,
                      ));
            }),
            IconButton(
              onPressed: () {
                feelingsController.isCreatingCustomFeeling.value = true;
                _customFeelingFocusNode.requestFocus();
              },
              icon: Icon(
                Icons.add,
                color: SolhColors.green,
                size: 18,
              ),
            )
          ],
        ))
      ],
    );
  }

  Widget getMediaContainer() {
    return Obx(() {
      return journalPageController.selectedDiary.value.mediaType != null
          ? journalPageController.selectedDiary.value.mediaType == 'image/png'
              ? Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          journalPageController.selectedDiary.value.mediaUrl ??
                              '',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey,
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.6),
                          border: Border.all(color: SolhColors.green, width: 2),
                        ),
                        child: IconButton(
                          onPressed: () {
                            journalPageController
                                .selectedDiary.value.mediaType = null;

                            setState(() {
                              _isImageAdded = false;
                            });
                          },
                          iconSize: 14,
                          icon: Icon(Icons.close, color: SolhColors.black),
                        ),
                      ),
                    )
                  ],
                )
              : Container(
                  child: Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 200,
                        child: VideoPlayer(
                          VideoPlayerController.network(
                            journalPageController
                                    .selectedDiary.value.mediaUrl ??
                                '',
                          )..initialize(),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.6),
                            border:
                                Border.all(color: SolhColors.green, width: 2),
                          ),
                          child: IconButton(
                            onPressed: () {
                              journalPageController
                                  .selectedDiary.value.mediaType = null;

                              setState(() {
                                _isImageAdded = false;
                              });
                            },
                            iconSize: 14,
                            icon: Icon(Icons.close, color: SolhColors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                )
          /////////  the above portion was if my diary is selected and below is if my diary is not selected
          : _isImageAdded
              ? Stack(
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
                          border: Border.all(color: SolhColors.green, width: 2),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _xFile = null;
                            _croppedFile = null;
                            journalPageController
                                .selectedDiary.value.mediaType = null;
                            setState(() {
                              _isImageAdded = false;
                            });
                          },
                          iconSize: 14,
                          icon: Icon(Icons.close, color: SolhColors.black),
                        ),
                      ),
                    ),
                    Obx(() {
                      return journalPageController.isImageUploading.value
                          ? Positioned(
                              left: 0,
                              top: 0,
                              child: LinearProgressIndicator(
                                value: 0.0,
                                backgroundColor: Colors.blue.withOpacity(0.5),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    SolhColors.green),
                              ),
                            )
                          : Container();
                    })
                  ],
                )
              : _isVideoAdded
                  ? Obx(() {
                      if (journalPageController.outputPath.value.length > 0) {
                        widget.trimmer.loadVideo(
                            videoFile:
                                File(journalPageController.outputPath.value));
                        _croppedFile =
                            File(journalPageController.outputPath.value);

                        isVideoPicked = true;
                      }
                      return Stack(
                        children: [
                          VideoViewer(trimmer: widget.trimmer),
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
                                  journalPageController
                                      .selectedDiary.value.mediaType = null;
                                  setState(() {
                                    _isVideoAdded = false;
                                  });
                                },
                                iconSize: 14,
                                icon:
                                    Icon(Icons.close, color: SolhColors.black),
                              ),
                            ),
                          ),
                          Obx(() {
                            return journalPageController.isImageUploading.value
                                ? Positioned(
                                    left: 0,
                                    top: 0,
                                    child: LinearProgressIndicator(
                                      value: 0.0,
                                      backgroundColor:
                                          Colors.blue.withOpacity(0.5),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          SolhColors.green),
                                    ),
                                  )
                                : Container();
                          })
                        ],
                      );
                    })
                  : Column(
                      children: [
                        SizedBox(height: 2.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "  Add Image/Video",
                            style:
                                SolhTextStyles.JournalingDescriptionReadMoreText
                                    .copyWith(color: SolhColors.grey102),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        InkWell(
                          onTap: (() {
                            FocusScope.of(context).unfocus();
                            _pickImage();
                          }),
                          child: Image.asset('assets/images/add_image.png',
                              width: 100.w, height: 35.h),
                        ),
                      ],
                    );
    });
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
      height: 20.h,
      alignment: Alignment.centerLeft,
      child: Scrollbar(
        //isAlwaysShown: true,
        child: Container(
          //maxWidth: MediaQuery.of(context).size.width,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Obx(() {
            return GridView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisExtent: 15.h, mainAxisSpacing: 0),
              children: List.generate(
                feelingsController.feelingsList.length,
                (index) => FilterChip(
                    selectedColor: SolhColors.green,
                    backgroundColor: Color(0xFFEFEFEF),
                    showCheckmark: false,
                    label: Text(feelingsController
                            .feelingsList.value[index].feelingName ??
                        ''),
                    labelStyle: TextStyle(
                        color: feelingsController.selectedFeelingsId.value
                                .contains(feelingsController
                                    .feelingsList.value[index].sId!)
                            ? Colors.white
                            : Color(0xFF666666)),
                    onSelected: (value) {
                      widget._onFeelingsChanged.call(_selectedFeeling);
                      feelingsController.selectedFeelingsId.contains(
                              feelingsController.feelingsList.value[index].sId)
                          ? feelingsController.selectedFeelingsId.remove(
                              feelingsController.feelingsList.value[index].sId)
                          : feelingsController.selectedFeelingsId.add(
                              feelingsController.feelingsList.value[index].sId);
                    },
                    selected: feelingsController.selectedFeelingsId.value
                        .contains(
                            feelingsController.feelingsList.value[index].sId!)),
              ),
            );
          }),
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
  JournalPageController journalPageController = Get.find();
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
        journalPageController.selectedGroupId.value == ''
            ? Container(
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
                        child: Text("Publicly"),
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
            : Container()
      ],
    );
  }
}
