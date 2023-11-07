import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class AddRemoveItemFromCart extends StatelessWidget {
  AddRemoveItemFromCart({super.key});
  final ValueNotifier<int> productNumber = ValueNotifier(1);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
      decoration: BoxDecoration(
        color: SolhColors.grey_3,
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => productNumber.value > 1 ? productNumber.value-- : null,
            child: Icon(
              Icons.remove,
              size: 15,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          ValueListenableBuilder(
              valueListenable: productNumber,
              builder: (context, value, child) {
                return Text(
                  '$value',
                  style: SolhTextStyles.CTA,
                );
              }),
          SizedBox(
            width: 12,
          ),
          GestureDetector(
            onTap: () => productNumber.value++,
            child: Icon(
              Icons.add,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }
}
