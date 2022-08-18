import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/controllers/connections/connection_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

import '../../../widgets_constants/constants/colors.dart';

class BlogDetailsPage extends StatefulWidget {
  const BlogDetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final int id;

  @override
  State<BlogDetailsPage> createState() => _BlogDetailsPageState();
}

class _BlogDetailsPageState extends State<BlogDetailsPage> {
  ConnectionController connectionController = Get.find();
  @override
  void initState() {
    getBlogDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SolhAppBar(
          title: Text(
            'Blog Details',
            style: SolhTextStyles.AppBarText,
          ),
          isLandingScreen: false,
        ),
        body: Obx(() {
          return connectionController.isBlogDetailsLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          connectionController.blogDetails.value.name ?? '',
                          style: SolhTextStyles.JournalingUsernameText,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.eye,
                              color: SolhColors.green,
                              size: 12,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              connectionController.blogDetails.value.views
                                  .toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: SolhColors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          imageUrl:
                              connectionController.blogDetails.value.image ??
                                  '',
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Html(
                            data: connectionController
                                    .blogDetails.value.content ??
                                ''),
                      ),
                    ],
                  ),
                );
        }));
  }

  void getBlogDetails() {
    connectionController.getBlogDetails(widget.id);
  }
}
