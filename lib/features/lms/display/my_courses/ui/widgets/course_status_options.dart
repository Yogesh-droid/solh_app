import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseStatusOptions extends StatelessWidget {
  const CourseStatusOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: const [
        SizedBox(
          width: 12,
        ),
        Chip(label: Text('All')),
        SizedBox(
          width: 12,
        ),
        Chip(label: Text('Ongoing')),
        SizedBox(
          width: 12,
        ),
        Chip(label: Text('Completed')),
        SizedBox(
          width: 12,
        ),
        Chip(label: Text('Favourite')),
      ],
    );
  }
}
