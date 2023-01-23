/* import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/bloc/user-bloc.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/getHelp/consultant_controller.dart';
import 'package:solh/ui/screens/get-help/book_appointment.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/image_container.dart';

class ConsultantProfile extends StatefulWidget {
  const ConsultantProfile({Key? key, required id})
      : id = id,
        super(key: key);

  final String id;
  @override
  State<ConsultantProfile> createState() => _ConsultantProfileState();
}

class _ConsultantProfileState extends State<ConsultantProfile> {
  ConsultantController _controller = Get.put(ConsultantController());
  final _bookingController = Get.put(BookAppointmentController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getConsultantDataController(widget.id);
    });

    super.initState();
  }

  void dispose() {
    _bookingController.selectedDay.value =
        DateFormat('EEEE').format(DateTime.now());
    _bookingController.selectedTimeSlot.value = '';
    _bookingController.showBookingDetail.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: SolhAppBar(
          isLandingScreen: false,
          title: Text(
            'Connect',
            style: GoogleFonts.signika(color: SolhColors.black),
          ),
        ),
        body: _controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  consultantProfileImage(),
                  SizedBox(
                    height: 12,
                  ),
                  consultantInfo(context, _controller),
                  SizedBox(
                    height: 29.5,
                  ),
                  consultantStatistics(),
                  SizedBox(
                    height: 32,
                  ),
                  ConsultantBio(),
                  SizedBox(
                    height: 41,
                  ),
                  Text(
                    _controller
                                .consultantModelController.value.provder!.fee_amount! >
                            0
                        ? '${_controller.consultantModelController.value.provder!.feeCurrency} ${_controller.consultantModelController.value.provder!.fee_amount}'
                        : (_controller.consultantModelController.value.provder!
                                        .fee ==
                                    null ||
                                _controller.consultantModelController.value
                                        .provder!.fee ==
                                    'Paid' ||
                                _controller.consultantModelController.value
                                        .provder!.fee ==
                                    ''
                            ? 'Paid'
                            : ''),
                    style: GoogleFonts.signika(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: SolhColors.pink224),
                  ),
                  Text(
                    'Consultation Fees',
                    style: GoogleFonts.signika(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: SolhColors.grey_2),
                  ),
                  SizedBox(
                    height: 41,
                  ),
                  BookAppointmentButton()
                ],
              ),
      );
    });
  }

  consultantProfileImage() {
    return SimpleImageContainer(
      imageUrl: _controller
              .consultantModelController.value.provder!.profilePicture ??
          'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y',
      enableborder: true,
      radius: 120,
    );
  }

  consultantInfo(context, ConsultantController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            controller.consultantModelController.value.provder != null
                ? Text(
                    controller.consultantModelController.value.provder!.name ??
                        '',
                    style: GoogleFonts.signika(
                        fontSize: 20, fontWeight: FontWeight.w400),
                  )
                : Container(),
            SizedBox(
              width: 8,
            ),
            SvgPicture.asset(
              'assets/images/solh_certified_consultant.svg',
              color: SolhColors.primary_green,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            controller.consultantModelController.value.provder!.experience !=
                    null
                ? Row(
                    children: [
                      Text(
                        (controller.consultantModelController.value.provder!
                                        .experience ??
                                    ' ')
                                .toString() +
                            ' Year of  Experience',
                        style: GoogleFonts.signika(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: SolhColors.primary_green),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                    ],
                  )
                : Container(),
            SizedBox(
              width: 8,
            ),
            Row(
              children: [],
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Text(
            controller
                    .consultantModelController.value.provder!.specialization ??
                '',
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.signika(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  consultantStatistics() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  color: SolhColors.primary_green,
                ),
                Text(
                  ' 0',
                  style: GoogleFonts.signika(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: SolhColors.primary_green),
                ),
              ],
            ),
            Text('Likes',
                style: GoogleFonts.signika(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: SolhColors.primary_green))
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.group,
                  color: SolhColors.primary_green,
                ),
                Text(
                  ' 0',
                  style: GoogleFonts.signika(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: SolhColors.primary_green),
                ),
              ],
            ),
            Text('Consultations',
                style: GoogleFonts.signika(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: SolhColors.primary_green))
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/images/Reviews.svg'),
                Text(
                  ' 0',
                  style: GoogleFonts.signika(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: SolhColors.primary_green),
                ),
              ],
            ),
            Text('Reviews',
                style: GoogleFonts.signika(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: SolhColors.primary_green))
          ],
        )
      ],
    );
  }

  ConsultantBio() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ReadMoreText(
        _controller.consultantModelController.value.provder!.bio ?? '',
        textAlign: TextAlign.center,
        style: GoogleFonts.signika(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700),
        trimLines: 4,
        colorClickableText: SolhColors.primary_green,
        trimMode: TrimMode.Line,
        trimCollapsedText: ' More',
        trimExpandedText: 'Read less',
        moreStyle: TextStyle(
            color: SolhColors.primary_green,
            fontSize: 14,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class BookAppointmentButton extends StatelessWidget {
  BookAppointmentButton({Key? key}) : super(key: key);

  BookAppointmentController _controller = Get.find();
  var isExpandedHeight = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Obx(() {
                return _controller.showBookingDetail.value
                    ? ModalSheetContent()
                    : DayPicker();
              });
            });
      },
      child: Container(
        height: 48,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: SolhColors.primary_green,
            borderRadius: BorderRadius.circular(24)),
        child: Center(
          child: Text(
            'Book Appointment',
            style: GoogleFonts.signika(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: SolhColors.white),
          ),
        ),
      ),
    );
  }
}

class ModalSheetContent extends StatefulWidget {
  const ModalSheetContent({Key? key}) : super(key: key);

  @override
  State<ModalSheetContent> createState() => _ModalSheetContentState();
}

class _ModalSheetContentState extends State<ModalSheetContent> {
  BookAppointmentController _bookingController =
      Get.put(BookAppointmentController());
  ConsultantController _consultantController = Get.find();

  void initState() {
    // _bookingController.mobileNotextEditingController.text =
    //     userBlocNetwork.userMobileNo;
    // _bookingController.emailTextEditingController.text =
    //     userBlocNetwork.userEmail;

    _bookingController.isSlotAdded(
        providerId: _consultantController
            .consultantModelController.value.provder!.sId!);

    super.initState();
  }

  @override
  void dispose() {
    _bookingController.selectedDay.value = '';
    _bookingController.selectedTimeSlot.value = '';
    _bookingController.showBookingDetail.value = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _bookingController.showBookingDetail.value
          ? Padding(
              // padding: const EdgeInsets.symmetric(horizontal: 20),
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 80.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Enter details below',
                        style: GoogleFonts.signika(fontSize: 16),
                      ),
                      Column(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              'Mobile No.',
                              style: GoogleFonts.signika(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff666666),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffA6A6A6),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: TextField(
                                    controller: _bookingController
                                        .mobileNotextEditingController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email-Id.',
                              style: GoogleFonts.signika(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff666666),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffA6A6A6),
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: TextField(
                                    controller: _bookingController
                                        .emailTextEditingController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Preffered date & time.',
                              style: GoogleFonts.signika(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff666666),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            InkWell(
                              onTap: () {
                                _bookingController.showBookingDetail.value =
                                    false;
                              },
                              child: Container(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xffA6A6A6),
                                    ),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Container(
                                    height: 48,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            _bookingController
                                                        .selectedDay.value !=
                                                    ''
                                                ? ('Today' ==
                                                        _bookingController
                                                            .selectedDay.value
                                                    ? 'Today'
                                                    : '${_bookingController.selectedDay.value}')
                                                : 'Select',
                                            style: GoogleFonts.signika(
                                                color:
                                                    SolhColors.primary_green)),
                                        Row(
                                          children: [
                                            Text(
                                                _bookingController
                                                    .selectedTimeSlot.value,
                                                style: GoogleFonts.signika(
                                                  color:
                                                      SolhColors.primary_green,
                                                )),
                                            Icon(
                                              Icons.arrow_drop_down,
                                              color: SolhColors.primary_green,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'How Can we help ? (optional)',
                              style: GoogleFonts.signika(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff666666),
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              height: MediaQuery.of(context).size.height * 0.17,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffA6A6A6),
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: TextField(
                                controller:
                                    _bookingController.catTextEditingController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        BookAppointmentWidget(),
                      ])
                    ],
                  ),
                ),
              ),
            )
          : DayPicker();
    });
  }
}
 */