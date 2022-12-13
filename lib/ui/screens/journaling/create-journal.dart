import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/bottom-navigation/bottom_navigator_controller.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/controllers/connections/tag_controller.dart';
import 'package:solh/controllers/journals/feelings_controller.dart';
import 'package:solh/controllers/journals/journal_page_controller.dart';
import 'package:solh/controllers/my_diary/my_diary_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
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
import '../../../controllers/profile/anon_controller.dart';
import '../../../model/journals/journals_response_model.dart';
import '../../../model/profile/my_profile_model.dart';
import '../../../widgets_constants/buttons/custom_buttons.dart';
import '../profile-setup/add-profile-photo.dart';
import '../profile-setup/enter-full-name.dart';
import 'trimmer_view.dart';

// Map selectedItems = {};

// List<bool> isSelected = [];

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
  BottomNavigatorController bottomNavigatorController = Get.find();
  TagsController tagsController = Get.put(TagsController());
  FocusNode _customFeelingFocusNode = FocusNode();
  XFile? _xFile;
  File? _croppedFile;
  bool? isVideoPicked;
  bool _isPosting = false;
  bool _isImageAdded = false;
  bool _isVideoAdded = false;
  double? aspectRatio;
  double? mediaHeight;
  double? mediaWidth;
  Map<String, dynamic> imgUploadResponse = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      feelingsController.selectedFeelingsId.value = [];
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
    });

    // userBlocNetwork.getMyProfileSnapshot();
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
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UsernameHeader(
                      //userModel: userBlocNetwork.myData,
                      onTypeChanged: (value) {
                        print("Changed to $value");
                        _journalType = value;
                      },
                    ),
                    SizedBox(height: 2.h),
                    JournalTextField(),
                    SizedBox(height: 1.h),
                    getFeelingTitle(),
                    SizedBox(
                      height: 1.h,
                    ),
                    FeelingsContainer(
                      userBlocNetwork.myData,
                      onFeelingsChanged: (feelings) {
                        print("feelings changed to: $feelings");
                      },
                    ),
                    SizedBox(height: 2.h),
                    getMediaContainer(),
                    SizedBox(height: 10.h),
                    //getCustomFeelingTextBox(),
                  ],
                ),
              ),
            ),
            if (_isPosting)
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: SolhColors.primary_green.withOpacity(0.25),
                child: Center(child: MyLoader()),
              ),
            Column(
              children: [
                Spacer(),
                getCustomFeelingTextBox(),
              ],
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
                                backgroundColor: SolhColors.primary_green,
                                onPressed: () {
                                  if (journalPageController
                                          .descriptionController.text.isEmpty &&
                                      feelingsController
                                          .selectedFeelingsId.value.isEmpty &&
                                      _croppedFile == null) {
                                    Utility.showToast(
                                        "Please fill one of the fields");
                                    return;
                                  }
                                  _postJournal();
                                },
                                label: Container(
                                    width: MediaQuery.of(context).size.width -
                                        20.w,
                                    child: Center(
                                        child: Text(
                                      "Post",
                                      style: TextStyle(color: SolhColors.white),
                                    ))))
                            : Container();
                      });
              }));
  }

  String getDescriptionTags() {
    String x = '';
    print('it ran');
    tagsController.selectedItems.keys.forEach((key) {
      x += '@' + key + ' ';
    });

    return x;
  }

  void _postJournal() async {
    ////////  post anonymous is done by passing isAnonymous = true

    setState(() {
      _isPosting = true;
    });
    if (_croppedFile != null ||
        journalPageController.selectedDiary.value.mediaType != null) {
      List<String> feelings = [];
      feelingsController.selectedFeelingsId.value.forEach((element) {
        feelings.add(element);
      });
      CreateJournal _createJournal = CreateJournal(
          postId: journalPageController.selectedDiary.value.id,
          mediaUrl: journalPageController.selectedDiary.value.mediaType != null
              ? journalPageController.selectedDiary.value.mediaUrl
              : imgUploadResponse["imageUrl"],
          description: journalPageController.descriptionController.text +
              " " +
              getDescriptionTags(),
          feelings: feelings,
          journalType: _journalType,
          mimetype: journalPageController.selectedDiary.value.mediaType != null
              ? journalPageController.selectedDiary.value.mediaType
              : imgUploadResponse["mimetype"],
          groupId: journalPageController.selectedGroupId.value,
          isAnonymous: journalPageController.isAnonymousSelected.value,
          mediaHeight: mediaHeight ?? 0.0,
          mediaWidth: mediaWidth ?? 0.0,
          aspectRatio: aspectRatio ?? 0.0);
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
        description: journalPageController.descriptionController.text +
            " " +
            getDescriptionTags(),
        feelings: feelings,
        journalType: _journalType,
        groupId: journalPageController.selectedGroupId.value,
        isAnonymous: journalPageController.isAnonymousSelected.value,
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
    if (bottomNavigatorController.activeIndex == 1) {
      Navigator.pop(context);
    } else {
      bottomNavigatorController.activeIndex.value = 1;
      Navigator.pop(context);
    }
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      border:
                          Border.all(color: SolhColors.primary_green, width: 1),
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
                        Stack(
                          children: [
                            Positioned(
                              top: 5,
                              left: 7,
                              child: Center(
                                child: Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffEFEFEF),
                                    )),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _customFeelingController.clear();
                                _customFeelingFocusNode.unfocus();
                                feelingsController
                                    .isCreatingCustomFeeling.value = false;
                              },
                              icon: Icon(
                                Icons.clear,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            Positioned(
                              top: 5,
                              left: 7,
                              child: Center(
                                child: Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: SolhColors.primary_green,
                                    )),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  if (_customFeelingController.text != "") {
                                    feelingsController.createCustomFeeling(
                                        _customFeelingController.text);
                                    _customFeelingController.clear();
                                    _customFeelingFocusNode.unfocus();
                                    feelingsController
                                        .isCreatingCustomFeeling.value = false;
                                  }
                                },
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 20,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
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
              color: SolhColors.dark_grey),
        ),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(width: 5.w),
            // Expanded(child: Obx(() {
            //   return TextFormField(
            //     enabled: feelingsController.isSearching.value,
            //     focusNode: _searchFeelingFocusNode,
            //     controller: _searchController,
            //     decoration: InputDecoration(
            //         hintText:
            //             feelingsController.isSearching.value ? "Search" : "",
            //         border: feelingsController.isSearching.value
            //             ? UnderlineInputBorder(
            //                 borderSide:
            //                     BorderSide(color: SolhColors.green, width: 1),
            //               )
            //             : InputBorder.none,
            //         suffixIcon: feelingsController.isSearching.value
            //             ? IconButton(
            //                 onPressed: () {
            //                   _searchController.clear();
            //                   _searchFeelingFocusNode.unfocus();
            //                   feelingsController.isSearching.value = false;
            //                 },
            //                 icon: Icon(Icons.clear),
            //               )
            //             : Container()),
            //     keyboardType: TextInputType.text,
            //   );
            // })),
            // Obx(() {
            //   return feelingsController.isSearching.value
            //       ? Container()
            //       : IconButton(
            //           onPressed: () {
            //             feelingsController.isSearching.value = true;
            //             _searchFeelingFocusNode.requestFocus();
            //           },
            //           icon: Icon(
            //             Icons.search,
            //             color: SolhColors.green,
            //             size: 18,
            //           ));
            // }),
            IconButton(
              onPressed: () {
                feelingsController.isCreatingCustomFeeling.value = true;
                _customFeelingFocusNode.requestFocus();
              },
              icon: Icon(
                Icons.add,
                color: SolhColors.primary_green,
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
                      width: double.infinity,
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
                          border: Border.all(
                              color: SolhColors.primary_green, width: 2),
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
                            border: Border.all(
                                color: SolhColors.primary_green, width: 2),
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
                    Image.file(
                      _croppedFile!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.6),
                          border: Border.all(
                              color: SolhColors.primary_green, width: 2),
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
                              child: Container(
                                height: 7,
                                width: MediaQuery.of(context).size.width - 20,
                                child: LinearProgressIndicator(
                                  backgroundColor: Colors.red.withOpacity(0.5),
                                  color: SolhColors.primary_green,
                                ),
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
                                    color: SolhColors.primary_green, width: 2),
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
                                          SolhColors.primary_green),
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
                                    .copyWith(color: SolhColors.dark_grey),
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
                            imageQuality: 100,
                          );
                          if (_xFile != null) {
                            print("image picked");
                            print(
                                'Size Original is ${File(_xFile!.path).lengthSync()}');
                            final croppedFile = await ImageCropper().cropImage(
                                sourcePath: _xFile!.path,
                                aspectRatioPresets: [
                                  // CropAspectRatioPreset.ratio3x2,
                                  CropAspectRatioPreset.original,
                                  CropAspectRatioPreset.square,
                                  // CropAspectRatioPreset.ratio4x3,
                                  // CropAspectRatioPreset.ratio16x9,
                                ],
                                compressQuality: compression(
                                    File(_xFile!.path).lengthSync()),
                                // File(_xFile!.path).lengthSync() > 600000
                                //     ? 20
                                //     : 100,
                                uiSettings: [
                                  AndroidUiSettings(
                                      toolbarTitle: 'Edit',
                                      toolbarColor: SolhColors.white,
                                      toolbarWidgetColor: Colors.black,
                                      activeControlsWidgetColor:
                                          SolhColors.primary_green,
                                      initAspectRatio:
                                          CropAspectRatioPreset.square,
                                      lockAspectRatio: false),
                                  IOSUiSettings(
                                    minimumAspectRatio: 1.0,
                                  )
                                ]);

                            _croppedFile = File(croppedFile!.path);
                            print(
                                'THis is after cropping ${_croppedFile!.lengthSync().toString()}');

                            setState(() {
                              print(
                                  'Size Cropped is ${_croppedFile!.lengthSync()}');
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
                          VideoPlayerController vc =
                              VideoPlayerController.network(
                                  imgUploadResponse["imageUrl"]);

                          await vc.initialize();
                          aspectRatio = vc.value.size.aspectRatio;
                          mediaHeight = vc.value.size.height;
                          mediaWidth = vc.value.size.width;

                          print("/" * 30 + aspectRatio.toString() + "/" * 30);

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
                              // maxWidth: 640,
                              // maxHeight: 640,
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
                                      compressQuality: compression(
                                          File(_xFile!.path).lengthSync()),
                                      // File(_xFile!.path).lengthSync() >
                                      //         600000
                                      //     ? 20
                                      //     : 100,
                                      uiSettings: [
                                        AndroidUiSettings(
                                            toolbarTitle: 'Edit',
                                            toolbarColor: SolhColors.white,
                                            toolbarWidgetColor: Colors.black,
                                            activeControlsWidgetColor:
                                                SolhColors.primary_green,
                                            initAspectRatio:
                                                CropAspectRatioPreset.square,
                                            lockAspectRatio: true),
                                        IOSUiSettings(
                                          minimumAspectRatio: 1.0,
                                        )
                                      ]);

                              _croppedFile = File(croppedFile!.path);
                              print(
                                  'THis is after cropping ${_croppedFile!.lengthSync().toString()}');

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
}

class FeelingsContainer extends StatefulWidget {
  const FeelingsContainer(
    UserModel? requireData, {
    Key? key,
    required Function(String) onFeelingsChanged,
  })  : _onFeelingsChanged = onFeelingsChanged,
        _userModel = requireData,
        super(key: key);

  final Function(String) _onFeelingsChanged;
  final UserModel? _userModel;

  @override
  State<FeelingsContainer> createState() => _FeelingsContainerState();
}

class _FeelingsContainerState extends State<FeelingsContainer> {
  FeelingsController feelingsController = Get.find();
  String _selectedFeeling = "Happy";
  ScrollController _scrollController = ScrollController(
    initialScrollOffset: 0,
    keepScrollOffset: true,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      alignment: Alignment.centerLeft,
      child: RawScrollbar(
        thumbColor: Color(0xFFA6A6A6),
        controller: _scrollController,
        trackVisibility: true,
        thumbVisibility: true,
        radius: Radius.circular(30),
        thickness: 6,
        scrollbarOrientation: ScrollbarOrientation.bottom,
        interactive: true,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 18.0),
          child: Container(
            //maxWidth: MediaQuery.of(context).size.width,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Obx(() {
              return GridView(
                controller: _scrollController,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 15.h,
                    mainAxisSpacing: 0),
                children: List.generate(
                  feelingsController.feelingsList.length,
                  (index) => InkWell(
                    onLongPress: () {
                      feelingsController.feelingsList[index].createdBy ==
                              widget._userModel!.sId
                          ? showDeletePopUp(index)
                          : null;
                      print(widget._userModel!.sId);
                      print(feelingsController.feelingsList[index].createdBy);
                    },
                    child: FilterChip(
                        selectedColor: SolhColors.primary_green,
                        backgroundColor: Color(0xFFEFEFEF),
                        showCheckmark: false,
                        label: Text(feelingsController
                                .feelingsList.value[index].feelingName ??
                            ''),
                        labelStyle: feelingsController.selectedFeelingsId.value
                                .contains(feelingsController
                                    .feelingsList.value[index].sId!)
                            ? Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: SolhColors.white)
                            : Theme.of(context).textTheme.bodyText2,
                        onSelected: (value) {
                          widget._onFeelingsChanged.call(_selectedFeeling);
                          feelingsController.selectedFeelingsId.contains(
                                  feelingsController
                                      .feelingsList.value[index].sId)
                              ? feelingsController.selectedFeelingsId.remove(
                                  feelingsController
                                      .feelingsList.value[index].sId)
                              : feelingsController.selectedFeelingsId.add(
                                  feelingsController
                                      .feelingsList.value[index].sId);
                        },
                        selected: feelingsController.selectedFeelingsId.value
                            .contains(feelingsController
                                .feelingsList.value[index].sId!)),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  void showDeletePopUp(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Feeling'),
          content: Text('Are you sure you want to delete this feeling?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                feelingsController.deleteCustomFeeling(
                    feelingsController.feelingsList.value[index].sId ?? '',
                    index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class UsernameHeader extends StatefulWidget {
  UsernameHeader({
    Key? key,
    required Function(String) onTypeChanged,
  })  : _onTypeChanged = onTypeChanged,
        super(key: key);
  final Function(String) _onTypeChanged;

  @override
  _UsernameHeaderState createState() => _UsernameHeaderState();
}

class _UsernameHeaderState extends State<UsernameHeader> {
  JournalPageController journalPageController = Get.find();
  String _dropdownValue = "Publicaly";
  AnonController _anonController = Get.find();
  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getUserImg(),
              SizedBox(
                width: 2.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Column(
                    children: [
                      Obx(() => profileController.myProfileModel.value.body !=
                              null
                          ? Row(
                              children: [
                                Text(
                                  journalPageController.isAnonymousSelected ==
                                          true
                                      ? (profileController
                                              .myProfileModel
                                              .value
                                              .body!
                                              .user!
                                              .anonymous!
                                              .userName!
                                              .isNotEmpty
                                          ? profileController
                                              .myProfileModel
                                              .value
                                              .body!
                                              .user!
                                              .anonymous!
                                              .userName!
                                          : 'Anonymous')
                                      : profileController.myProfileModel.value
                                              .body!.user!.name ??
                                          "",
                                  style: SolhTextStyles.JournalingUsernameText
                                      .copyWith(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14),
                                ),
                                journalPageController.isAnonymousSelected ==
                                        false
                                    ? profileController.myProfileModel.value
                                                .body!.user!.isSolhExpert !=
                                            null
                                        ? Text(profileController.myProfileModel
                                                .value.body!.user!.isSolhExpert!
                                            ? ''
                                            : '')
                                        : Container()
                                    : Container()
                              ],
                            )
                          : Container()),
                      SizedBox(
                        height: 1.h,
                      ),
                      // Obx(() =>
                      //     profileController.myProfileModel.value.body != null
                      //         ? GetBadge(
                      //             userType: profileController.myProfileModel
                      //                     .value.body!.user!.userType ??
                      //                 '')
                      //         : Container()),
                      SizedBox(
                        height: 4.h,
                      ),
                    ],
                  ),
                  // Text(
                  //   "Happiness Maker",
                  //   style: SolhTextStyles.JournalingBadgeText.copyWith(
                  //       fontSize: 12),
                  // )
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
                        color: SolhColors.primary_green,
                      )),
                  child: DropdownButton(
                      isExpanded: true,
                      icon: Icon(CupertinoIcons.chevron_down),
                      iconSize: 18,
                      iconEnabledColor: SolhColors.primary_green,
                      underline: SizedBox(),
                      value: _dropdownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropdownValue = newValue!;
                        });
                        widget._onTypeChanged.call(_dropdownValue);
                      },
                      style: TextStyle(color: SolhColors.primary_green),
                      items: [
                        DropdownMenuItem(
                          child: Text("Publically"),
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
    });
  }

  Widget getUserImg() {
    return Obx(
      () => profileController.myProfileModel.value.body != null
          ? GestureDetector(
              onTap: () {
                if (profileController
                        .myProfileModel.value.body!.user!.anonymous !=
                    null) {
                  journalPageController.isAnonymousSelected.value =
                      !journalPageController.isAnonymousSelected.value;
                } else {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => PickUsernameScreen()));\
                  openCreateAnonymousBottomSheet();
                }
              },
              child: Container(
                  height: 10.h,
                  width: 20.w,
                  child: Obx(() {
                    return journalPageController.isAnonymousSelected.value

                        /// if anonymous is selected
                        ? getAnonymousStack(
                            profileController.myProfileModel.value.body!.user)
                        : getNormalStack(
                            profileController.myProfileModel.value.body!.user);
                  })))
          : CircleAvatar(
              radius: journalPageController.anonymousProfileRadius.value,
              backgroundColor: Colors.grey,
              backgroundImage: CachedNetworkImageProvider(
                "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
              )),
    );
  }

  Widget getNormalStack(User? userModel) {
    return Stack(
      children: [
        getCircleImg(
          radius: journalPageController.anonymousProfileRadius.value,
          imgUrl: userModel!.anonymous != null
              ? userModel.anonymous!.profilePicture ??
                  "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y"
              : "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
          top: journalPageController.anonymousProfilePositionT.value,
          left: journalPageController.anonymousProfilePositionL.value,
        ),
        getCircleImg(
          radius: journalPageController.nomalProfileRadius.value,
          imgUrl: userModel.profilePicture ??
              "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
          top: journalPageController.nomalProfilePositionT.value,
          left: journalPageController.nomalProfilePositionL.value,
        ),
        Positioned(
          left: 0,
          top: -5,
          child: InkWell(
            onTap: () {
              /// if Anon user is true anonymous, then show anonymous profile picture

              if (userModel.anonymous != null) {
                journalPageController.isAnonymousSelected.value =
                    !journalPageController.isAnonymousSelected.value;
              } else {
                openCreateAnonymousBottomSheet();
              }
            },
            child: Icon(
              Icons.swap_horiz,
              color: SolhColors.primary_green,
            ),
          ),
        )
      ],
    );
  }

  Widget getAnonymousStack(User? userModel) {
    return Stack(
      children: [
        getCircleImg(
          radius: journalPageController.anonymousProfileRadius.value,
          imgUrl: userModel!.profilePicture,
          top: journalPageController.anonymousProfilePositionT.value,
          left: journalPageController.anonymousProfilePositionL.value,
        ),
        userModel.anonymous != null
            ? getCircleImg(
                radius: journalPageController.nomalProfileRadius.value,
                imgUrl: userModel.anonymous!.profilePicture ??
                    "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
                top: journalPageController.nomalProfilePositionT.value,
                left: journalPageController.nomalProfilePositionL.value,
              )
            : Container(),
        userModel.anonymous != null
            ? Positioned(
                left: 0,
                top: -5,
                child: InkWell(
                  onTap: () {
                    journalPageController.isAnonymousSelected.value =
                        !journalPageController.isAnonymousSelected.value;
                    print(journalPageController.isAnonymousSelected.value);
                  },
                  child: Icon(
                    Icons.swap_horiz,
                    color: SolhColors.primary_green,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget getCircleImg(
      {required double radius,
      String? imgUrl,
      required double top,
      required double left}) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      top: top,
      left: left,
      child: CircleAvatar(
          radius: radius,
          backgroundColor: Colors.grey,
          backgroundImage: CachedNetworkImageProvider(
            imgUrl ??
                "https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y",
          )),
    );
  }

  void openCreateAnonymousBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => AnonymousBottomSheet(onTap: () async {
              await _anonController.createAnonProfile();
              await Get.find<ProfileController>().getMyProfile();
              Navigator.pop(context);
              // setState(() {
              //   widget._userModel = userBlocNetwork.myData;
              // });
            }));
  }
}

class JournalTextField extends StatefulWidget {
  const JournalTextField({Key? key}) : super(key: key);

  @override
  State<JournalTextField> createState() => _JournalTextFieldState();
}

class _JournalTextFieldState extends State<JournalTextField> {
  JournalPageController journalPageController = Get.find();
  TagsController _tagsController = Get.put(TagsController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: SolhColors.primary_green)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (Value) async {
                    var cursorPos = journalPageController
                        .descriptionController.selection.base.offset;

                    if (cursorPos - 1 == -1) {
                      return;
                    }

                    if (journalPageController
                            .descriptionController.text[cursorPos - 1] ==
                        '@') {
                      // await showMenu(
                      //     context: context,
                      //     constraints: BoxConstraints.expand(
                      //         height: _connectionController.myConnectionModel
                      //                     .value.myConnections!.length >
                      //                 4
                      //             ? 200
                      //             : _connectionController.myConnectionModel
                      //                     .value.myConnections!.length *
                      //                 50,
                      //         width: 150),
                      //     position: RelativeRect.fromLTRB(0, 320, 0, 0),
                      //     items: _connectionController
                      //         .myConnectionModel.value.myConnections!
                      //         .map((e) => PopupMenuItem(
                      //             onTap: () {
                      //               if (cursorPos == 1 ||
                      //                   cursorPos ==
                      //                       journalPageController
                      //                           .descriptionController
                      //                           .text
                      //                           .length) {
                      //                 journalPageController
                      //                     .descriptionController
                      //                     .text = journalPageController
                      //                         .descriptionController.text +
                      //                     e.userName.toString() +
                      //                     ' ';
                      //               } else {
                      //                 journalPageController
                      //                     .descriptionController
                      //                     .text = journalPageController
                      //                         .descriptionController.text
                      //                         .substring(0, cursorPos + 1) +
                      //                     e.userName.toString() +
                      //                     ' ' +
                      //                     journalPageController
                      //                         .descriptionController.text
                      //                         .substring(cursorPos + 1);
                      //               }
                      //             },
                      //             child: Text(e.userName!)))
                      //         .toList());
                    }
                  },
                  controller: journalPageController.descriptionController,
                  maxLines: 6,
                  minLines: 3,
                  autocorrect: true,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    fillColor: SolhColors.grey239,
                    hintText: "What's on your mind?",
                    hintStyle: TextStyle(color: Color(0xFFA6A6A6)),
                    // enabledBorder: OutlineInputBorder(
                    //     borderSide: BorderSide(color: SolhColors.green)),
                    // focusedBorder: OutlineInputBorder(
                    //     borderSide: BorderSide(color: SolhColors.green)),
                    // border: OutlineInputBorder(
                    //     borderSide: BorderSide(color: SolhColors.green))
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
                GetBuilder<TagsController>(
                    init: _tagsController,
                    builder: (_tagsController) {
                      return Container(
                        width: 80.w,
                        child: Wrap(
                          children: _tagsController.selectedItems.keys
                              .toList()
                              .map((key) {
                            return Text(
                              '@' + key.toString() + '  ',
                              style: GoogleFonts.signika(
                                fontSize: 12,
                                color: SolhColors.primary_green,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        child: ModalBottomSheetContent(),
                      );
                    });
              },
              child: Container(
                height: 24,
                width: 52,
                decoration: BoxDecoration(
                  color: Color(0xffEFEFEF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tag',
                      style: TextStyle(color: SolhColors.primary_green),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    SvgPicture.asset('assets/images/plus.svg'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ModalBottomSheetContent extends StatefulWidget {
  ModalBottomSheetContent({Key? key}) : super(key: key);

  @override
  State<ModalBottomSheetContent> createState() =>
      _ModalBottomSheetContentState();
}

class _ModalBottomSheetContentState extends State<ModalBottomSheetContent> {
  ConnectionController _connectionController = Get.find();

  TagsController _tagsController = Get.put(TagsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
            child: Column(
              children: [
                Container(
                  height: 5,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select People',
                        style: GoogleFonts.signika(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                )
              ],
            ),
          ),
          SizedBox(
            height: 6,
          ),
          _connectionController.myConnectionModel.value.myConnections!.length ==
                  0
              ? Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.error,
                        color: Colors.grey.shade300,
                        size: 100,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Oops! No connection found.',
                        style: GoogleFonts.signika(
                            fontSize: 20, color: Colors.green.shade300),
                      )
                    ],
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: _connectionController
                          .myConnectionModel.value.myConnections!.length,
                      itemBuilder: (context, index) {
                        if (_connectionController
                                .myConnectionModel.value.myConnections!.length >
                            _tagsController.selectedTags.length) {
                          _tagsController.selectedTags.add(false);
                        }
                        return InkWell(
                          onTap: () {
                            if (_tagsController.selectedTags[index] == true) {
                              print('ran if 1');
                              _tagsController.selectedTags[index] = false;
                            } else {
                              print('ran if 2');
                              _tagsController.selectedTags[index] = true;
                            }
                            // if (_tagsController.selectedTags[index]) {
                            //   print('ran if 2');
                            //   _tagsController.selectedTags[index] = true;
                            // }
                            print(_tagsController.selectedTags.toString() +
                                index.toString());
                            if (_tagsController.selectedTags[index]) {
                              _tagsController.selectedItems[
                                  _connectionController.myConnectionModel.value
                                      .myConnections![index].userName!] = true;
                              _tagsController.update();
                            }
                            if (_tagsController.selectedTags[index] == false) {
                              _tagsController.selectedItems.remove(
                                  _connectionController.myConnectionModel.value
                                      .myConnections![index].userName!);
                              _tagsController.update();
                            }
                            print(_tagsController.selectedTags.length);
                            print(_tagsController.selectedItems.toString());
                            setState(() {});
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    backgroundImage: NetworkImage(
                                        _connectionController
                                            .myConnectionModel
                                            .value
                                            .myConnections![index]
                                            .profilePicture!),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8, 0, 30, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _connectionController
                                                .myConnectionModel
                                                .value
                                                .myConnections![index]
                                                .name!,
                                            style: GoogleFonts.signika(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            _connectionController
                                                .myConnectionModel
                                                .value
                                                .myConnections![index]
                                                .bio!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    side: MaterialStateBorderSide.resolveWith(
                                      (states) => BorderSide(
                                          width: 1.0, color: Colors.white),
                                    ),
                                    activeColor: SolhColors.primary_green,
                                    value: _tagsController.selectedTags[index],
                                    shape: CircleBorder(),
                                    onChanged: (bool? value) {
                                      if (_tagsController.selectedTags[index] ==
                                          true) {
                                        print('ran if 1');
                                        _tagsController.selectedTags[index] =
                                            false;
                                      } else {
                                        print('ran if 2');
                                        _tagsController.selectedTags[index] =
                                            true;
                                      }
                                      // if (_tagsController.selectedTags[index]) {
                                      //   print('ran if 2');
                                      //   _tagsController.selectedTags[index] = true;
                                      // }
                                      print(_tagsController.selectedTags
                                              .toString() +
                                          index.toString());
                                      if (_tagsController.selectedTags[index]) {
                                        _tagsController.selectedItems[
                                            _connectionController
                                                .myConnectionModel
                                                .value
                                                .myConnections![index]
                                                .userName!] = true;
                                        _tagsController.update();
                                      }
                                      if (_tagsController.selectedTags[index] ==
                                          false) {
                                        _tagsController.selectedItems.remove(
                                            _connectionController
                                                .myConnectionModel
                                                .value
                                                .myConnections![index]
                                                .userName!);
                                        _tagsController.update();
                                      }
                                      print(
                                          _tagsController.selectedTags.length);
                                      print(_tagsController.selectedItems
                                          .toString());
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )
        ],
      ),
    );
  }
}

class AnonymousBottomSheet extends StatefulWidget {
  const AnonymousBottomSheet({Key? key, required Callback onTap})
      : _onTap = onTap,
        super(key: key);
  final Callback _onTap;

  @override
  State<AnonymousBottomSheet> createState() => _AnonymousBottomSheetState();
}

class _AnonymousBottomSheetState extends State<AnonymousBottomSheet> {
  final AnonController _anonController = Get.find();

  XFile? _xFile;

  File? _croppedFile;

  final TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 5,
              width: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: SolhColors.grey),
            ),
          ),
          Divider(
            color: SolhColors.grey,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Anonymous Profile',
            style: SolhTextStyles.JournalingUsernameText,
          ),
          Text(
            'Post or leave a comment, join group, book \n appointment, etc anonymously.',
            style: SolhTextStyles.JournalingHintText,
            textAlign: TextAlign.center,
          ),
          getUserName(),
          SizedBox(
            height: 30,
          ),
          getDoneButton()
        ],
      ),
    );
  }

  getUserName() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if (_croppedFile != null)
            Stack(
              children: [
                CircleAvatar(
                  radius: 6.5.w,
                  child: CircleAvatar(
                    radius: 6.w,
                    backgroundImage: FileImage(_croppedFile!),
                  ),
                ),
                Positioned(
                    top: -2.h,
                    right: -3.w,
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
            Container(
              height: 50,
              width: 70,
              child: AddProfilePictureIllustration(
                onPressed: _pickImage,
              ),
            ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: [
              Container(
                width: 300,
                child: ProfielTextField(
                  hintText: "Anonymous Username",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textEditingController: _userNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      _anonController.isNameTaken.value = false;
                    }
                    return value == ''
                        ? "Required*"
                        : value.length < 3
                            ? "Username must be at least 3 characters long"
                            : null;
                  },
                  onChanged: (val) async {
                    print(_userNameController.text);
                    _anonController.isNameTaken.value = false;
                    if (val!.length >= 3) {
                      _anonController.checkIfUserNameTaken(val);
                      _anonController.userName.value = val;
                    }
                  },
                ),
              ),
              Obx(() {
                return _anonController.isNameTaken.value
                    ? Text(
                        "Username Already taken",
                        style: TextStyle(color: Colors.red),
                      )
                    : Container();
              })
            ],
          ),
        ],
      ),
    );
  }

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
          //compressQuality: File(_xFile!.path).lengthSync() > 600000 ? 20 : 100,
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
      var response = await Network.uploadFileToServer(
          "${APIConstants.api}/api/fileupload/anonymous",
          "file",
          _croppedFile!);

      if (response["success"]) {
        print("image uplaoded successfully");
        _anonController.avtarImageUrl.value = response["imageUrl"];
        _anonController.avtarType.value = response["mimetype"];
      }
      // Navigator.of(context).pop();
      setState(() {});
    }
  }

  getDoneButton() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SolhGreenButton(
            height: 6.h,
            child: Text("Next"),
            onPressed: _anonController.isNameTaken.value
                ? () {
                    Utility.showToast('Username Already taken');
                  }
                : widget._onTap));
  }
}

int compression(int filesize) {
  print('This is original size ${filesize.toString()}');

  if (filesize > 4485760) {
    return 20;
  } else if (filesize >= 1000000 && filesize <= 4485760) {
    return 30;
  } else {
    return 40;
  }
}
