import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/model/user/user.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/services/user/user-profile.dart';
import 'package:solh/ui/screens/profile-setup/gender-age.dart';
import 'package:solh/ui/screens/widgets/dropdowns/gender-selection.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class EditMyProfileScreen extends StatefulWidget {
  const EditMyProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditMyProfileScreen> createState() => _EditMyProfileScreenState();
}

class _EditMyProfileScreenState extends State<EditMyProfileScreen> {
  TextEditingController _firstNameTextEditingController =
      TextEditingController();
  TextEditingController _lastNameTextEditingController =
      TextEditingController();
  TextEditingController _bioTextEditingController = TextEditingController();
  TextEditingController _phoneTextEditingController = TextEditingController();
  TextEditingController _emailIdTextEditingController = TextEditingController();
  TextEditingController _genderTextEditingController = TextEditingController();
  TextEditingController _dobTextEditingController = TextEditingController();

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
      body: SingleChildScrollView(
        child: FutureBuilder<UserModel?>(
            future: UserProfile.fetchUserProfile(
                FirebaseAuth.instance.currentUser!.uid),
            builder: (context, userSnapshot) {
              if (userSnapshot.hasData) {
                _dob = userSnapshot.requireData!.dob;
                print(userSnapshot.requireData!.gender);
                _gender = userSnapshot.requireData!.gender;
                print(userSnapshot.requireData!.firstName);
                _firstNameTextEditingController.text =
                    userSnapshot.requireData!.firstName;
                _lastNameTextEditingController.text =
                    userSnapshot.requireData!.lastName;
                _bioTextEditingController.text = userSnapshot.requireData!.bio;
                _phoneTextEditingController.text =
                    userSnapshot.requireData!.mobile;
                _genderTextEditingController.text =
                    userSnapshot.requireData!.gender;
                _dobTextEditingController.text = userSnapshot.requireData!.dob;
                print(_firstNameTextEditingController.text);
                return Column(
                  children: [
                    Container(
                      height: 2.5.h,
                    ),
                    Container(
                      child: CircleAvatar(
                        radius: 14.w,
                        backgroundImage: CachedNetworkImageProvider(
                            userSnapshot.data!.profilePictureUrl),
                      ),
                    ),
                    Container(
                      child: Text(""),
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
                              userSnapshot.requireData!.gender,
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
                          initialDateOfBirth: DateTime.f,
                          onChanged: (date) {
                            print(date);
                            _dob = date;
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                      child: SolhGreenButton(
                        onPressed: () async {
                          await Network.makeHttpPutRequestWithToken(
                              url: "${APIConstants.api}/api/edit-user-details",
                              body: {
                                "first_name":
                                    _firstNameTextEditingController.text,
                                "last_name":
                                    _lastNameTextEditingController.text,
                                "gender": _gender,
                                "bio": _bioTextEditingController.text,
                                "dob": _dob
                              });
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
    );
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
