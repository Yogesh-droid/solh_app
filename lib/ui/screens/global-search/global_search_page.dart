import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/controllers/search/global_search_controller.dart';
import 'package:solh/widgets_constants/solh_search.dart';

class GlobalSearchPage extends StatelessWidget {
  GlobalSearchPage({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();
  final GlobalSearchController globalSearchController =
      Get.put(GlobalSearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SolhSearch(
              textController: searchController,
              onCloseBtnTap: () {
                searchController.clear();
              },
              onSubmitted: (value) {},
            )
          ],
        ),
      ),
    ));
  }
}
