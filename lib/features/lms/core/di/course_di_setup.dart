part of 'course_di_imports.dart';

void courseControllerSetup() {
  // Course Home Banner

  Get.put<CourseBannerRepo>(CourseBannerRepoImpl());
  Get.put(CourseBannerUsecase(courseBannerRepo: Get.find<CourseBannerRepo>()));
  Get.put(CourseBannerController(
      courseBannerUsecase: Get.find<CourseBannerUsecase>()));

  // Course category
  Get.put<CourseCatRepo>(CourseCatRepoImpl());
  Get.put(CourseCatUsecase(courseCatRepo: Get.find<CourseCatRepo>()));
  Get.put(CourseCatController(courseCatUsecase: Get.find<CourseCatUsecase>()));

  // Featured Course

  Get.put<FeaturedCourseRepo>(FeaturedCourseRepoImpl());
  Get.put(FeaturedCourseUsecase(
      featuredCourseRepo: Get.find<FeaturedCourseRepo>()));
  Get.put(FeaturedCourseController(
      featuredCourseUsecase: Get.find<FeaturedCourseUsecase>()));

  // Course List
  Get.put<CourseListRepo>(CourseListRepoImpl());
  Get.put(CourseListUsecase(courseListRepo: Get.find<CourseListRepo>()));
  Get.put(
      CourseListController(courseListUsecase: Get.find<CourseListUsecase>()));

  // Course Details
  Get.put<CourseDetailRepo>(CourseDetailRepoImpl());
  Get.put(CourseDetailUsecase(courseDetailRepo: Get.find<CourseDetailRepo>()));
  Get.put(CourseDetailController(
      courseDetailUsecase: Get.find<CourseDetailUsecase>()));
  // Course wishlist

  Get.put<CourseWishlistRepo>(CourseWishlistRepoImpl());
  Get.put(CourseWishlistUseCase(
      courseWishlistRepo: Get.find<CourseWishlistRepo>()));
  Get.put(CourseWishlistController(
      courseWishlistUseCase: Get.find<CourseWishlistUseCase>()));
}
