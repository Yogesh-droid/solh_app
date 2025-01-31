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

  //wishlist
  Get.put<GetWishlistItemsRepo>(GetWishlistItemsRepoImpl());

  Get.put<ProductWishlistUsecase>(ProductWishlistUsecase(
      getWishlistItemsRepo: Get.find<GetWishlistItemsRepo>()));
  Get.put<ProductWishlistController>(ProductWishlistController(
      productWishlistUsecase: Get.find<ProductWishlistUsecase>()));

  //add remove item from wishlist
  Get.put<AddDeleteWishlistItemRepo>(AddDeleteWishlistItemRepoImpl());
  Get.put<AddDeleteWishlistItemUsecase>(AddDeleteWishlistItemUsecase(
      addDeleteWishlistItemRepo: Get.find<AddDeleteWishlistItemRepo>()));
  Get.put<AddDeleteWishlistItemController>(AddDeleteWishlistItemController(
      addDeleteWishlistItemUsecase: Get.find<AddDeleteWishlistItemUsecase>()));

  //Order summary

  Get.put<GetOrderListRepo>(GetOrderListRepoImpl());
  Get.put<OrderListUsecase>(
      OrderListUsecase(getOrderListRepo: Get.find<GetOrderListRepo>()));
  Get.put<OrderListController>(
      OrderListController(orderListUsecase: Get.find<OrderListUsecase>()));

  // Add Address
  Get.put<AddAddressRepo>(AddAddressRepoImpl());
  Get.put(AddAddressUsecase(addAddressRepo: Get.find<AddAddressRepo>()));
  Get.put(
      AddAddressController(addAddressUsecase: Get.find<AddAddressUsecase>()));

  // Edit Address
  Get.put<EditAddressRepo>(EditAddressRepoImpl());
  Get.put(EditAddressUsecase(editAddressRepo: Get.find<EditAddressRepo>()));
  Get.put(EditAddressController(
      editAddressUsecase: Get.find<EditAddressUsecase>()));

  // delete Address
  Get.put<DeleteAddressRepo>(DeleteAddressRepoImpl());
  Get.put(
      DeleteAddressUsecase(deleteAddressRepo: Get.find<DeleteAddressRepo>()));
  Get.put(DeleteAddressController(
      deleteAddressUsecase: Get.find<DeleteAddressUsecase>()));

  // Get Address
  Get.put<AddressRepo>(AddressRepoImpl());
  Get.put(AddressUsecase(addressRepo: Get.find<AddressRepo>()));
  Get.put(AddressController(addressUsecase: Get.find<AddressUsecase>()));

  // Get Order Details
  // Get Address
  Get.put<OrderDetailRepo>(OrderDetailRepoImpl());
  Get.put(OrderDetailUsecase(orderDetailRepo: Get.find<OrderDetailRepo>()));
  Get.put(OrderDetailController(
      orderDetailUsecase: Get.find<OrderDetailUsecase>()));

  // Get Product Sub cat
  Get.put<ProductSubCatRepo>(ProductSubCatRepoImpl());
  Get.put(
      ProductSubCatUsecase(productSubCatRepo: Get.find<ProductSubCatRepo>()));
  Get.put(ProductSubCatController(
      productSubCatUsecase: Get.find<ProductSubCatUsecase>()));

  // cancel reason controller
  Get.put<CancelReasonRepo>(CancelReasonRepoImpl());
  Get.put(CancelReasonUsecase(cancelReasonRepo: Get.find<CancelReasonRepo>()));
  Get.put<CancelOrderRepo>(CancelOrderRepoImpl());
  Get.put(CancelOrderUsecase(cancelOrderRepo: Get.find<CancelOrderRepo>()));
  Get.put(CancelReasonController(
      cancelReasonUsecase: Get.find<CancelReasonUsecase>(),
      cancelOrderUsecase: Get.find<CancelOrderUsecase>()));

  Get.put(MakeOrderController());
}
