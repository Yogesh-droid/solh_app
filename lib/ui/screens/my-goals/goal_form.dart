import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/goal-setting/goal_setting_controller.dart';
import 'package:solh/model/goal-setting/goal_sub_cat_model.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../constants/api.dart';
import '../../../services/network/network.dart';
import '../../../services/utility.dart';
import '../my-profile/profile/edit-profile.dart';

bool isCustomGoal = false;

class GoalForm extends StatefulWidget {
  GoalForm({Key? key}) : super(key: key);

  @override
  State<GoalForm> createState() => _GoalFormState();
}

class _GoalFormState extends State<GoalForm> {
  GoalSettingController _goalSettingController =
      Get.find<GoalSettingController>();
  XFile? _xFile;
  File? _croppedFile;
  String? _imageUrl;
  bool _isImageAdded = false;
  TextEditingController _goalNameController = TextEditingController();

  Map<String, dynamic> imgUploadResponse = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          'Custom Goal',
          style: GoogleFonts.signika(
            color: Colors.black,
          ),
        ),
        isLandingScreen: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 36,
              ),

              ///   Goal Image ///
              InkWell(
                onTap: () {
                  _pickImage(context);
                },
                child: _isImageAdded
                    ? Image.file(File(_xFile!.path),
                        height: 200, width: 200, fit: BoxFit.cover)
                    : Image.asset('assets/images/add_image.png',
                        height: 200, width: 200),
              ),
              TextFieldB(
                label: 'Goal Name',
                textEditingController: _goalNameController,
                maxLine: 1,
              ),
              getSubcatDropDown(),
              SizedBox(
                height: 20,
              ),
              getTaskDeclaration(),

              getTaskForm(),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AddTaskButton(),
                ],
              ),
              MaxReminder(),
              SizedBox(
                height: 40,
              ),
              SolhGreenButton(
                child: Text('Done'),
                height: 50,
                onPressed: () async {
                  if (_goalNameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please enter goal name'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 1),
                    ));
                    return;
                  }
                  if (_goalSettingController.selectedSubCat.value.name ==
                      null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please select sub category'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 1),
                    ));
                    return;
                  }
                  if (_goalSettingController
                      .task.value.first.keys.first.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please select task'),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 1),
                    ));
                    return;
                  }
                  await _goalSettingController.saveGoal(
                      goalType: 'custom',
                      goalName: _goalNameController.text,
                      imageUrl: _imageUrl);
                  Utility.showToast('Goal set successfully');
                  AutoRouter.of(context).popUntil(((route) => route.isFirst));
                },
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImage(BuildContext context) async {
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
                            // imageQuality: 100,
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
                                compressQuality:
                                    File(_xFile!.path).lengthSync() > 600000
                                        ? 20
                                        : 100,
                                uiSettings: [
                                  AndroidUiSettings(
                                      toolbarTitle: 'Edit',
                                      toolbarColor: SolhColors.white,
                                      toolbarWidgetColor: Colors.black,
                                      activeControlsWidgetColor:
                                          SolhColors.green,
                                      initAspectRatio:
                                          CropAspectRatioPreset.square,
                                      lockAspectRatio: true),
                                  IOSUiSettings(
                                    minimumAspectRatio: 1.0,
                                  )
                                ]);

                            _croppedFile = File(croppedFile!.path);

                            setState(() {
                              if (_croppedFile != null) _isImageAdded = true;
                            });
                            Navigator.pop(context);
                            imgUploadResponse =
                                await _uploadImage(isVideo: false);
                            _imageUrl = imgUploadResponse['imageUrl'];
                          }

                          // _xFileAsUnit8List = await _croppedFile!.readAsBytes();
                        },
                      ),
                      IconButton(
                          onPressed: () async {
                            _xFile = await _picker.pickImage(
                              source: ImageSource.camera,
                              maxWidth: 640,
                              maxHeight: 640,
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
                                      compressQuality:
                                          File(_xFile!.path).lengthSync() >
                                                  600000
                                              ? 20
                                              : 100,
                                      uiSettings: [
                                        AndroidUiSettings(
                                            toolbarTitle: 'Edit',
                                            toolbarColor: SolhColors.white,
                                            toolbarWidgetColor: Colors.black,
                                            activeControlsWidgetColor:
                                                SolhColors.green,
                                            initAspectRatio:
                                                CropAspectRatioPreset.square,
                                            lockAspectRatio: true),
                                        IOSUiSettings(
                                          minimumAspectRatio: 1.0,
                                        )
                                      ]);

                              _croppedFile = File(croppedFile!.path);

                              setState(() {
                                if (_croppedFile != null) _isImageAdded = true;
                              });
                              Navigator.pop(context);

                              imgUploadResponse =
                                  await _uploadImage(isVideo: false);
                            }
                            _imageUrl = imgUploadResponse['imageUrl'];
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

  Future<Map<String, dynamic>> _uploadImage({bool? isVideo}) async {
    return await Network.uploadFileToServer(
            "${APIConstants.api}/api/fileupload/journal-image",
            "file",
            _croppedFile!)
        .then((value) {
      return value;
    });
  }

  Widget getSubcatDropDown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Select Subcategory",
              style: SolhTextStyles.JournalingHintText,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: SolhColors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: SolhColors.grey,
                ),
              ),
              filled: true,
              fillColor: SolhColors.white,
            ),
            validator: (value) {
              if (value == null) {
                return "Please select a subcategory";
              }
              return null;
            },
            onChanged: (value) {
              Categories cat = value as Categories;
              _goalSettingController.selectedSubCat.value = cat;
            },
            // value: _goalSettingController.selectedSubCat.value.name,
            items: _goalSettingController.SubCatModel.value.categories!
                .map((value) {
              return DropdownMenuItem(
                value: value,
                child: Text(value.name ?? ''),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget getTaskDeclaration() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: SolhColors.green,
        ),
        child: Center(
          child: Text(
            "You can achieve the goal by using the recommended activities",
            style: SolhTextStyles.GreenButtonText,
          ),
        ));
  }

  Widget getTaskForm() {
    return Container(
      child: Obx(() => Column(
          children: _goalSettingController.task.value
              .map((e) => getTaskColumn(e))
              .toList())),
    );
  }

  Widget getTaskColumn(Map<dynamic, String> map) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DottedBorder(
        color: SolhColors.grey,
        dashPattern: [4, 4],
        child: Column(
          children: [
            _goalSettingController.task.value.length > 1
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                          onTap: (() {
                            _goalSettingController.task.value.remove(map);
                            _goalSettingController.task.refresh();
                          }),
                          child: Icon(Icons.close, color: SolhColors.grey)),
                    ))
                : Container(),
            TextFieldB(label: 'Tasks ', textEditingController: map.keys.first),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "occurrence",
                  style: SolhTextStyles.JournalingHintText,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: SolhColors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(
                        color: SolhColors.grey,
                      ),
                    ),
                    filled: true,
                    fillColor: SolhColors.white,
                  ),
                  validator: (value) {
                    if (value == null) {
                      return "Please select a subcategory";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // map.update(map.keys.first, (value) => value,
                    //     ifAbsent: () => value.toString());
                    _goalSettingController.task.value.elementAt(
                        _goalSettingController.task.value
                            .indexOf(map))[map.keys.first] = value.toString();
                  },
                  value: map.values.first,
                  items: [
                    DropdownMenuItem(
                      value: '1',
                      child: Text('Once'),
                    ),
                    DropdownMenuItem(
                      value: '365',
                      child: Text('Daily'),
                    ),
                  ]),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
