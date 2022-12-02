import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../controllers/getHelp/consultant_controller.dart';
import '../../../widgets_constants/image_container.dart';

class ConsultantProfilePage extends StatelessWidget {
  ConsultantProfilePage({Key? key}) : super(key: key);
  final ConsultantController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          snap: false,
          pinned: false,
          floating: false,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
              )),
          backgroundColor: Colors.transparent,
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('Setting'),
                      )
                    ]),
            SOSButton()
          ],
          elevation: 0.0,
          expandedHeight: 300,
          flexibleSpace: expandedWidget(),
        )
      ]),
    );
  }

  Widget expandedWidget() {
    return FlexibleSpaceBar(
      title: collpasedWidget(),
      background: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          SimpleImageContainer(
            imageUrl: _controller
                    .consultantModelController.value.provder!.profilePicture ??
                'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
            enableborder: true,
            borderColor: SolhColors.white,
            zoomEnabled: true,
            borderWidth: 5,
            radius: 100,
          ),
          Text(
            _controller.consultantModelController.value.provder!.name ?? '',
            style: SolhTextStyles.Large2TextWhiteS24W7,
          ),
          Text(
            'Profession(Doctor)',
            style: SolhTextStyles.SmallTextWhiteS12W7,
          )
        ],
      ),
    );
  }

  Widget collpasedWidget() {
    return Text('');
  }
}
