import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/group/discover_group_controller.dart';
import 'package:solh/ui/screens/journaling/create-journal.dart';
import '../../../constants/api.dart';
import '../../../controllers/group/create_group_controller.dart';
import '../../../model/group/get_group_response_model.dart';
import '../../../routes/routes.dart';
import '../../../services/network/network.dart';
import '../../../widgets_constants/appbars/app-bar.dart';
import '../../../widgets_constants/buttons/custom_buttons.dart';
import '../../../widgets_constants/constants/colors.dart';
import '../../../widgets_constants/constants/textstyles.dart';
import '../profile-setup/add-profile-photo.dart';
import '../profile-setup/enter-full-name.dart';
import 'invite_member_ui.dart';

class CreateGroup extends StatefulWidget {
  final GroupList? group;
  const CreateGroup({
    Key? key,
    this.group,
  }) : super(key: key);
  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
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
  void initState() {
    print('initState');
    if (widget.group != null) {
      print('initState && widget.group != null');
      _controller.tagList.clear();
      _nameEditingController.text = widget.group!.groupName ?? '';
      _descriptionEditingController.text = widget.group!.groupDescription ?? '';
      _groupMediaUrl = widget.group!.groupMediaUrl;
      widget.group!.groupTags!.forEach((element) {
        print(element);
        _controller.tagList.add(element);
      });
      _controller.tagList.refresh();
    }
    _croppedFile = null;
    _controller.path.value = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              widget.group != null && _controller.path.value.isEmpty
                  ? getEditGroupImage()
                  : getGroupImg(),
              SizedBox(
                height: 10.h,
              ),
              getNameForm(),
              SizedBox(
                height: 2.h,
              ),
              getTagsField(),
              // SizedBox(
              //   height: 2.h,
              // ),
              //getPrivacyField(),
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
            widget.group != null ? "Edit Group Details" : "Create Group",
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
        setState(() {});
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
        hintText: "Add Description(Optional)",
        border: OutlineInputBorder(),
        hintStyle: TextStyle(color: Color(0xFFA6A6A6)),
      ),
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
                  hintStyle: TextStyle(color: Color(0xFFA6A6A6)),
                  border: InputBorder.none,
                ),
                controller: _tagEditingController,
                onFieldSubmitted: (value) {
                  _tagEditingController.text = '';
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
              style: TextStyle(
                color: Color(0xFFA6A6A6),
              ),
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
      child: Obx((() {
        return _controller.isLoading.value
            ? Container(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(SolhColors.white),
                  strokeWidth: 2,
                ),
              )
            : Text(widget.group != null ? "Save" : "Next");
      })),
      height: 6.h,
      width: MediaQuery.of(context).size.width / 1.1,
      onPressed: () async {
        if (_formKey.currentState!.validate() &&
            !_groupController.isLoading.value) {
          if (_croppedFile != null) {
            _controller.path.value = _croppedFile!.path;
          }
          Map<String, dynamic> map = await _controller.createGroup(
            groupName: _nameEditingController.text,
            desc: _descriptionEditingController.text,
            groupType: 'Public',
            img: _groupMediaUrl,
            imgType: _groupMediaType ?? 'image/png',
            groupId: widget.group != null ? widget.group!.sId : null,
          );
          if (map['success']) {
            _groupController.getJoinedGroups();
            _groupController.getCreatedGroups();
            _croppedFile = null;
            Navigator.pushNamed(context, AppRoutes.inviteGroupMemberPage,
                arguments: {
                  "groupId": widget.group != null
                      ? widget.group!.sId
                      : map['groupDetails']['_id'],
                });
          }
        }
      },
    );
  }

  Widget getEditGroupImage() {
    return Stack(
      children: [
        Container(
          width: 130,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 50,
            backgroundImage: _groupMediaUrl != null
                ? CachedNetworkImageProvider(
                    _groupMediaUrl ?? '',
                  )
                : AssetImage('assets/images/group_placeholder.png')
                    as ImageProvider,
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
    );
  }
}
