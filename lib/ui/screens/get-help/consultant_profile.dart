import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:solh/controllers/getHelp/book_appointment.dart';
import 'package:solh/controllers/getHelp/consultant_controller.dart';
import 'package:solh/ui/screens/get-help/book_appointment.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

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

  @override
  void initState() {
    _controller.getConsultantDataController(widget.id);
    super.initState();
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
                  ConsultantBio(context, _controller),
                  SizedBox(
                    height: 41,
                  ),
                  BookAppointmentWidget()
                ],
              ),
      );
    });
  }
}

consultantProfileImage() {
  return Container(
    padding: EdgeInsets.all(4),
    height: 124,
    width: 124,
    decoration: BoxDecoration(shape: BoxShape.circle, color: SolhColors.green),
    child: CircleAvatar(
      backgroundImage: NetworkImage(
          'https://www.gravatar.com/avatar/00000000000000000000000000000000?d=mp&f=y'),
    ),
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
            color: SolhColors.green,
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          controller.consultantModelController.value.provder!.experience != null
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
                          color: SolhColors.green),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: 2,
                      height: 12,
                      color: Colors.grey.shade300,
                    ),
                  ],
                )
              : Container(),
          SizedBox(
            width: 8,
          ),
          Text(
            'Free',
            style: GoogleFonts.signika(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: SolhColors.pink224),
          ),
        ],
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Text(
          controller.consultantModelController.value.provder!.specialization ??
              '',
          maxLines: 2,
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
                color: SolhColors.green,
              ),
              Text(
                ' 27',
                style: GoogleFonts.signika(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: SolhColors.green),
              ),
            ],
          ),
          Text('Likes',
              style: GoogleFonts.signika(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: SolhColors.green))
        ],
      ),
      Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.group,
                color: SolhColors.green,
              ),
              Text(
                ' 72',
                style: GoogleFonts.signika(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: SolhColors.green),
              ),
            ],
          ),
          Text('Consultations',
              style: GoogleFonts.signika(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: SolhColors.green))
        ],
      ),
      Column(
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/images/Reviews.svg'),
              Text(
                ' 17',
                style: GoogleFonts.signika(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: SolhColors.green),
              ),
            ],
          ),
          Text('Reviews',
              style: GoogleFonts.signika(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: SolhColors.green))
        ],
      )
    ],
  );
}

ConsultantBio(context, ConsultantController controller) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.8,
    child: ReadMoreText(
      controller.consultantModelController.value.provder!.bio ?? '',
      textAlign: TextAlign.center,
      style: GoogleFonts.signika(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade700),
      trimLines: 4,
      colorClickableText: SolhColors.green,
      trimMode: TrimMode.Line,
      trimCollapsedText: ' More',
      trimExpandedText: 'Read less',
      moreStyle: TextStyle(
          color: SolhColors.green, fontSize: 14, fontWeight: FontWeight.bold),
    ),
  );
}

class BookAppointmentWidget extends StatelessWidget {
  BookAppointmentWidget({Key? key}) : super(key: key);

  BookAppointmentController _controller = Get.find();
  var _consultantController = Get.put(ConsultantController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _controller.doctorName = _consultantController
                .consultantModelController.value.provder!.name ??
            "";
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BookAppointment(),
          ),
        );
      },
      child: Container(
        height: 48,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: SolhColors.green, borderRadius: BorderRadius.circular(24)),
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
