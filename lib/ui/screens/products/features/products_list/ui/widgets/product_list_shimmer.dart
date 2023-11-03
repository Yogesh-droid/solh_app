import 'package:flutter/material.dart';
import 'package:solh/ui/screens/products/features/products_list/ui/widgets/shimmer_widget.dart';

class ProductListShimmer extends StatelessWidget {
  const ProductListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(
          10,
          (index) => Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: ShimmerWidget(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShimmerWidget(
                                    child: Container(
                                        height: 10,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    height: 20),
                                SizedBox(height: 10),
                                ShimmerWidget(
                                    child: Container(
                                        height: 40,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    height: 20),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ShimmerWidget(
                                        child: Container(
                                            height: 20,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        height: 20),
                                    ShimmerWidget(
                                        child: Container(
                                            height: 20,
                                            width: 70,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        height: 20),
                                  ],
                                ),
                                SizedBox(height: 10),
                                ShimmerWidget(
                                  child: Container(
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  height: 20,
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              )).toList(),
    );
  }
}
