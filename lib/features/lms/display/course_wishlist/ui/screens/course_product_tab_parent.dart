import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:solh/features/lms/display/course_wishlist/ui/widgets/course_wishlist.dart';
import 'package:solh/ui/screens/products/features/wishlist/ui/view/screen/product_wishlist_screen.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class CourseProductTabParent extends StatelessWidget {
  const CourseProductTabParent({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: SolhColors.white,
            title: const Text(
              'Your wishlist',
              style: SolhTextStyles.QS_body_1_bold,
            ),
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: SolhColors.black,
                size: 24,
              ),
            ),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: TabBar(
                  labelColor: SolhColors.primary_green,
                  indicatorColor: SolhColors.primary_green,
                  tabs: [
                    Tab(
                      child: Text(
                        'Courses',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Products',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ]),
            ),
          ),
          body: TabBarView(
            children: [CourseWishlist(), ProductWishlistScreen()],
          )),
    );
  }
}
