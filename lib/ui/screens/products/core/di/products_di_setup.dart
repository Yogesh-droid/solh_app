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

  /// ProductDetails
  ///
  Get.put<ProductDetailRepo>(ProductDetailRepoImpl());
  Get.put(
      ProductDetailUsecase(productDetailRepo: Get.find<ProductDetailRepo>()));
  Get.put(ProductDetailController(
      productDetailUsecase: Get.find<ProductDetailUsecase>()));

  /// Product List Filter setup
  Get.put<FilterRepo>(FilterRepoImpl());
  Get.put(FilterUsecase(filterRepo: Get.find<FilterRepo>()));
  Get.put(FilterController(filterUsecase: Get.find<FilterUsecase>()));
}
