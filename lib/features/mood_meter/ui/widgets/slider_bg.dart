import 'package:flutter/material.dart';

class SliderBg extends StatelessWidget {
  const SliderBg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFF71C25),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
          ),
        ),
        Expanded(
          child: Container(
            color: Color(0xFFE96A00),
          ),
        ),
        Expanded(
          child: Container(
            color: Color(0xFFF7B912),
          ),
        ),
        Expanded(
          child: Container(
            color: Color(0xFF71B644),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFF01A54D),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
          ),
        ),
      ]),
    );
  }
}
