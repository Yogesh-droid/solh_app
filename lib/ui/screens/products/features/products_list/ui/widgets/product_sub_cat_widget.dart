import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/controllers/product_sub_cat_controller.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/controllers/products_list_controller.dart';
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
            : ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: productSubCatController
                    .productSubCatEntity.value.subCategory!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              productsListController.query =
                                  "&subcategory=${productSubCatController.productSubCatEntity.value.subCategory![index].id}";
                              productsListController.getProductList(catId!, 1);
                            },
                            child: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.white,
                              backgroundImage: CachedNetworkImageProvider(
                                  productSubCatController
                                          .productSubCatEntity
                                          .value
                                          .subCategory![index]
                                          .categoryImage ??
                                      ''),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            productSubCatController.productSubCatEntity.value
                                    .subCategory![index].categoryName ??
                                '',
                            style: SolhTextStyles.QS_cap_2_semi,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  );
                })));
  }
}
