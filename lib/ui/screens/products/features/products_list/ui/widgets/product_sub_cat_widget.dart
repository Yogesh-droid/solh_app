import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/controllers/product_sub_cat_controller.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/controllers/products_list_controller.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import '../../../../../../../widgets_constants/constants/textstyles.dart';
import 'product_sub_cat_shimmer.dart';

class ProductSubCatWidget extends StatelessWidget {
  const ProductSubCatWidget({super.key, this.catId});
  final String? catId;

  @override
  Widget build(BuildContext context) {
    final ProductSubCatController productSubCatController = Get.find();
    final ProductsListController productsListController = Get.find();
    return Obx(() => SizedBox(
        height: 120,
        child: productSubCatController.isLoading.value
            ? ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    10,
                    (index) => const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ProductSubCatShimmer(),
                        )),
              )
            : ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                    subcatContainer(
                        image:
                            "https://play-lh.googleusercontent.com/FzEj7FZTGxObAJcbG3yDCsboBKudZCCsBixOGY8aTuovcDdv10Nyqsma1z-CXdsw1A=w480-h960-rw",
                        title: "All",
                        isActive:
                            productsListController.selectedSubCat.value == "-1",
                        onTap: () {
                          productsListController.selectedSubCat.value = "-1";
                          productsListController.selectedSubCatName.value =
                              "All";
                          productsListController.query = "";
                          productsListController.getProductList(catId!, 1);
                        }),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: productSubCatController
                            .productSubCatEntity.value.subCategory!.length,
                        itemBuilder: (context, index) {
                          return subcatContainer(
                              image: productSubCatController
                                      .productSubCatEntity
                                      .value
                                      .subCategory![index]
                                      .categoryImage ??
                                  '',
                              title: productSubCatController.productSubCatEntity
                                      .value.subCategory![index].categoryName ??
                                  '',
                              isActive:
                                  productsListController.selectedSubCat.value ==
                                      productSubCatController
                                          .productSubCatEntity
                                          .value
                                          .subCategory![index]
                                          .id!,
                              onTap: () {
                                productsListController.selectedSubCat.value =
                                    productSubCatController.productSubCatEntity
                                        .value.subCategory![index].id!;
                                productsListController
                                        .selectedSubCatName.value =
                                    productsListController.query =
                                        productSubCatController
                                                .productSubCatEntity
                                                .value
                                                .subCategory![index]
                                                .categoryName ??
                                            '';
                                productsListController.query =
                                    "&subcategory=${productSubCatController.productSubCatEntity.value.subCategory![index].id}";
                                productsListController.getProductList(
                                    catId!, 1);
                              });
                        }),
                  ])));
  }

  Widget subcatContainer(
      {required String image,
      required String title,
      required bool isActive,
      required Function() onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 80,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: onTap,
              child: CircleAvatar(
                radius: 35,
                backgroundColor:
                    isActive ? SolhColors.primary_green : Colors.grey[200],
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  backgroundImage: CachedNetworkImageProvider(image),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: SolhTextStyles.QS_cap_2_semi.copyWith(
                  color: isActive
                      ? SolhColors.primary_green
                      : SolhColors.dark_grey),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
