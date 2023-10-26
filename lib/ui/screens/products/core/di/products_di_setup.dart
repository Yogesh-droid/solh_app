part of 'produts_di_imports.dart';

void productControllerSetup() {
  Get.put<ProductCategoryRepo>(ProductCategoryRepoImpl());
  Get.put(ProductsCategoryUsecase(
      productCategoryRepo: Get.find<ProductCategoryRepo>()));
  Get.put(ProductsCategoryController(
      productsCategoryUsecase: Get.find<ProductsCategoryUsecase>()));
}
