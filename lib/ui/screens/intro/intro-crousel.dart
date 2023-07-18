import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:solh/routes/routes.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class IntroCrousel extends StatefulWidget {
  const IntroCrousel({Key? key}) : super(key: key);

  @override
  _IntroCrouselState createState() => _IntroCrouselState();
}

class _IntroCrouselState extends State<IntroCrousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _showBackButton = false;

  static const List<String> _heading = [
    "Solh",
    "Share & Listen",
    "Connect with Professionals",
    "Goal Setting"
  ];

  static const List<String> _description = [
    '''Cultivate a healthy environment, increase your resilience, stay focused, and relieve stress by connecting with
people & mental healthcare professionals.''',
    '''Our Solh App community is here to listen, share and support you. So let go of those inhibitions and lay out those anxious thoughts that cast a shadow over your capabilities.''',
    '''To get the help you need to diagnose and treat stress, anxiety and mental disorders, connect with our array of experts today!''',
    '''Connect with the best of minds to simplify goal setting, scan daily progress and overcome your self-imposed bottlenecks to turn more productive and emotionally balanced.''',
  ];

  Future _animatePageToForward() async {
    if (_currentPage < 3) {
      _currentPage++;
      if (_currentPage == 3) setState(() {});
      await _pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    }
  }

  Future _animatePageToBackward() async {
    if (_currentPage > 0) {
      _currentPage--;
      await _pageController.animateToPage(_currentPage,
          duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    }
  }

  void _onPageChanged(page) {
    _currentPage = page;
    if (_currentPage > 0 && _showBackButton == false)
      setState(() {
        _showBackButton = true;
      });
    if (_currentPage == 2) setState(() {});
    if (_currentPage == 3) setState(() {});
    if (_currentPage == 0)
      setState(() {
        _showBackButton = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (_showBackButton)
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                    onPressed: () async {
                      await _animatePageToBackward();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: SolhColors.primary_green,
                    )),
                SkipButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.phoneAuthScreen);
                  },
                )
              ])
            else
              Align(
                  alignment: Alignment.topRight,
                  child: SkipButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.phoneAuthScreen);
                    },
                  )),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: _onPageChanged,
                      controller: _pageController,
                      itemCount: 4,
                      itemBuilder: (_, index) => CrouselIntro(
                        index: index,
                        heading: _heading[index],
                        description: _description[index],
                      ),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 4,
                    effect: ScrollingDotsEffect(
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotScale: 1.5,
                        activeDotColor: Theme.of(context).primaryColor),
                  ),
                  NextButton(
                    isOnLast: _currentPage == 3,
                    onPressed: () async {
                      if (_currentPage == 3)
                        Navigator.pushNamed(context, AppRoutes.phoneAuthScreen);
                      else
                        await _animatePageToForward();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CrouselIntro extends StatelessWidget {
  const CrouselIntro({
    Key? key,
    required int index,
    required String heading,
    required String description,
  })  : _index = index,
        _heading = heading,
        _description = description,
        super(key: key);

  final int _index;
  final String _heading;
  final String _description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 2.5.h),
          width: 100.w,
          child: Image.asset(
            "assets/intro/png/crousel-${_index + 1}.png",
            fit: BoxFit.fitWidth,
          ),
        ),
        Column(
          children: [
            Text(
              _heading,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 5.w),
              child: Text(
                _description,
                style: TextStyle(color: SolhColors.black34),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class SkipButton extends StatelessWidget {
  const SkipButton({
    Key? key,
    VoidCallback? onPressed,
    TextStyle? buttonstyle,
  })  : _onPressed = onPressed,
        _buttonstyle = buttonstyle,
        super(key: key);

  final VoidCallback? _onPressed;
  final TextStyle? _buttonstyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: Theme.of(context).textButtonTheme.style?.copyWith(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.transparent)),
      child: Text(
        "Skip".tr,
        style: _buttonstyle ?? SolhTextStyles.GreenBorderButtonText,
      ),
      onPressed: _onPressed,
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({
    Key? key,
    required bool isOnLast,
    VoidCallback? onPressed,
  })  : _isOnLast = isOnLast,
        _onPressed = onPressed,
        super(key: key);

  final VoidCallback? _onPressed;
  final bool _isOnLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6.h, bottom: 2.h),
      width: 80.w,
      height: 5.8.h,
      child: TextButton(
        child: Text(_isOnLast ? "Get Started" : "Next"),
        onPressed: _onPressed,
      ),
    );
  }
}
