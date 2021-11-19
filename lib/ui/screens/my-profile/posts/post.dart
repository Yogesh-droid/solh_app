import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/main.dart';
import 'package:solh/ui/screens/journaling/widgets/journal-post.dart';
import 'package:solh/ui/screens/widgets/app-bar.dart';
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
            Post(
              imgUrl:
                  "https://c8.alamy.com/comp/2E60KT1/albanian-artist-saimir-strati-45-poses-in-front-of-his-coffee-bean-mosaic-with-his-guinness-world-records-certificate-in-tirana-december-12-2011-the-mosaic-made-with-a-million-coffee-beans-depicting-five-musicians-entered-the-guinness-world-records-on-monday-as-the-worlds-largest-coffee-bean-mosaic-strati-used-140-kg-309-pounds-of-coffee-beans-some-roasted-black-some-averagely-and-some-not-roasted-at-all-to-portray-a-brazilian-dancer-a-japanese-drummer-a-us-country-music-singer-a-european-accordionist-and-an-african-drummer-reutersarben-celi-albania-tags-society-2E60KT1.jpg",
            ),
            Post(
              imgUrl:
                  "https://c8.alamy.com/comp/2E60KT1/albanian-artist-saimir-strati-45-poses-in-front-of-his-coffee-bean-mosaic-with-his-guinness-world-records-certificate-in-tirana-december-12-2011-the-mosaic-made-with-a-million-coffee-beans-depicting-five-musicians-entered-the-guinness-world-records-on-monday-as-the-worlds-largest-coffee-bean-mosaic-strati-used-140-kg-309-pounds-of-coffee-beans-some-roasted-black-some-averagely-and-some-not-roasted-at-all-to-portray-a-brazilian-dancer-a-japanese-drummer-a-us-country-music-singer-a-european-accordionist-and-an-african-drummer-reutersarben-celi-albania-tags-society-2E60KT1.jpg",
            ),
            Post(
              imgUrl:
                  "https://c8.alamy.com/comp/2E60KT1/albanian-artist-saimir-strati-45-poses-in-front-of-his-coffee-bean-mosaic-with-his-guinness-world-records-certificate-in-tirana-december-12-2011-the-mosaic-made-with-a-million-coffee-beans-depicting-five-musicians-entered-the-guinness-world-records-on-monday-as-the-worlds-largest-coffee-bean-mosaic-strati-used-140-kg-309-pounds-of-coffee-beans-some-roasted-black-some-averagely-and-some-not-roasted-at-all-to-portray-a-brazilian-dancer-a-japanese-drummer-a-us-country-music-singer-a-european-accordionist-and-an-african-drummer-reutersarben-celi-albania-tags-society-2E60KT1.jpg",
            ),
            Post(
              imgUrl:
                  "https://c8.alamy.com/comp/2E60KT1/albanian-artist-saimir-strati-45-poses-in-front-of-his-coffee-bean-mosaic-with-his-guinness-world-records-certificate-in-tirana-december-12-2011-the-mosaic-made-with-a-million-coffee-beans-depicting-five-musicians-entered-the-guinness-world-records-on-monday-as-the-worlds-largest-coffee-bean-mosaic-strati-used-140-kg-309-pounds-of-coffee-beans-some-roasted-black-some-averagely-and-some-not-roasted-at-all-to-portray-a-brazilian-dancer-a-japanese-drummer-a-us-country-music-singer-a-european-accordionist-and-an-african-drummer-reutersarben-celi-albania-tags-society-2E60KT1.jpg",
            )
          ],
        ),
      ),
    );
  }
}
