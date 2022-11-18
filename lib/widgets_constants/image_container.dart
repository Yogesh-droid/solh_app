import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
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
      this.borderColor = SolhColors.green,
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
    this.bottomImageBorderColor = SolhColors.green,
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
