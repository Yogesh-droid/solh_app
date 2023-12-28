import 'package:flutter/material.dart';
import 'package:solh/features/lms/display/course_cart/ui/screens/course_cart_widget.dart';
import 'package:solh/ui/screens/products/features/cart/ui/views/screen/checkout_screen.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ProductCourseCartParentTab extends StatelessWidget {
  const ProductCourseCartParentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: SolhColors.white,
          title: const Text(
            'Your Cart',
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
                    ),
                  ])),
        ),
        body:
            const TabBarView(children: [CourseCartWidget(), CheckoutScreen()]),
      ),
    );
  }
}
