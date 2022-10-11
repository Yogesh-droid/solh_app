import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/profile/anon_controller.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import '../../../../bloc/user-bloc.dart';
import '../../../../constants/api.dart';
import '../../../../services/network/network.dart';
import '../../../../services/utility.dart';
import '../../../../widgets_constants/appbars/app-bar.dart';
import '../../../../widgets_constants/constants/colors.dart';
import '../../../../widgets_constants/constants/textstyles.dart';
import '../../profile-setup/enter-full-name.dart';

class EditAnonymousProfile extends StatefulWidget {
  const EditAnonymousProfile({Key? key}) : super(key: key);

  @override
  State<EditAnonymousProfile> createState() => _EditAnonymousProfileState();
}

class _EditAnonymousProfileState extends State<EditAnonymousProfile> {
  final AnonController _anonController = Get.put(AnonController());
  XFile? _xFile;
  File? _croppedFile;
  String? imgUrl = '';
  String? imgType = '';
  TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
          title: Text(
            "Edit Anonymous Profile",
            style: SolhTextStyles.AppBarText,
          ),
          isLandingScreen: false,
        ),
        body: Column(
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
                          backgroundColor: SolhColors.green,
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
                          backgroundColor: SolhColors.green,
                          child: InkWell(
                            onTap: () {
                              _pickImage();
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 14.w,
                              backgroundImage: CachedNetworkImageProvider(
                                  userBlocNetwork.anonUserPic),
                            ),
                          ),
                        ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: InkWell(
                        onTap: () {
                          _croppedFile != null ? uploadImage() : _pickImage();
                        },
                        child: _croppedFile != null
                            ? Icon(Icons.check_box_outlined,
                                color: SolhColors.green)
                            : Container(
                                height: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
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
                                      color: SolhColors.green),
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textEditingController: _userNameController
                      ..text = userBlocNetwork.anonUserName,
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
                              userBlocNetwork.anonUserName) {
                        _anonController.checkIfUserNameTaken(val);
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
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
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
                          userBlocNetwork.anonUserName) {
                    var response = await Network.makePutRequestWithToken(
                        url: "${APIConstants.api}/api/anonymous",
                        body: {
                          "userName": _userNameController.text,
                          "profilePicture": imgUrl,
                          "profilePictureType": imgType
                        });
                    if (response != null) {
                      print(response['imageUrl']);
                    }
                  }
                  userBlocNetwork.getMyProfileSnapshot();
                  AutoRouter.of(context).pop();
                },
              ),
            )
          ],
        ));
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
          compressQuality: File(_xFile!.path).lengthSync() > 600000 ? 20 : 100,
          uiSettings: [
            AndroidUiSettings(
                toolbarTitle: 'Edit',
                toolbarColor: SolhColors.white,
                toolbarWidgetColor: Colors.black,
                activeControlsWidgetColor: SolhColors.green,
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
    if (response["success"]) {
      imgUrl = response["imageUrl"];
      imgType = response["mimetype"];
      Utility.showToast('Profile picture updated');
    }
  }
}
