import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/model/user/provider-user.dart';
import 'package:solh/ui/screens/profile-setup/add-profile-photo.dart';
import 'package:solh/ui/screens/profile-setup/email.dart';
import 'package:solh/ui/screens/profile-setup/enter-description.dart';
import 'package:solh/ui/screens/profile-setup/gender-age.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/text_field_styles.dart';
import 'enter-username.dart';
import 'user_type_screen.dart';

class EnterFullNameScreen extends StatefulWidget {
  EnterFullNameScreen({Key? key}) : super(key: key);

  @override
  State<EnterFullNameScreen> createState() => _EnterFullNameScreenState();
}

class _EnterFullNameScreenState extends State<EnterFullNameScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider(
        create: (_) => ProviderUser(),
        child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              UserTypeScreen(
                onNext: () => _pageController.nextPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease),
              ),
              EnterNamePage(
                onBack: () => _pageController.previousPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease),
                onNext: () => _pageController.nextPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease),
              ),
              EnterDescriptionPage(
                onBack: () => _pageController.previousPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease),
                onNext: () => _pageController.nextPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease),
              ),
              EmailScreen(
                onBack: () => _pageController.previousPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease),
                onNext: () => _pageController.nextPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease),
              ),
              EnterUsernameScreen(
                onBack: () => _pageController.previousPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease),
                onNext: () => _pageController.nextPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease),
              ),
              AddProfilePhotoPage(
                onBack: () => _pageController.previousPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease),
                onNext: () => _pageController.nextPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease),
              ),
              GenderAndAgePage(
                onBack: () => _pageController.previousPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease),
                onNext: () => _pageController.nextPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease),
              )
            ]),
      ),
    );
  }
}

class EnterNamePage extends StatelessWidget {
  EnterNamePage(
      {Key? key, required VoidCallback onNext, required VoidCallback onBack})
      : _onNext = onNext,
        _onBack = onBack,
        super(key: key);

  final VoidCallback _onNext;
  final VoidCallback _onBack;
  final TextEditingController _firstnameEditingController =
      TextEditingController();
  final TextEditingController _lastnameEditingController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onBack();
        return false;
      },
      child: Scaffold(
        appBar: ProfileSetupAppBar(
            title: "Enter your details",
            onBackButton: () {
              _onBack();
            }),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            children: [
              Text(
                "What do you want people to call you?",
                style: SolhTextStyles.ProfileSetupSubHeading,
              ),
              SizedBox(
                height: 3.5.h,
              ),
              Form(
                key: _formKey,
                child: ProfielTextField(
                  hintText: "Firstname",
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  textEditingController: _firstnameEditingController,
                  validator: (value) =>
                      value.toString().trim() == '' ? "Required*" : null,
                ),
              ),
              SizedBox(
                height: 3.5.h,
              ),
              ProfielTextField(
                hintText: "Lastname",
                textEditingController: _lastnameEditingController,
              ),
              SizedBox(
                height: 6.h,
              ),
              SolhGreenButton(
                  height: 6.h,
                  child: Text("Next"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<ProviderUser>(context, listen: false)
                          .setFirstName = _firstnameEditingController.text;
                      Provider.of<ProviderUser>(context, listen: false)
                          .setLasttName = _lastnameEditingController.text;

                      _onNext();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class ProfielTextField extends StatelessWidget {
  const ProfielTextField(
      {Key? key,
      String? hintText,
      AutovalidateMode? autovalidateMode,
      TextEditingController? textEditingController,
      String? Function(String?)? validator,
      Function(String?)? onChanged})
      : _hintText = hintText,
        _validator = validator,
        _autovalidateMode = autovalidateMode,
        _textEditingController = textEditingController,
        _onChanged = onChanged,
        super(key: key);

  final AutovalidateMode? _autovalidateMode;
  final String? _hintText;
  final String? Function(String?)? _validator;
  final Function(String?)? _onChanged;
  final TextEditingController? _textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      controller: _textEditingController,
      textAlignVertical: TextAlignVertical.center,
      validator: _validator,
      autovalidateMode: _autovalidateMode,
      onChanged: _onChanged,
      decoration: TextFieldStyles.greenF_noBorderUF_4R(
          hintText: 'Enter Anonymous name'),
    );
  }
}
