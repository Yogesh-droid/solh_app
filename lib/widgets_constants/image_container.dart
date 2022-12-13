import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';
import 'package:solh/widgets_constants/zoom_image.dart';

class SimpleImageContainer extends StatelessWidget {
  SimpleImageContainer(
      {Key? key,
      required this.imageUrl,
      this.radius = 40,
      this.onClick,
      this.zoomEnabled = false,
      this.borderWidth = 2.0,
      this.boxFit = BoxFit.contain,
      this.borderColor = SolhColors.primary_green,
      this.enableborder})
      : super(key: key);
  final String imageUrl;
  final double radius;
  final VoidCallback? onClick;
  final bool? enableborder;
  final bool zoomEnabled;
  final double borderWidth;
  final Color borderColor;
  final BoxFit boxFit;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => zoomEnabled
          ? Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ZoomImage(image: imageUrl)))
          : onClick),
      child: Container(
        padding: EdgeInsets.all(borderWidth),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enableborder == true ? borderColor : Colors.transparent,
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          color: SolhColors.grey,
          placeholder: (_, k) {
            return MyLoader();
          },
          imageBuilder: (context, imageProvider) => Container(
            width: radius,
            height: radius,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: imageProvider,
                fit: boxFit,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StackImage extends StatelessWidget {
  const StackImage({
    Key? key,
    required this.bottomImageUrl,
    this.bottomImageRadius = 40,
    this.bottomImageBorderEnable = false,
    this.bottomImageBorderRadius = 2,
    this.topImageBorderEnable = true,
    this.topImageBorderRadius = 1,
    this.topImageBorderColor = Colors.white,
    this.bottomImageBorderColor = SolhColors.primary_green,
    this.onClick,
    required this.topImageOffset,
    required this.topImageUrl,
    this.topImageRadius = 10,
  }) : super(key: key);
  final String bottomImageUrl;
  final String topImageUrl;
  final double bottomImageRadius;
  final double topImageRadius;
  final bool bottomImageBorderEnable;
  final bool topImageBorderEnable;
  final double bottomImageBorderRadius;
  final double topImageBorderRadius;
  final Offset topImageOffset;
  final Color bottomImageBorderColor;
  final Color topImageBorderColor;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Stack(
        children: [
          SimpleImageContainer(
            imageUrl: bottomImageUrl,
            radius: bottomImageRadius,
            enableborder: bottomImageBorderEnable,
            borderColor: bottomImageBorderEnable == true
                ? bottomImageBorderColor
                : Colors.transparent,
          ),
          Positioned(
              bottom: topImageOffset.dy,
              right: topImageOffset.dx,
              child: SimpleImageContainer(
                imageUrl: topImageUrl,
                radius: topImageRadius,
                enableborder: topImageBorderEnable,
                borderColor: topImageBorderEnable == true
                    ? Colors.white
                    : Colors.transparent,
                borderWidth: topImageBorderRadius,
              )),
        ],
      ),
    );
  }
}

class ImageWithProgressBarAndBadge extends StatelessWidget {
  const ImageWithProgressBarAndBadge(
      {Key? key,
      this.imageRadius = const Size(100, 100),
      this.percent = 0,
      required this.imageUrl})
      : super(key: key);

  final Size imageRadius;
  final int percent;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black45,

      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              children: [
                Positioned(
                  child: CustomPaint(
                    painter: OpenPainter2(imageRadius),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: CustomPaint(
                      // child: MyLoader(
                      //   radius: imageRadius.width / 2,
                      // ),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (_, k) {
                          return Container(
                            child: Center(
                              child: getImageShimmer(imageRadius.width),
                            ),
                          );
                        },
                        imageBuilder: (context, imageProvider) => Container(
                          width: imageRadius.width,
                          height: imageRadius.height,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                            ),
                          ),
                        ),
                      ),
                      painter: OpenPainter(imageRadius, percent)),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Percentagebadge(
                  percent: percent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  final Size imageSize;
  final int percent;
  OpenPainter(this.imageSize, this.percent);
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = SolhColors.primary_green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    //draw arc
    canvas.drawArc(
        Offset(0, 0) & Size(imageSize.height, imageSize.width),
        1.5, //radians
        6.25 * (percent / 100), //radians
        false,
        paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class OpenPainter2 extends CustomPainter {
  final Size imageSize;
  OpenPainter2(this.imageSize);
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = SolhColors.grey_3
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    //draw arc
    canvas.drawArc(
        Offset(0, 0) & Size(imageSize.height, imageSize.width),
        1.5, //radians
        6.4, //radians
        false,
        paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Percentagebadge extends StatelessWidget {
  const Percentagebadge({Key? key, this.percent = 0}) : super(key: key);

  final int percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14.w,
      height: 6.w,
      decoration: BoxDecoration(
          color: SolhColors.primary_green,
          border: Border.all(
            color: SolhColors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        '$percent %',
        style: SolhTextStyles.QS_cap_semi.copyWith(color: SolhColors.white),
      )),
    );
  }
}

Widget getImageShimmer(double width) {
  return Shimmer.fromColors(
    child: Container(
      height: width,
      width: width,
      decoration: BoxDecoration(shape: BoxShape.circle),
    ),
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
  );
}
