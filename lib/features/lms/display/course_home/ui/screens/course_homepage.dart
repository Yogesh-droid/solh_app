import 'package:flutter/material.dart';
import 'package:solh/bottom-navigation/profile_icon.dart';
import 'package:solh/features/lms/display/course_home/ui/widgets/course_banner.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class CourseHomePage extends StatelessWidget {
  const CourseHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Column(
        children: [
          CourseBanner(images: [
            "https://picsum.photos/id/0/5000/3333",
            "https://picsum.photos/id/1/5000/3333",
            "https://picsum.photos/id/2/5000/3333"
          ])
        ],
      ),
    );
  }

  getAppBar() {
    return ProductsAppBar(
        isLandingScreen: true,
        title: const ProfileIcon(),
        popupMenu: PopupMenuButton(
            child: const Icon(Icons.more_vert, color: SolhColors.primary_green),
            itemBuilder: (_) =>
                [PopupMenuItem(child: const Text("My Orders"), onTap: () {})]));
  }
}
