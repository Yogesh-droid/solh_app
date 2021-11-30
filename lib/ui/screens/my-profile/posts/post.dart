import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/ui/screens/journaling/widgets/journal-post.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        isLandingScreen: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Posts",
              style: SolhTextStyles.AppBarText.copyWith(
                  color: Colors.black, fontSize: 18),
            ),
            Text(
              "07",
              style: SolhTextStyles.SOSGreyText.copyWith(fontSize: 12),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Created",
                    style: TextStyle(color: SolhColors.green),
                  ),
                  Text("Saved")
                ],
              ),
            ),
            // PostTile(),
            // PostTile(),
            // PostTile(),
            // PostTile()
          ],
        ),
      ),
    );
  }
}
