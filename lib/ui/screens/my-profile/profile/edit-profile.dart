import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/getHelp/get_help_controller.dart';
import 'package:solh/controllers/profile/age_controller.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/my-profile/profile/edit_anonymous_profile.dart';
import 'package:solh/ui/screens/profile-setup/gender-age.dart';
import 'package:solh/ui/screens/widgets/dropdowns/gender-selection.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';

import '../../../../controllers/profile/anon_controller.dart';
import '../../journaling/create-journal.dart';

class EditMyProfileScreen extends StatefulWidget {
  const EditMyProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditMyProfileScreen> createState() => _EditMyProfileScreenState();
}

class _EditMyProfileScreenState extends State<EditMyProfileScreen> {
  XFile? _xFile;
  File? _croppedFile;
  String? country;
  TextEditingController _firstNameTextEditingController =
      TextEditingController();
  TextEditingController _lastNameTextEditingController =
      TextEditingController();
  TextEditingController _bioTextEditingController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  final AgeController _ageController = Get.find();
  final AnonController _anonController = Get.find();
  final ProfileController profileController = Get.find();

  String? _gender = "Other";
  String? _dob = "";

  @override
  void initState() {
    getUserCountry();
    fillUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWithBackgroundArt(
      appBar: SolhAppBar(
        title: Text(
          "Personal Details",
          style: SolhTextStyles.QS_body_1_bold,
        ),
        isLandingScreen: false,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 2.5.h,
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
                    : Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                blurRadius: 2,
                                color: Colors.black38,
                              )
                            ]),
                        child: CircleAvatar(
                          radius: 14.5.w,
                          backgroundColor: SolhColors.primary_green,
                          child: InkWell(
                            onTap: () {
                              _pickImage();
                            },
                            child: CircleAvatar(
                              radius: 14.w,
                              backgroundImage: profileController
                                      .isEditProfilePicUploading.value
                                  ? CachedNetworkImageProvider(
                                      'https://banner2.cleanpng.com/20180628/xvr/kisspng-apple-id-computer-icons-macos-axle-load-5b354557d17970.908537281530217815858.jpg')
                                  : CachedNetworkImageProvider(profileController
                                          .myProfileModel
                                          .value
                                          .body!
                                          .user!
                                          .profilePicture ??
                                      ''),
                            ),
                          ),
                        ),
                      ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: InkWell(
                      onTap: () {
                        _croppedFile != null ? uploadImage() : _pickImage();
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
            height: 1.5.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return _anonController.isNormalNameTaken.value
                    ? Text(
                        "Username Already taken",
                        style: TextStyle(color: Colors.red),
                      )
                    : Container();
              }),
            ],
          ),
          TextFieldB(
            label: "Your First Name",
            textEditingController: _firstNameTextEditingController,
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
                style: SolhTextStyles.QS_caption_bold,
              ),
              GenderSelectionDropdown(
                dropDownDecoration: BoxDecoration(
                  color: SolhColors.light_Bg,
                  borderRadius: BorderRadius.circular(6),
                ),
                newValue: (String? newValue) {
                  print(newValue);
                  _gender = newValue!;
                },
                initialDropdownValue:
                    profileController.myProfileModel.value.body!.user!.gender ??
                        '',
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
                style: SolhTextStyles.QS_caption_bold,
              ),
              DOBPicker(
                initialDateOfBirth: DateTime.parse(
                    profileController.myProfileModel.value.body!.user!.dob ??
                        DateTime.now().toString()),
                onChanged: (date) {
                  print(date);
                  _dob = date;
                },
                onDateChanged: (date) {
                  print(date);
                  _ageController.DOB.value =
                      DateFormat('yyyy-MM-dd').format(date);
                  _ageController
                      .onChanged(DateFormat('dd MMMM yyyy').format(date));
                },
                boxDecoration: BoxDecoration(
                  color: SolhColors.light_Bg,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
              ),
              SizedBox(
                height: 2.25.h,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select country',
                  style: SolhTextStyles.QS_caption_bold,
                ),
                // Text(
                //   'Choose the default country from which you want to \nget consultation.',
                //   style: SolhTextStyles.JournalingPostMenuText,
                // ),
                SizedBox(
                  height: 1.h,
                ),
                CountryCodePicker(
                  favorite: ['IN', 'US', 'AU'],
                  comparator: (a, b) => b.name!.compareTo(a.name!),
                  builder: (CountryCode? countryCode) {
                    return Container(
                      height: MediaQuery.of(context).size.height / 15,
                      decoration: BoxDecoration(
                          color: SolhColors.light_Bg,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.height / 60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${country}',
                            style: TextStyle(color: SolhColors.primary_green),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: SolhColors.primary_green,
                          )
                        ],
                      ),
                    );
                  },
                  // showDropDownButton: true,
                  // showFlagDialog: true,
                  showFlagMain: false,
                  dialogSize: Size(double.infinity, 600),

                  onChanged: (value) async {
                    print(value.code);
                    country = value.name;
                    SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    await sharedPreferences.setString(
                        'userCountry', value.code ?? '');
                    country = value.name;
                  },
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: "IN",
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,

                  showCountryOnly: true,
                  // optional. aligns the flag and the Text left
                  alignLeft: true,
                ),
                SizedBox(
                  height: 2.25.h,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
            child: SolhGreenButton(
              onPressed: () async {
                print(_lastNameTextEditingController.text);
                print(_firstNameTextEditingController.text);
                print(_bioTextEditingController.text);
                if (_croppedFile != null) uploadImage();
                print(_dob);

                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                String? coutry = sharedPreferences.getString('userCountry');
                print(jsonEncode({
                  "first_name": _firstNameTextEditingController.text,
                  "last_name": _lastNameTextEditingController.text,
                  "gender": _gender,
                  "bio": _bioTextEditingController.text,
                  "dob": _ageController.DOB.value,
                  "isProvider": _ageController.isProvider.value,
                  "userCountry": coutry,
                  'username': _userNameController
                      .text ////// ==> To be implemented for username
                }));
                var response = await http
                    .put(Uri.parse("${APIConstants.api}/api/edit-user-details"),
                        body: jsonEncode({
                          "first_name": _firstNameTextEditingController.text,
                          "last_name": _lastNameTextEditingController.text,
                          "gender": _gender,
                          "bio": _bioTextEditingController.text,
                          "dob": _ageController.DOB.value,
                          "isProvider": _ageController.isProvider.value,
                          "userCountry": coutry,
                          'username': _userNameController
                              .text ////// ==> To be implemented for username
                        }),
                        headers: {
                      "Content-Type": "application/json",
                      "Authorization":
                          "Bearer ${userBlocNetwork.getSessionCookie}"
                    }).then((value) {
                  print(value.body);
                }).onError((error, stackTrace) {
                  print(error);
                  print(stackTrace);
                });
                if (response != null) {
                  Utility.showToast('Profile is edited');
                }

                await profileController.getMyProfile();
                Get.find<GetHelpController>().getTopConsultant();

                Navigator.pop(context);
              },
              child: Text("Save Changes"),
              height: 6.5.h,
            ),
          ),
        ],
      )),
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
      _croppedFile = File(croppedFile!.path);
    }
    // Navigator.of(context).pop();
    setState(() {});
  }

  Future<void> uploadImage() async {
    profileController.isEditProfilePicUploading(true);
    var response = await Network.uploadFileToServer(
        "${APIConstants.api}/api/fileupload/user-profile-picture",
        "profile",
        _croppedFile!);
    profileController.isEditProfilePicUploading(false);
    if (response["success"]) {
      Utility.showToast('Profile picture updated');
      //userBlocNetwork.getMyProfileSnapshot();
      await profileController.getMyProfile();
    }
  }

  Future<void> getUserCountry() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    country = sharedPreferences.getString('userCountry');
    Future.delayed(Duration(seconds: 2), () {
      setState(() {});
    });
  }

  void fillUserDetails() {
    _dob = '';
    _gender = profileController.myProfileModel.value.body!.user!.gender ?? '';
    _firstNameTextEditingController.text =
        profileController.myProfileModel.value.body!.user!.firstName ?? '';
    _lastNameTextEditingController.text =
        profileController.myProfileModel.value.body!.user!.lastName ?? '';
    _bioTextEditingController.text =
        profileController.myProfileModel.value.body!.user!.bio ?? '';

    _ageController.selectedAge.value = profileController
                .myProfileModel.value.body!.user!.dob !=
            null
        ? DateFormat('dd MMM yyyy')
            .format(DateTime.parse(
                profileController.myProfileModel.value.body!.user!.dob ?? ''))
            .toString()
        : '';
    _userNameController.text =
        profileController.myProfileModel.value.body!.user!.userName ?? '';
    print(_firstNameTextEditingController.text);
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
            style: SolhTextStyles.QS_caption_bold,
          ),
          Container(
            child: TextField(
              controller: _textEditingController,
              decoration: TextFieldStyles.greenF_noBorderUF_4R(),
              maxLines: _maxLine,
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}
