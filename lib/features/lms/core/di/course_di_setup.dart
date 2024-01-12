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

  Get.put<AddRemoveCourseWishlistItemRepo>(
      AddRemoveCourseWishlistItemRepoImpl());
  Get.put(AddRemoveCourseWishlistItemUsecase(
      addRemoveCourseWishlistItemRepo:
          Get.find<AddRemoveCourseWishlistItemRepo>()));

  Get.put(AddRemoveCourseWishlistItemController(
      addRemoveCourseWishlistItemUsecase:
          Get.find<AddRemoveCourseWishlistItemUsecase>()));

  // Add COURSE TO CART
  Get.put<AddCourseToCartRepo>(AddCourseToCartRepoImpl());
  Get.put(AddCourseToCartUsecase(
      addCourseToCartRepo: Get.find<AddCourseToCartRepo>()));
  Get.put(AddCourseToCartController(
      addCourseToCartUsecase: Get.find<AddCourseToCartUsecase>()));

  // GET COURSE CART
  Get.put<GetCourseCartRepo>(GetCourseCartRepoImpl());
  Get.put(
      GetCourseCartUsecase(getCourseCartRepo: Get.find<GetCourseCartRepo>()));
  Get.put(GetCourseCartController(
      getCourseCartUsecase: Get.find<GetCourseCartUsecase>()));

  // Order Controller
  Get.put(MakeCourseOrderController());

  //My courses

  Get.put<MyCourseRepo>(MyCourseRepoImpl());
  Get.put(MyCourseUseCase(myCourseRepo: Get.find<MyCourseRepo>()));
  Get.put(MyCoursesController(myCourseUseCase: Get.find<MyCourseUseCase>()));

  // Country List
  Get.put<CountryListRepo>(CountryListRepoImpl());
  Get.put(CountryListUsecase(countryListRepo: Get.find<CountryListRepo>()));
  Get.put(CountryListController(
      countryListUsecase: Get.find<CountryListUsecase>()));

  // My Course details
  Get.put<MyCourseDetailRepo>(MyCourseDetailRepoImpl());
  Get.put(MyCourseDetailUsecase(
      myCourseDetailRepo: Get.find<MyCourseDetailRepo>()));
  Get.put(MyCourseDetailController(
      myCourseDetailUsecase: Get.find<MyCourseDetailUsecase>()));

  // Course Reviews setup
  Get.put<CourseReviewRepo>(CourseReviewsRepoImpl());
  Get.put(CourseReviewUsecase(courseReviewRepo: Get.find<CourseReviewRepo>()));
  Get.put(CourseReviewController(
      courseReviewUsecase: Get.find<CourseReviewUsecase>()));

  // Add Course Reviews setup
  Get.put<AddCourseReviewRepo>(AddCourseReviewRepoImpl());
  Get.put(AddCourseReviewUsecase(
      addCourseReviewRepo: Get.find<AddCourseReviewRepo>()));
  Get.put(AddCourseReviewController(
      addCourseReviewUsecase: Get.find<AddCourseReviewUsecase>()));

// Update lecture status setup
  Get.put<UpdateLectureTrackRepo>(UpdateLectureTrackRepoImpl());
  Get.put(UpdateLectureTrackUsecase(
      updateLectureTrackRepo: Get.find<UpdateLectureTrackRepo>()));
  Get.put(UpdateLectureTrackController(
      updateLectureTrackUsecase: Get.find<UpdateLectureTrackUsecase>()));

  // Get course Chat setup
  Get.put<CourseChatRepo>(CourseChatRepoImpl());
  Get.put(CourseChatUsecase(courseChatRepo: Get.find<CourseChatRepo>()));
  Get.put(GetCourseChatController(chatUsecase: Get.find<CourseChatUsecase>()));
}
