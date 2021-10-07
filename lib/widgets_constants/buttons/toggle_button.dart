import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

// ignore: must_be_immutable
class SolhToggleButton extends StatefulWidget {
  SolhToggleButton({
    this.activeColor,
    this.thumbColor,
    this.trackColor,
    required this.switchValue,
  });

  final Color? activeColor;
  Color? thumbColor;
  final Color? trackColor;
  bool switchValue; 

  @override
  _SolhToggleButtonState createState() => _SolhToggleButtonState();
}

class _SolhToggleButtonState extends State<SolhToggleButton> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      activeColor: widget.activeColor ?? SolhColors.grey217, //SolhColors.green,
      trackColor: widget.trackColor ?? SolhColors.grey217,
      thumbColor: widget.thumbColor ?? SolhColors.grey,
      value: widget.switchValue,
      onChanged: (value) {
        setState(() {
          widget.switchValue = value;
          if(value == true)
          {
          widget.thumbColor = SolhColors.green;
          }
          else if(value == false)
          {
            widget.thumbColor = SolhColors.grey;
          }
        });
      },
    );
  }
}