import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SolhSearchField extends StatelessWidget {
  const SolhSearchField(
      {Key? key,
      required this.hintText,
      required this.icon,
      required this.onTap})
      : super(key: key);
  final String hintText;
  final String icon;
  final Callback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
          border: Border.all(
            color: SolhColors.green,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  hintText,
                  style: TextStyle(
                    color: SolhColors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              SvgPicture.asset(icon)
            ],
          ),
        ),
      ),
    );
  }
}
