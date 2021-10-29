import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Stories extends StatelessWidget {
  const Stories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 10.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: 7,
        scrollDirection: Axis.horizontal,
        itemBuilder: (index, context) => StoriesAvatar(),
      ),
    );
  }
}

class StoriesAvatar extends StatelessWidget {
  const StoriesAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: CircleAvatar(
        radius: 7.w,
        backgroundImage: NetworkImage(
          'https://momentousinstitute.org/assets/site/blog/Mental-Health-For-Adults.jpg',
        ),
      ),
    );
  }
}
