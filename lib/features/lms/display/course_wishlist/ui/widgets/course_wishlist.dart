import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solh/features/lms/display/course_wishlist/ui/controllers/course_wishlist_controller.dart';
import 'package:solh/features/lms/display/course_wishlist/ui/widgets/course_wishlist_card.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class CourseWishlist extends StatefulWidget {
  CourseWishlist({super.key});

  @override
  State<CourseWishlist> createState() => _CourseWishlistState();
}

class _CourseWishlistState extends State<CourseWishlist> {
  final CourseWishlistController courseWishlistController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    courseWishlistController.getCourseWishList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return courseWishlistController.isLoading.value
          ? MyLoader()
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: 8,
              itemBuilder: (context, index) => CourseWishlistCard(
                imageUrl: '',
              ),
            );
    });
  }
}
