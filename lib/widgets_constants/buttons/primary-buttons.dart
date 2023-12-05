import 'package:flutter/material.dart';

class SolhGreenBtn48 extends StatelessWidget {
  const SolhGreenBtn48({super.key, required this.onPress, required this.text});
  final Function()? onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
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
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
