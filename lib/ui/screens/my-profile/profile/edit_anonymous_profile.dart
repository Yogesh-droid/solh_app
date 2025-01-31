import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/anon_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import '../../../../constants/api.dart';
import '../../../../services/network/network.dart';
import '../../../../services/utility.dart';
import '../../../../widgets_constants/appbars/app-bar.dart';
import '../../../../widgets_constants/constants/colors.dart';
import '../../../../widgets_constants/constants/textstyles.dart';
import '../../journaling/create-journal.dart';
import '../../profile-setup/enter-full-name.dart';

class EditAnonymousProfile extends StatefulWidget {
  const EditAnonymousProfile({Key? key}) : super(key: key);

  @override
  State<EditAnonymousProfile> createState() => _EditAnonymousProfileState();
}

class _EditAnonymousProfileState extends State<EditAnonymousProfile> {
  final AnonController _anonController = Get.put(AnonController());
  final ProfileController profileController = Get.find();
  XFile? _xFile;
  File? _croppedFile;
  String? imgUrl = '';
  String? imgType = '';
  TextEditingController _userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundArt(
        appBar: SolhAppBar(
          title: Text(
            "Edit Anonymous Profile".tr,
            style: SolhTextStyles.QS_body_1_bold,
          ),
          isLandingScreen: false,
        ),
        body: Obx(() {
          return profileController.myProfileModel.value.body!.user!.anonymous !=
                  null
              ? Column(
                  children: [
                    SizedBox(
                      height: 3.5.h,
                    ),
                    Container(
                      child: Stack(
                        children: [
                          _croppedFile != null
                              ? CircleAvatar(
                                  radius: 14.5.w,
                                  backgroundColor: SolhColors.primary_green,
                                  child: InkWell(
                                    onTap: () {
                                      _pickImage();
                                    },
                                    child: CircleAvatar(
                                      radius: 14.w,
                                      backgroundImage: FileImage(_croppedFile!),
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 14.5.w,
                                  backgroundColor: SolhColors.primary_green,
                                  child: InkWell(
                                    onTap: () {
                                      _pickImage();
                                    },
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 14.w,
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                                profileController
                                                        .myProfileModel
                                                        .value
                                                        .body!
                                                        .user!
                                                        .anonymous!
                                                        .profilePicture ??
                                                    '')),
                                  ),
                                ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: InkWell(
                                onTap: () {
                                  _croppedFile != null
                                      ? uploadImage()
                                      : _pickImage();
                                },
                                child: _croppedFile != null
                                    ? Icon(Icons.check_box_outlined,
                                        color: SolhColors.primary_green)
                                    : Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: SolhColors.primary_green,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 5,
                                                offset: Offset(0, 2)
                                                // spreadRadius: 3
                                                )
                                          ],
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            _pickImage();
                                          },
                                          iconSize: 14,
                                          icon: Icon(Icons.edit_outlined,
                                              color: SolhColors.white),
                                        ),
                                      )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 3.5.h,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18.0,
                          ),
                          child: ProfielTextField(
                            hintText: "Anonymous Username",
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textEditingController: _userNameController
                              ..text = profileController.myProfileModel.value
                                      .body!.user!.anonymous!.userName ??
                                  '',
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
                            onChanged: (val) {
                              _anonController.isNameTaken.value = false;
                              if (val!.length >= 3 &&
                                  _userNameController.text !=
                                      profileController.myProfileModel.value
                                          .body!.user!.anonymous!.userName) {
                                _anonController.checkIfUserNameTaken(val);
                              }
                            },
                          ),
                        ),
                        Obx(() {
                          return _anonController.isNameTaken.value
                              ? Text(
                                  "Username Already taken".tr,
                                  style: TextStyle(color: Colors.red),
                                )
                              : Container();
                        }),
                      ],
                    ),
                    SizedBox(
                      height: 3.5.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: SolhGreenButton(
                        child: Text(
                          "Save".tr,
                          style: SolhTextStyles.CTA
                              .copyWith(color: SolhColors.white),
                        ),
                        onPressed: () async {
                          if (_anonController.isNameTaken.value) {
                            return;
                          }
                          if (_croppedFile != null) {
                            await uploadImage();
                          }
                          if (imgUrl != null ||
                              _userNameController.text !=
                                  profileController.myProfileModel.value.body!
                                      .user!.anonymous!.userName) {
                            print('imgurl ++' + imgUrl.toString());
                            var response =
                                await Network.makePutRequestWithToken(
                                    url: "${APIConstants.api}/api/anonymous",
                                    body: {
                                  "userName": _userNameController.text,
                                  "profilePicture": imgUrl,
                                  "profilePictureType": imgType
                                });
                            debugPrint("anon upload try2 $response");
                            print(response['imageUrl']);
                          }
                          profileController.getMyProfile();
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                )
              : Container(
                  width: 150,
                  child: Center(
                      child: SolhGreenButton(
                    child: Text('Reload Profile',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      await profileController.getMyProfile();
                    },
                  )),
                );
        }));
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
      if (croppedFile != null) {
        _croppedFile = File(croppedFile.path);
      }
    }
    // Navigator.of(context).pop();
    setState(() {});
  }

  Future<void> uploadImage() async {
    var response = await Network.uploadFileToServer(
        "${APIConstants.api}/api/fileupload/anonymous", "file", _croppedFile!);
    print('upload image $response');
    if (response["success"]) {
      imgUrl = response["imageUrl"];
      imgType = response["mimetype"];
      Utility.showToast('Profile picture updated');
    }
  }
}
