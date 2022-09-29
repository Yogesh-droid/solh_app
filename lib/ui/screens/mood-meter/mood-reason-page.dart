import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/mood-meter/mood_meter_controller.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class MoodReasonPage extends StatefulWidget {
  MoodReasonPage({Key? key}) : super(key: key);

  @override
  State<MoodReasonPage> createState() => _MoodReasonPageState();
}

class _MoodReasonPageState extends State<MoodReasonPage> {
  FocusNode _focusNode = FocusNode();
  TextEditingController _reasonController = TextEditingController();
  MoodMeterController meterController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          SizedBox(
            height: 40,
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "Skip",
                style: TextStyle(
                  color: SolhColors.green,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Text(
            'Why are you feeling like this ?',
            style: SolhTextStyles.ProfileMenuGreyText,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            focusNode: _focusNode,
            controller: _reasonController,
            decoration: InputDecoration(
              labelText: "Tell us something ...",
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: SolhColors.green),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: SolhColors.green),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: SolhColors.green),
              ),
            ),
            maxLines: 4,
          ),
          SizedBox(
            height: 30,
          ),
          SolhGreenButton(
              height: 50,
              child: Text("Done"),
              onPressed: () async {
                try {
                  meterController.saveReason(_reasonController.text);
                } on Exception catch (e) {
                  // TODO
                }
                Navigator.pop(context);
              }),
        ]),
      ),
    );
  }
}
