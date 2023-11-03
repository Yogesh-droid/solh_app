part of 'produts_di_imports.dart';

void productControllerSetup() {
  Get.put<ProductCategoryRepo>(ProductCategoryRepoImpl());
  Get.put(ProductsCategoryUsecase(
      productCategoryRepo: Get.find<ProductCategoryRepo>()));
  Get.put(ProductsCategoryController(
      productsCategoryUsecase: Get.find<ProductsCategoryUsecase>()));

  // Main category

  Get.put<ProductMainCatRepo>(ProductMainCatRepoImpl());
  Get.put(ProductMainCatUsecase(
      productMainCatRepo: Get.find<ProductMainCatRepo>()));
  Get.put(ProductMainCatController(
      productMainCatUsecase: Get.find<ProductMainCatUsecase>()));

  // productList

  Get.put<ProductListRepo>(ProductListRepoImpl());
  Get.put(ProductListUsecase(productListRepo: Get.find<ProductListRepo>()));
  Get.put(ProductsListController(
      productListUsecase: Get.find<ProductListUsecase>()));

  Get.put<ProductsCartController>(ProductsCartController());

  /// ProductDetails
  Get.put<ProductDetailRepo>(ProductDetailRepoImpl());
  Get.put(
      ProductDetailUsecase(productDetailRepo: Get.find<ProductDetailRepo>()));
  Get.put(ProductDetailController(
      productDetailUsecase: Get.find<ProductDetailUsecase>()));

  /// Feature products
  Get.put<FeatureProductsRepo>(FeatureProductsRepoImpl());
  Get.put(FeatureProductsUsecase(
      featureProductsRepo: Get.find<FeatureProductsRepo>()));
  Get.put(FeatureProductsController(
      featureProductsUsecase: Get.find<FeatureProductsUsecase>()));

  /// product home carousel
  Get.put<ProductHomeCarouselRepo>(ProductHomeCarouselRepoImpl());
  Get.put(ProductsHomeCarouselUsecase(
      productHomeCarouselRepo: Get.find<ProductHomeCarouselRepo>()));
  Get.put(ProductsHomeCarouselController(
      productsHomeCarouselUsecase: Get.find<ProductsHomeCarouselUsecase>()));

  /// Product List Filter setup
  Get.put<FilterRepo>(FilterRepoImpl());
  Get.put(FilterUsecase(filterRepo: Get.find<FilterRepo>()));
  Get.put(FilterController(filterUsecase: Get.find<FilterUsecase>()));

  // cart setup
  Get.put<CartRepo>(CartRepoImpl());
  Get.put<CartUsecase>(CartUsecase(cartRepo: Get.find<CartRepo>()));
  Get.put(CartController(cartUsecase: Get.find<CartUsecase>()));

  // add to cart
  Get.put<AddToCartRepo>(AddToCartRepoImpl());
  Get.put<AddToCartUsecase>(
      AddToCartUsecase(addToCartRepo: Get.find<AddToCartRepo>()));
  Get.put<AddToCartController>(
      AddToCartController(addToCartUsecase: Get.find<AddToCartUsecase>()));

  // add review

  Get.put<AddReviewRepo>(AddReviewRepoImpl());
  Get.put(AddReviewUsecase(addReviewRepo: Get.find<AddReviewRepo>()));
  Get.put(AddReviewController(addReviewUsecase: Get.find<AddReviewUsecase>()));

  // get reviews

  Get.put<GetReviewsRepo>(GetReviewsRepoImpl());
  Get.put(GetReviewsUsecase(getReviewsRepo: Get.find<GetReviewsRepo>()));
  Get.put(
      GetReviewsController(getReviewsUsecase: Get.find<GetReviewsUsecase>()));
}
