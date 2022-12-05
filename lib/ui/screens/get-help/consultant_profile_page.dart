import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import '../../../controllers/getHelp/consultant_controller.dart';
import '../../../widgets_constants/image_container.dart';

class ConsultantProfilePage extends StatefulWidget {
  ConsultantProfilePage({Key? key}) : super(key: key);

  @override
  State<ConsultantProfilePage> createState() => _ConsultantProfilePageState();
}

class _ConsultantProfilePageState extends State<ConsultantProfilePage> {
  final ConsultantController _controller = Get.find();
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        if (_isAppbarCollpased) {
          _controller.isTitleVisible.value = true;
          print('appbar is closed');
        } else {
          _controller.isTitleVisible.value = false;
          print('appbar is expanded');
        }
      });
    super.initState();
  }

  bool get _isAppbarCollpased {
    return _scrollController.hasClients && _scrollController.offset > 200;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
      body: CustomScrollView(controller: _scrollController, slivers: [
        Obx(() => SliverAppBar(
              snap: false,
              pinned: true,
              floating: false,
              leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                  )),
              backgroundColor: _controller.isTitleVisible.value
                  ? SolhColors.primary_green
                  : Colors.transparent,
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
              expandedHeight: 320,
              flexibleSpace: expandedWidget(),
            )),
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: SolhColors.white,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20), right: Radius.circular(20))),
            child: Obx(() =>
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  bookingButton(),
                  SizedBox(
                    height: 40,
                  ),
                  detailsContainer(),
                  SizedBox(
                    height: 20,
                  ),
                  aboutContainer(),
                  Container(
                    height: 200,
                  ),
                  Container(
                    height: 200,
                  ),
                  Container(
                    height: 200,
                  ),
                  Container(
                    height: 200,
                  ),
                ])),
          ),
        )
      ]),
    );
  }

  Widget expandedWidget() {
    return FlexibleSpaceBar(
      title: collpasedWidget(),
      background: Obx(() => Column(
            children: [
              SizedBox(
                height: 100,
              ),
              SimpleImageContainer(
                imageUrl: _controller.consultantModelController.value.provder!
                        .profilePicture ??
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
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getAnalyticsBox(
                      icon: Icons.emoji_people_outlined,
                      no: '23',
                      title: 'Consultant'),
                  getAnalyticsBox(
                      icon: Icons.star_rate, no: '5', title: 'Ratings'),
                  getAnalyticsBox(
                      icon: Icons.edit_note, no: '23', title: 'Posts'),
                  getAnalyticsBox(
                      icon: Icons.thumb_up_rounded, no: '23', title: 'likes'),
                ],
              ),
            ],
          )),
    );
  }

  Widget collpasedWidget() {
    return Obx(() => AnimatedOpacity(
        opacity: _controller.isTitleVisible.value ? 1 : 0.0,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: CachedNetworkImageProvider(_controller
                      .consultantModelController
                      .value
                      .provder!
                      .profilePicture ??
                  'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y'),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
                _controller.consultantModelController.value.provder!.name ?? '',
                style: SolhTextStyles.appTextWhiteS12W7),
          ],
        )));
  }

  Widget getAnalyticsBox(
      {required IconData icon, required String no, required String title}) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: SolhColors.greenShade1),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(
                no,
                style: SolhTextStyles.SmallTextWhiteS12W7,
              )
            ],
          ),
          Text(
            title,
            style: SolhTextStyles.SmallTextWhiteS12W7,
          )
        ],
      ),
    );
  }

  Widget detailsContainer() {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Details',
                style: SolhTextStyles.Body_2_bold.copyWith(
                    color: SolhColors.primary_green),
              ),
              Text(
                ". ${_controller.consultantModelController.value.provder!.specialization ?? ''}",
                style: SolhTextStyles.Caption,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                ". ${_controller.consultantModelController.value.provder!.specialization ?? ''}",
                style: SolhTextStyles.Caption,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget aboutContainer() {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About',
              style: SolhTextStyles.Body_2_bold.copyWith(
                  color: SolhColors.primary_green)),
          Text(
            "${_controller.consultantModelController.value.provder!.bio ?? ''}",
            style: SolhTextStyles.Body_2,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget bookingButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
            _controller.consultantModelController.value.provder!.fee_amount! > 0
                ? '${_controller.consultantModelController.value.provder!.feeCurrency} ${_controller.consultantModelController.value.provder!.fee_amount}'
                : (_controller.consultantModelController.value.provder!.fee ==
                            null ||
                        _controller
                                .consultantModelController.value.provder!.fee ==
                            'Paid' ||
                        _controller
                                .consultantModelController.value.provder!.fee ==
                            ''
                    ? 'Paid'
                    : ''),
            style: SolhTextStyles.QS_body_1_bold.copyWith(
                color: SolhColors.primary_green)),
        VerticalDivider(
          color: SolhColors.black,
          thickness: 2,
        ),
        SolhGreenButton(
          width: 200,
          height: 48,
          child: Text(
            'Book Appointment',
            style: SolhTextStyles.BUTTON.copyWith(color: SolhColors.white),
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
