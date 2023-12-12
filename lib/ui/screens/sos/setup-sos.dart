// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/ui/screens/sos/sos_controller/sos_controller.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

// ignore: must_be_immutable
class SetupSOSScreen extends StatelessWidget {
  SetupSOSScreen({super.key});

  final _controller = Get.put(SosController());

  TextEditingController messageTextEditingController =
      TextEditingController(text: 'Help me, I have an emergency');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Setup SOS"),
          centerTitle: false,
          backgroundColor: ThemeData().scaffoldBackgroundColor,
          foregroundColor: Colors.black,
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(7.w),
                    child: const Text(
                      "Details of the persons who will be notified immediately with just one click",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  // Text(
                  //   "Person 1",
                  //   style: TextStyle(color: SolhColors.green),
                  // ),
                  // SizedBox(height: 0.5.h),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //       hintText: "Name of the person",
                  //       border: OutlineInputBorder()),
                  // ),
                  // SizedBox(height: 2.h),
                  // TextFormField(
                  //   decoration: InputDecoration(
                  //       hintText: "Phone Number", border: OutlineInputBorder()),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 2.h),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       InkWell(
                  //         child: Text(
                  //           "Add Another + ",
                  //           style: TextStyle(color: SolhColors.green),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return const ModalBottomSheetContent();
                          });
                    },
                    child: Container(
                      height: 48,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFA6A6A6)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Select Persons',
                              style: GoogleFonts.signika(
                                  color: const Color(0xffA6A6A6)),
                            ),
                            Row(
                              children: [
                                Obx(() {
                                  return Text(
                                      _controller.selectedItems.length
                                          .toString(),
                                      style: GoogleFonts.signika(
                                          color: SolhColors.primary_green));
                                }),
                                Text(' ,Selected',
                                    style: GoogleFonts.signika(
                                        color: SolhColors.primary_green)),
                                const Icon(Icons.keyboard_arrow_down_sharp,
                                    color: SolhColors.primary_green)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  TextFormField(
                    controller: messageTextEditingController,
                    maxLines: 4,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 4.h),
                  InkWell(
                    onTap: () async {
                      var validatorResponse =
                          validator(messageTextEditingController.text);
                      if (validatorResponse == true) {
                        List personList =
                            _controller.selectedItems.keys.map((e) {
                          return e;
                        }).toList();
                        Map<String, dynamic> body = {
                          "emergencyContacts": personList,
                          "message": messageTextEditingController.text
                        };

                        var response = await _controller.addSosContacts(body);
                        Map decodedResponse = json.decode(response);

                        if (decodedResponse['success'] == true) {
                          final snackBar = SnackBar(
                            content: Text(decodedResponse['message']),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      } else {
                        final snackBar = SnackBar(
                          content: Text(validatorResponse),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: SolhGreenButton(
                      height: 6.h,
                      child: const Text("Save Details"),
                    ),
                  ),
                ],
              ),
            )));
  }
}

class ModalBottomSheetContent extends StatefulWidget {
  const ModalBottomSheetContent({super.key});

  @override
  State<ModalBottomSheetContent> createState() =>
      _ModalBottomSheetContentState();
}

class _ModalBottomSheetContentState extends State<ModalBottomSheetContent> {
  final ConnectionController _connectionController = Get.find();

  final SosController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select People',
                      style: GoogleFonts.signika(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 1,
              )
            ],
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        _connectionController.myConnectionModel.value.myConnections!.length == 0
            ? Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.grey.shade300,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Oops! No connection found.',
                      style: GoogleFonts.signika(
                          fontSize: 20, color: Colors.green.shade300),
                    )
                  ],
                ),
              )
            : Expanded(
                child: ListView.builder(
                    itemCount: _connectionController
                        .myConnectionModel.value.myConnections!.length,
                    itemBuilder: (context, index) {
                      if (_connectionController
                              .myConnectionModel.value.myConnections!.length >
                          _controller.selectedTags.length) {
                        _controller.selectedTags.add(false);
                      }
                      return InkWell(
                        onTap: () {
                          if (_controller.selectedTags[index] == true) {
                            print('ran if 1');
                            _controller.selectedTags[index] = false;
                          } else {
                            print('ran if 2');
                            _controller.selectedTags[index] = true;
                          }
                          // if (_tagsController.selectedTags[index]) {
                          //   print('ran if 2');
                          //   _tagsController.selectedTags[index] = true;
                          // }
                          print(_controller.selectedTags.toString() +
                              index.toString());
                          if (_controller.selectedTags[index]) {
                            _controller.selectedItems[_connectionController
                                .myConnectionModel
                                .value
                                .myConnections![index]
                                .sId!] = true;
                            _controller.update();
                          }
                          if (_controller.selectedTags[index] == false) {
                            _controller.selectedItems.remove(
                                _connectionController.myConnectionModel.value
                                    .myConnections![index].sId!);
                            _controller.update();
                          }
                          print(_controller.selectedTags.length);
                          print(_controller.selectedItems.toString());
                          setState(() {});
                        },
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                      _connectionController
                                          .myConnectionModel
                                          .value
                                          .myConnections![index]
                                          .profilePicture!),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 30, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _connectionController
                                              .myConnectionModel
                                              .value
                                              .myConnections![index]
                                              .name!,
                                          style: GoogleFonts.signika(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          _connectionController
                                              .myConnectionModel
                                              .value
                                              .myConnections![index]
                                              .bio!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Checkbox(
                                  checkColor: Colors.white,
                                  side: MaterialStateBorderSide.resolveWith(
                                    (states) => const BorderSide(
                                        width: 1.0, color: Colors.white),
                                  ),
                                  activeColor: SolhColors.primary_green,
                                  value: _controller.selectedTags[index],
                                  shape: const CircleBorder(),
                                  onChanged: (bool? value) {
                                    if (_controller.selectedTags[index] ==
                                        true) {
                                      print('ran if 1');
                                      _controller.selectedTags[index] = false;
                                    } else {
                                      print('ran if 2');
                                      _controller.selectedTags[index] = true;
                                    }
                                    // if (_tagsController.selectedTags[index]) {
                                    //   print('ran if 2');
                                    //   _tagsController.selectedTags[index] = true;
                                    // }
                                    print(_controller.selectedTags.toString() +
                                        index.toString());
                                    if (_controller.selectedTags[index]) {
                                      _controller.selectedItems[
                                          _connectionController
                                              .myConnectionModel
                                              .value
                                              .myConnections![index]
                                              .userName!] = true;
                                      _controller.update();
                                    }
                                    if (_controller.selectedTags[index] ==
                                        false) {
                                      _controller.selectedItems.remove(
                                          _connectionController
                                              .myConnectionModel
                                              .value
                                              .myConnections![index]
                                              .userName!);
                                      _controller.update();
                                    }
                                    print(_controller.selectedTags.length);
                                    print(_controller.selectedItems.toString());
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
      ],
    );
  }
}

validator(String helpText) {
  SosController _controller = Get.find();

  if (_controller.selectedItems.length == 0) {
    return 'you need to select a connection';
  }
  if (helpText.isEmpty) {
    return 'you need to enter a help message';
  } else {
    return true;
  }
}
