import 'dart:convert';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/controllers/getHelp/get_help_controller.dart';
import 'package:solh/controllers/profile/age_controller.dart';
import 'package:solh/model/user/user.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/user/user-profile.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/my-profile/profile/edit_anonymous_profile.dart';
import 'package:solh/ui/screens/my-profile/profile/edit_profile_controller.dart';
import 'package:solh/ui/screens/profile-setup/gender-age.dart';
import 'package:solh/ui/screens/widgets/dropdowns/gender-selection.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:http/http.dart' as http;
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
  TextEditingController _phoneTextEditingController = TextEditingController();
  TextEditingController _genderTextEditingController = TextEditingController();
  TextEditingController _dobTextEditingController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  final AgeController _ageController = Get.find();
  final AnonController _anonController = Get.find();
  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  bool _isLoading = false;
  String? _gender = "Other";
  String? _dob = "";

  @override
  void initState() {
    getUserCountry();
    super.initState();
  }

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
                    _gender = userSnapshot.requireData!.gender;
                    _firstNameTextEditingController.text =
                        userSnapshot.requireData!.firstName!;
                    _lastNameTextEditingController.text =
                        userSnapshot.requireData!.lastName ?? "";
                    _bioTextEditingController.text =
                        userSnapshot.requireData!.bio ?? '';
                    _phoneTextEditingController.text =
                        userSnapshot.requireData!.mobile ?? '';
                    _genderTextEditingController.text =
                        userSnapshot.requireData!.gender ?? '';
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
                    _userNameController.text =
                        userSnapshot.requireData!.userName ?? '';
                    print(_firstNameTextEditingController.text);
                    return Column(
                      children: [
                        Container(
                          height: 2.5.h,
                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SolhGreenBorderMiniButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.edit_outlined,
                                        color: SolhColors.green),
                                    Text(
                                      "Anonymous",
                                      style:
                                          SolhTextStyles.GreenBorderButtonText,
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditAnonymousProfile()),
                                  );
                                },
                              ),
                            )),
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
                                          backgroundImage:
                                              FileImage(_croppedFile!),
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
                                          radius: 14.w,
                                          backgroundImage: editProfileController
                                                  .isProfilePictureUploading
                                                  .value
                                              ? CachedNetworkImageProvider(
                                                  'https://banner2.cleanpng.com/20180628/xvr/kisspng-apple-id-computer-icons-macos-axle-load-5b354557d17970.908537281530217815858.jpg')
                                              : CachedNetworkImageProvider(
                                                  userSnapshot
                                                      .data!.profilePicture!),
                                        ),
                                      ),
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
                          height: 1.5.h,
                        ),
                        // TextFieldB(
                        //   label: "Username",
                        //   textEditingController: _userNameController,
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 18.0),
                            //   child: Text(
                            //     "Username",
                            //     style: SolhTextStyles.JournalingHintText,
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //     horizontal: 18.0,
                            //   ),
                            //   child: ProfielTextField(
                            //     hintText: "Username",
                            //     autovalidateMode:
                            //         AutovalidateMode.onUserInteraction,
                            //     textEditingController: _userNameController,
                            //     validator: (value) {
                            //       if (value!.isEmpty) {
                            //         _anonController.isNormalNameTaken.value =
                            //             false;
                            //       }
                            //       return value == ''
                            //           ? "Required*"
                            //           : value.length < 3
                            //               ? "Username must be at least 3 characters long"
                            //               : null;
                            //     },
                            //     onChanged: (val) {
                            //       _anonController.isNormalNameTaken.value =
                            //           false;
                            //       if (val!.length >= 3 &&
                            //           _userNameController.text !=
                            //               userSnapshot.requireData!.userName) {
                            //         _anonController
                            //             .checkIfNormalUserNameTaken(val);
                            //       }
                            //     },
                            //   ),
                            // ),
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
                                _ageController.DOB.value =
                                    DateFormat('yyyy-MM-dd').format(date);
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
                            SizedBox(
                              height: 2.25.h,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Select country',
                                style: SolhTextStyles.JournalingUsernameText,
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
                                comparator: (a, b) =>
                                    b.name!.compareTo(a.name!),
                                builder: (CountryCode? countryCode) {
                                  return Container(
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: SolhColors.black166),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.height /
                                                60),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${country}',
                                          style: TextStyle(
                                              color: SolhColors.green),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color: SolhColors.green,
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 4.h),
                          child: SolhGreenButton(
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              if (_croppedFile != null) uploadImage();
                              // await Network.makeHttpPutRequestWithToken(
                              //     url:
                              //         "${APIConstants.api}/api/edit-user-details",
                              //     body: {
                              //       "first_name":
                              //           _firstNameTextEditingController.text,
                              //       "last_name":
                              //           _lastNameTextEditingController.text,
                              //       "gender": _gender,
                              //       "bio": _bioTextEditingController.text,
                              //       "dob": _ageController.selectedAge.value,
                              //       "isProvider": _ageController.isProvider.value
                              //     });
                              print(_dob);
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              String? coutry =
                                  sharedPreferences.getString('userCountry');
                              var response = await http.put(
                                  Uri.parse(
                                      "${APIConstants.api}/api/edit-user-details"),
                                  body: jsonEncode({
                                    "first_name":
                                        _firstNameTextEditingController.text,
                                    "last_name":
                                        _lastNameTextEditingController.text,
                                    "gender": _gender,
                                    "bio": _bioTextEditingController.text,
                                    "dob": _ageController.DOB.value,
                                    "isProvider":
                                        _ageController.isProvider.value,
                                    "userCountry": coutry
                                    //'username': _userNameController.text   ////// ==> To be implemented for username
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
                                print(response.statusCode);
                                print(response.body);
                                print(response.headers);
                                print(response.request);
                                print(response.reasonPhrase);
                              }

                              await userBlocNetwork.getMyProfileSnapshot();
                              Get.find<GetHelpController>().getTopConsultant();
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
                activeControlsWidgetColor: SolhColors.green,
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
    editProfileController.isProfilePictureUploading(true);
    var response = await Network.uploadFileToServer(
        "${APIConstants.api}/api/fileupload/user-profile-picture",
        "profile",
        _croppedFile!);
    editProfileController.isProfilePictureUploading(false);
    if (response["success"]) {
      Utility.showToast('Profile picture updated');
      userBlocNetwork.getMyProfileSnapshot();
    }
  }

  Future<void> getSharedPtreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // country = sharedPreferences.getString('userCountry');
  }

  Future<void> getUserCountry() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    country = sharedPreferences.getString('userCountry');
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
