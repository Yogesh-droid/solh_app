import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:solh/ui/screens/get-help/book_appointment.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class ConsultantProfile extends StatefulWidget {
  const ConsultantProfile({Key? key}) : super(key: key);

  @override
  State<ConsultantProfile> createState() => _ConsultantProfileState();
}

class _ConsultantProfileState extends State<ConsultantProfile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SolhAppBar(
          isLandingScreen: false,
          title: Text(
            'Connect',
            style: GoogleFonts.signika(color: SolhColors.black),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
            ),
            consultantProfileImage(),
            SizedBox(
              height: 12,
            ),
            consultantInfo(context),
            SizedBox(
              height: 29.5,
            ),
            consultantStatistics(),
            SizedBox(
              height: 32,
            ),
            ConsultantBio(context),
            SizedBox(
              height: 41,
            ),
            BookAppointmentWidget()
          ],
        ),
      ),
    );
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

consultantInfo(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Dr. Priyanka Trivedi (PhD)',
            style:
                GoogleFonts.signika(fontSize: 20, fontWeight: FontWeight.w400),
          ),
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
          Text(
            '07 Year of  Experience',
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
            'PhD - Psychology, MA - Psychology Health Psychologist, Psychotherapist...',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.signika(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            )),
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

ConsultantBio(context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.8,
    child: ReadMoreText(
      'Flutter is Googles mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
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
  const BookAppointmentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BookAppointment(),
        ),
      ),
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
