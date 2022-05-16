import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/groups/invite_member_ui.dart';
import '../../../constants/api.dart';
import '../../../controllers/group/create_group_controller.dart';
import '../../../services/network/network.dart';
import '../../../widgets_constants/appbars/app-bar.dart';
import '../../../widgets_constants/buttons/custom_buttons.dart';
import '../../../widgets_constants/constants/colors.dart';
import '../../../widgets_constants/constants/textstyles.dart';
import '../profile-setup/add-profile-photo.dart';
import '../profile-setup/enter-full-name.dart';

class CreateGroup extends StatelessWidget {
  final CreateGroupController _controller = Get.find();
  final DiscoverGroupController _groupController = Get.find();
  XFile? _xFile;
  String? _groupMediaUrl;
  String? _groupMediaType;
  File? _croppedFile;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController =
      TextEditingController();
  final TextEditingController _tagEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              getGroupImg(),
              SizedBox(
                height: 10.h,
              ),
              getNameForm(),
              SizedBox(
                height: 2.h,
              ),
              getTagsField(),
              SizedBox(
                height: 2.h,
              ),
              getPrivacyField(),
              SizedBox(
                height: 2.h,
              ),
              getDescriptionTextField(),
              SizedBox(
                height: 9.h,
              ),
              getCreateGroupButton(context),
            ],
          ),
        ),
      ),
    );
  }

  /////// AppBar ///////

  SolhAppBar getAppBar(BuildContext context) {
    return SolhAppBar(
      title: Row(
        children: [
          SizedBox(
            width: 2.h,
          ),
          Text(
            "Create Group",
            style: SolhTextStyles.AppBarText,
          ),
        ],
      ),
      isLandingScreen: false,
    );
  }

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    print("picking image");
    _xFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    print(_xFile!.path.toString());
    if (_xFile != null) {
      final croppedFile = await ImageCropper()
          .cropImage(sourcePath: _xFile!.path, aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ], uiSettings: [
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
        _controller.path.value = croppedFile.path;
        _croppedFile = File(croppedFile.path);
        Map<String, dynamic> response = await _uploadImage();
        _groupMediaUrl = response["imageUrl"];
        _groupMediaType = response["mimetype"];
      }
    }
    // Navigator.of(context).pop();
  }

  Future<Map<String, dynamic>> _uploadImage() async {
    return await Network.uploadFileToServer(
        "${APIConstants.api}/api/fileupload/group",
        "groupMedia",
        _croppedFile!);
  }

  Widget getDescriptionTextField() {
    return TextField(
      controller: _descriptionEditingController,
      maxLines: 4,
      decoration: InputDecoration(
          hintText: "Add Description(Optional)", border: OutlineInputBorder()),
    );
  }

  Widget getNameForm() {
    return Form(
      key: _formKey,
      child: ProfielTextField(
        hintText: "Group Name",
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        textEditingController: _nameEditingController,
        validator: (value) => value == '' ? "Required*" : null,
      ),
    );
  }

  Widget getTagsField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: SolhColors.grey,
          width: 0.2.h,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                decoration: InputDecoration(
                  hintText: "Add Tags(Anxiety, Depression, etc.)",
                  border: InputBorder.none,
                ),
                controller: _tagEditingController,
                onFieldSubmitted: (value) {
                  _tagEditingController.clear();
                  _controller.tagList.value.add(value);
                  _controller.tagList.refresh();
                }),
            Obx(() {
              return Wrap(
                spacing: 2.h,
                children: _controller.tagList.value.map((tag) {
                  return Chip(
                    backgroundColor: SolhColors.green,
                    label: Text(tag, style: TextStyle(color: Colors.white)),
                    deleteIcon: Icon(Icons.close, color: SolhColors.white),
                    onDeleted: () {
                      _controller.tagList.value.remove(tag);
                      _controller.tagList.refresh();
                    },
                  );
                }).toList(),
              );
            })
          ],
        ),
      ),
    );
  }

  Widget getPrivacyField() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: SolhColors.grey,
          width: 0.2.h,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Public",
              style: SolhTextStyles.ProfileMenuGreyText,
            ),
            Icon(Icons.keyboard_arrow_down)
          ],
        ),
      ),
    );
  }

  Widget getGroupImg() {
    return Obx(() {
      return Center(
          child: _controller.path.value.isEmpty
              ? AddProfilePictureIllustration(
                  onPressed: _pickImage,
                )
              : Stack(
                  children: [
                    Container(
                      width: 130,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(
                          File(_controller.path.value),
                        ),
                      ),
                    ),
                    Positioned(
                      child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: SolhColors.green,
                          ),
                          onPressed: _pickImage),
                      top: 0,
                      right: 0,
                    )
                  ],
                ));
    });
  }

  Widget getCreateGroupButton(BuildContext context) {
    return SolhGreenButton(
      child: Text("Next"),
      height: 6.h,
      width: MediaQuery.of(context).size.width / 1.1,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          if (_croppedFile != null) {
            _controller.path.value = _croppedFile!.path;
          }
          Map<String, dynamic> map = await _controller.createGroup(
            groupName: _nameEditingController.text,
            desc: _descriptionEditingController.text,
            groupType: 'Public',
            img: _groupMediaUrl,
            imgType: _groupMediaType,
          );
          if (map['success']) {
            _groupController.getJoinedGroups();
            _groupController.getCreatedGroups();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InviteMembersUI(
                          groupId: map['groupDetails']['_id'],
                        )));
          }
        }
      },
    );
  }
}
