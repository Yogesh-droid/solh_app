import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class SolhGreenBtn48 extends StatelessWidget {
  SolhGreenBtn48({Key? key, required this.onPress, required this.text})
      : super(key: key);
  final Callback onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Color(0xFF5F9B8C),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16.0, right: 16, top: 15, bottom: 15),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
