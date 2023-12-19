import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class CourseSearchBar extends StatelessWidget {
  const CourseSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: SolhColors.light_Bg, borderRadius: BorderRadius.circular(22)),
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Search for mental wellness courses'),
            Icon(
              Icons.search,
              color: SolhColors.primary_green,
            )
          ]),
    );
  }
}
