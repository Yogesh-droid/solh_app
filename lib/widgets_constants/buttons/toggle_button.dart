import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

// ignore: must_be_immutable
class SolhToggleButton extends StatefulWidget {
  SolhToggleButton({
    this.activeColor,
    this.inactiveThumbColor,
    this.activeTrackColor,
    this.inactiveTrackColor,
    required this.switchValue,
  });

  final Color? activeColor;
  final Color? inactiveThumbColor;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  bool switchValue; 

  @override
  _SolhToggleButtonState createState() => _SolhToggleButtonState();
}

class _SolhToggleButtonState extends State<SolhToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: widget.activeColor ?? SolhColors.green,
      activeTrackColor: widget.activeTrackColor ?? SolhColors.grey217,
      inactiveTrackColor: widget.inactiveTrackColor ?? SolhColors.grey217,
      inactiveThumbColor: widget.inactiveThumbColor ?? SolhColors.grey,
      value: widget.switchValue,
      onChanged: (value) {
        setState(() {
          widget.switchValue = value;
        });
      },
    );
  }
}