/* 
class TaskForm extends StatelessWidget {
  TaskForm({Key? key}) : super(key: key);
  GoalSettingController goalSettingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: 160.0 * goalSettingController.noOfTasks.value,
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: goalSettingController.noOfTasks.value,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Tesk ${index + 1}',
                      style: GoogleFonts.signika(
                        color: Color(0xff666666),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffA6A6A6),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Quit smoking',
                            hintStyle: GoogleFonts.signika(
                              color: Color(
                                0xffA6A6A6,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Occurrence',
                      style: GoogleFonts.signika(
                        color: Color(0xff666666),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffA6A6A6),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Quit smoking',
                            hintStyle: GoogleFonts.signika(
                              color: Color(
                                0xffA6A6A6,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ));
  }
} */

class AddTaskButton extends StatelessWidget {
  AddTaskButton({Key? key}) : super(key: key);
  GoalSettingController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // _controller.noOfTasks.value++;
        _controller.addTask();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: SolhColors.green),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Add Task +',
            style: SolhTextStyles.GreenBorderButtonText,
          ),
        ),
      ),
    );
  }
}

/* class DoneButton extends StatelessWidget {
  const DoneButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Details())),
      child: Container(
        height: 48,
        width: 70.w,
        decoration: BoxDecoration(
            color: SolhColors.green,
            borderRadius: BorderRadius.circular(
              24,
            )),
        child: Center(
          child: Text(
            'Done',
            style: GoogleFonts.signika(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
} */

class MaxReminder extends StatelessWidget {
  const MaxReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Max Reminder',
            style: GoogleFonts.signika(
              color: Color(0xff666666),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          /* Container(
            height: 48,
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffA6A6A6),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Selected',
                  style: GoogleFonts.signika(
                    color: Color(
                      0xffA6A6A6,
                    ),
                  ),
                ),
              ),
            ),
          ), */

          DropdownButtonFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: SolhColors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: SolhColors.grey,
                ),
              ),
              filled: true,
              fillColor: SolhColors.white,
            ),
            validator: (value) {
              if (value == null) {
                return "Please select a reminder";
              }
              return null;
            },
            onChanged: (value) {},
            value: '1',
            items: [
              DropdownMenuItem(
                value: '1',
                child: Text('1'),
              ),
              DropdownMenuItem(
                value: '2',
                child: Text('2'),
              ),
              DropdownMenuItem(
                value: '3',
                child: Text('3'),
              ),
              DropdownMenuItem(
                value: '4',
                child: Text('4'),
              ),
              DropdownMenuItem(
                value: '5',
                child: Text('5'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
