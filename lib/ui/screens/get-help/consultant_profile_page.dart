import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/ui/screens/get-help/booking_price_details.dart';
import 'package:solh/widgets_constants/ScaffoldWithBackgroundArt.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import '../../../controllers/getHelp/consultant_controller.dart';
import '../../../widgets_constants/image_container.dart';
import 'widgets/book_appointment_sheet.dart';

class ConsultantProfilePage extends StatefulWidget {
  ConsultantProfilePage({Key? key}) : super(key: key);

  @override
  State<ConsultantProfilePage> createState() => _ConsultantProfilePageState();
}

class _ConsultantProfilePageState extends State<ConsultantProfilePage> {
  final ConsultantController _controller = Get.find();
  final BookAppointmentController bookAppointmentController = Get.find();
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
    bookAppointmentController.assignEmailAndMobField();
    super.initState();
  }

  bool get _isAppbarCollpased {
    return _scrollController.hasClients && _scrollController.offset > 200;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGreenWithBackgroundArt(
        body: Obx(
      () => _controller.isLoading.value
          ? Center(
              child: MyLoader(),
            )
          : CustomScrollView(controller: _scrollController, slivers: [
              Obx(() => SliverAppBar(
                    snap: false,
                    pinned: true,
                    floating: false,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                        )),
                    backgroundColor: _controller.isTitleVisible.value
                        ? SolhColors.primary_green
                        : Colors.transparent,
                    actions: [
                      // PopupMenuButton(
                      //     itemBuilder: (context) => [
                      //           PopupMenuItem(
                      //             child: Text('Setting'),
                      //           )
                      //         ]),
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
                          left: Radius.circular(20),
                          right: Radius.circular(20))),
                  child: Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              height: 400,
                            ),
                          ])),
                ),
              )
            ]),
    ));
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _controller
                            .consultantModelController.value.provder!.prefix ??
                        '',
                    style: SolhTextStyles.QS_body_1_bold.copyWith(
                        color: SolhColors.white),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    _controller.consultantModelController.value.provder!.name ??
                        '',
                    style: SolhTextStyles.QS_body_1_bold.copyWith(
                        color: SolhColors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${_controller.consultantModelController.value.provder!.profession}',
                    style: SolhTextStyles.QS_cap_semi.copyWith(
                        color: SolhColors.white),
                  ),
                  _controller.consultantModelController.value.provder!
                              .experience ==
                          null
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                        ),
                  Text(
                    _controller.consultantModelController.value.provder!
                                    .experience !=
                                null &&
                            _controller.consultantModelController.value.provder!
                                    .experience! >
                                0
                        ? _controller.consultantModelController.value.provder!
                                .experience
                                .toString() +
                            ' Years'
                        : '',
                    style: SolhTextStyles.QS_cap_semi.copyWith(
                        color: Colors.white),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  getAnalyticsBox(
                      icon: 'assets/images/get_help/smile.svg',
                      no: '${_controller.consultantModelController.value.provder!.apptCount}',
                      title: 'Consultant'),
                  getAnalyticsBox(
                      icon: 'assets/images/get_help/star.svg',
                      no: '${_controller.consultantModelController.value.provder!.ratingCount}',
                      title: 'Ratings'),
                  getAnalyticsBox(
                      icon: 'assets/images/get_help/post.svg',
                      no: '${_controller.consultantModelController.value.provder!.postCount}',
                      title: 'Posts'),
                  getAnalyticsBox(
                      icon: 'assets/images/get_help/thumbs up.svg',
                      no: '${_controller.consultantModelController.value.provder!.likeCount}',
                      title: 'likes'),
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
      {required String icon, required String no, required String title}) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: SolhColors.greenShade1),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(icon),
              SizedBox(
                width: 5,
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
    return Obx(() =>
        _controller.consultantModelController.value.provder!.specialization !=
                null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Details',
                    style: SolhTextStyles.QS_body_2_bold.copyWith(
                        color: SolhColors.primary_green),
                  ),
                  Text(
                    ". ${_controller.consultantModelController.value.provder!.specialization ?? ''}",
                    style: SolhTextStyles.QS_caption,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    ". ${_controller.consultantModelController.value.provder!.education ?? ''}",
                    style: SolhTextStyles.QS_caption,
                    maxLines: 2,
                  ),
                ],
              )
            : Container());
  }

  Widget aboutContainer() {
    return Obx(() =>
        _controller.consultantModelController.value.provder!.bio!.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About',
                      style: SolhTextStyles.QS_body_2_bold.copyWith(
                          color: SolhColors.primary_green)),
                  ReadMoreText(
                    "${_controller.consultantModelController.value.provder!.bio ?? ''}",
                    style: SolhTextStyles.QS_body_2,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                  ),
                ],
              )
            : Container());
  }

  Widget bookingButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
                _controller.consultantModelController.value.provder!.fee_amount! >
                        0
                    ? '${_controller.consultantModelController.value.provder!.feeCurrency} ${_controller.consultantModelController.value.provder!.fee_amount}'
                    : (_controller.consultantModelController.value.provder!
                                    .fee ==
                                null ||
                            _controller.consultantModelController.value.provder!
                                    .fee ==
                                'Paid' ||
                            _controller.consultantModelController.value.provder!
                                    .fee ==
                                ''
                        ? 'Paid'
                        : ''),
                style: SolhTextStyles.QS_body_1_bold.copyWith(
                    color: SolhColors.primary_green)),
            _controller.consultantModelController.value.provder!.fee_amount! > 0
                ? Text(
                    'Consultation Fee',
                    style: SolhTextStyles.QS_cap_2.copyWith(
                        color: SolhColors.Grey_1),
                  )
                : Container()
          ],
        ),
        Container(
          height: 30,
          child: VerticalDivider(
            color: SolhColors.grey,
            thickness: 1,
          ),
        ),
        SolhGreenButton(
          width: 200,
          height: 48,
          child: Text(
            'Book Appointment',
            style: SolhTextStyles.CTA.copyWith(color: SolhColors.white),
          ),
          onPressed: () {
            // bookAppointmentController.selectedDayForTimeSlot.value =
            //     DateTime.now().day;
            // bookAppointmentController.selectedDate.value = DateTime.now();
            // bookAppointmentController.getTimeSlot(
            //     providerId:
            //         _controller.consultantModelController.value.provder!.sId,
            //     date: DateFormat('yyyy-MM-dd').format(DateTime.now()));
            openBookingSheet();
            FirebaseAnalytics.instance.logEvent(
                name: 'BookAppontmentTapped',
                parameters: {'Page': 'ConsultantProfile'});
          },
        )
      ],
    );
  }

  void openBookingSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return BookAppoinmentSheet(
            onContinueBtnPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BookingPriceDetails();
              }));
            },
          );
        });
  }
}
