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

  //products cart

  Get.put<ProductsCartController>(ProductsCartController());
}
