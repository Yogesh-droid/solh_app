import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/screens/welcome/landing-after-carousel.dart';
import 'package:solh/ui/screens/widgets/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({Key? key}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          "Create Post",
          style: SolhTextStyles.AppBarText,
        ),
        isLandingScreen: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UsernameHeader(),
            SizedBox(height: 2.h),
            Container(
              child: TextField(
                maxLength: 240,
                maxLines: 6,
                minLines: 3,
                decoration: InputDecoration(
                    fillColor: SolhColors.grey239,
                    hintText: "What's on your mind?",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: SolhColors.green)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: SolhColors.green)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: SolhColors.green))),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              "Feelings",
              style: SolhTextStyles.JournalingDescriptionReadMoreText.copyWith(
                  color: SolhColors.grey102),
            ),
            SizedBox(
              height: 1.h,
            ),
            StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 12,
              staggeredTileBuilder: (index) => StaggeredTile.count(1, 0.4),
              itemBuilder: (context, index) => Container(
                alignment: Alignment.center,
                margin:
                    EdgeInsets.symmetric(vertical: 0.8.h, horizontal: 1.5.w),
                decoration: BoxDecoration(
                    border: Border.all(color: SolhColors.green),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Text("Happy 😊"),
              ),
              crossAxisCount: 3,
            ),
            SizedBox(height: 2.h),
            SolhGreenBorderButton(
              child: Text(
                "Pic from Diary",
                style: SolhTextStyles.GreenBorderButtonText,
              ),
              onPressed: () => print("Pressed"),
            ),
            SizedBox(height: 2.h),
            SolhGreenBorderButton(
              child: Text(
                "Add Image/Video",
                style: SolhTextStyles.GreenBorderButtonText,
              ),
              onPressed: () => print("Pressed"),
            ),
            SizedBox(height: 5.h),
            SolhGreenButton(
              child: Text("Post"),
              onPressed: () => print("Pressed"),
            )
          ],
        ),
      ),
    );
  }
}

class UsernameHeader extends StatefulWidget {
  const UsernameHeader({Key? key}) : super(key: key);

  @override
  _UsernameHeaderState createState() => _UsernameHeaderState();
}

class _UsernameHeaderState extends State<UsernameHeader> {
  String _dropdownValue = "P";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 6.w,
              backgroundImage: NetworkImage(
                  "https://qph.fs.quoracdn.net/main-qimg-6d89a6af21f564db1096d6dbd060f831"),
            ),
            SizedBox(
              width: 2.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Santra Johns",
                  style: SolhTextStyles.JournalingUsernameText.copyWith(
                      fontWeight: FontWeight.normal, fontSize: 14),
                ),
                Text(
                  "Happiness Maker",
                  style:
                      SolhTextStyles.JournalingBadgeText.copyWith(fontSize: 12),
                )
              ],
            ),
          ],
        ),
        Container(
          height: 4.5.h,
          width: 35.w,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              border: Border.all(
                color: SolhColors.green,
              )),
          child: DropdownButton(
              isExpanded: true,
              icon: Icon(CupertinoIcons.chevron_down),
              iconSize: 18,
              iconEnabledColor: SolhColors.green,
              underline: SizedBox(),
              value: _dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownValue = newValue!;
                });
              },
              style: TextStyle(color: SolhColors.green),
              items: [
                DropdownMenuItem(
                  child: Text("Publicaly"),
                  value: "P",
                ),
                DropdownMenuItem(child: Text("Connections"), value: "C"),
                DropdownMenuItem(
                  child: Text("MyDiary"),
                  value: "MD",
                )
              ]),
        )
      ],
    );
  }
}
