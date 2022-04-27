import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/profile/age_controller.dart';
import 'package:solh/model/user/user.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/user/user-profile.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/profile-setup/gender-age.dart';
import 'package:solh/ui/screens/widgets/dropdowns/gender-selection.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

import '../../profile-setup/add-profile-photo.dart';

class EditMyProfileScreen extends StatefulWidget {
  const EditMyProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditMyProfileScreen> createState() => _EditMyProfileScreenState();
}

class _EditMyProfileScreenState extends State<EditMyProfileScreen> {
  XFile? _xFile;
  File? _croppedFile;
  TextEditingController _firstNameTextEditingController =
      TextEditingController();
  TextEditingController _lastNameTextEditingController =
      TextEditingController();
  TextEditingController _bioTextEditingController = TextEditingController();
  TextEditingController _phoneTextEditingController = TextEditingController();
  TextEditingController _emailIdTextEditingController = TextEditingController();
  TextEditingController _genderTextEditingController = TextEditingController();
  TextEditingController _dobTextEditingController = TextEditingController();
  final AgeController _ageController = Get.find();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    userBlocNetwork.getMyProfileSnapshot();
  }

  String? _gender = "N/A";
  String? _dob = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          "Edit Profile",
          style: SolhTextStyles.AppBarText,
        ),
        isLandingScreen: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: FutureBuilder<UserModel?>(
                future: UserProfile.fetchUserProfile(
                    FirebaseAuth.instance.currentUser!.uid),
                builder: (context, userSnapshot) {
                  if (userSnapshot.hasData) {
                    _dob = '';
                    print(userSnapshot.requireData!.gender);
                    _gender = userSnapshot.requireData!.gender;
                    print(userSnapshot.requireData!.firstName);
                    _firstNameTextEditingController.text =
                        userSnapshot.requireData!.firstName!;
                    _lastNameTextEditingController.text =
                        userSnapshot.requireData!.lastName!;
                    _bioTextEditingController.text =
                        userSnapshot.requireData!.bio!;
                    _phoneTextEditingController.text =
                        userSnapshot.requireData!.mobile!;
                    _genderTextEditingController.text =
                        userSnapshot.requireData!.gender!;
                    _dobTextEditingController.text =
                        'userSnapshot.requireData!.dob';
                    _ageController.selectedAge.value = userSnapshot
                                .requireData!.dob !=
                            null
                        ? DateFormat('dd MMM yyyy')
                            .format(
                                DateTime.parse(userSnapshot.requireData!.dob!))
                            .toString()
                        : '';
                    print(_firstNameTextEditingController.text);
                    return Column(
                      children: [
                        Container(
                          height: 2.5.h,
                        ),
                        Container(
                          child: Stack(
                            children: [
                              _croppedFile != null
                                  ? CircleAvatar(
                                      radius: 14.w,
                                      backgroundImage: FileImage(_croppedFile!),
                                    )
                                  : CircleAvatar(
                                      radius: 14.w,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              userSnapshot
                                                  .data!.profilePicture!),
                                    ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: InkWell(
                                  onTap: () {
                                    _croppedFile != null
                                        ? uploadImage()
                                        : _pickImage();
                                  },
                                  child: _croppedFile != null
                                      ? Icon(Icons.check_box_outlined)
                                      : Icon(
                                          Icons.edit,
                                          color: SolhColors.green,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Text(""),
                        ),
                        TextFieldB(
                          label: "Your First Name",
                          textEditingController:
                              _firstNameTextEditingController,
                        ),
                        TextFieldB(
                          label: "Your Last Name",
                          textEditingController: _lastNameTextEditingController,
                        ),
                        TextFieldB(
                          label: "About/Bio",
                          textEditingController: _bioTextEditingController,
                          maxLine: 4,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gender",
                              style: TextStyle(color: Color(0xFFA6A6A6)),
                            ),
                            GenderSelectionDropdown(
                              dropDownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(color: SolhColors.green)),
                              newValue: (String? newValue) {
                                print(newValue);
                                _gender = newValue!;
                              },
                              initialDropdownValue:
                                  userSnapshot.requireData!.gender!,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 2.25.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "DOB",
                              style: TextStyle(color: Color(0xFFA6A6A6)),
                            ),
                            DOBPicker(
                              initialDateOfBirth: DateTime.parse(
                                  userSnapshot.requireData!.dob ??
                                      DateTime.now().toString()),
                              onChanged: (date) {
                                print(date);
                                _dob = date;
                              },
                              onDateChanged: (date) {
                                print(date);
                                _dob = DateFormat('dd MMMM yyyy').format(date);
                                _ageController.onChanged(
                                    DateFormat('dd MMMM yyyy').format(date));
                              },
                              boxDecoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  border: Border.all(
                                    color: SolhColors.green,
                                  )),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        // TextFieldB(
                        //   label: "DOB",
                        //   textEditingController: _dobTextEditingController,
                        // ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 4.h),
                          child: SolhGreenButton(
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              await Network.makeHttpPutRequestWithToken(
                                  url:
                                      "${APIConstants.api}/api/edit-user-details",
                                  body: {
                                    "first_name":
                                        _firstNameTextEditingController.text,
                                    "last_name":
                                        _lastNameTextEditingController.text,
                                    "gender": _gender,
                                    "bio": _bioTextEditingController.text,
                                    "dob": _dob
                                  });
                              setState(() {
                                _isLoading = false;
                              });
                              AutoRouter.of(context).pop();
                            },
                            child: Text("Save Changes"),
                            height: 6.5.h,
                          ),
                        ),
                      ],
                    );
                  } else
                    return Center(child: CircularProgressIndicator());
                }),
          ),
          if (_isLoading)
            Container(
                color: SolhColors.green.withOpacity(0.5),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(child: MyLoader()))
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
            toolbarTitle: 'Edit Image',
            activeControlsWidgetColor: SolhColors.green,
            toolbarColor: SolhColors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    // Navigator.of(context).pop();
    setState(() {});
  }

  Future<void> uploadImage() async {
    var response = await Network.uploadFileToServer(
        "${APIConstants.api}/api/fileupload/user-profile-picture",
        "profile",
        _croppedFile!);
    if (response["success"]) {
      Utility.showToast('Profile picture updated');
      userBlocNetwork.getMyProfileSnapshot();
    }
  }
}

class TextFieldB extends StatelessWidget {
  const TextFieldB({
    Key? key,
    required String label,
    TextEditingController? textEditingController,
    int? maxLine,
  })  : _maxLine = maxLine,
        _label = label,
        _textEditingController = textEditingController,
        super(key: key);

  final String _label;
  final int? _maxLine;
  final TextEditingController? _textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _label,
            style: TextStyle(color: Color(0xFFA6A6A6)),
          ),
          Container(
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(border: OutlineInputBorder()),
              maxLines: _maxLine,
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
