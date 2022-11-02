import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class SimpleImageContainer extends StatelessWidget {
  SimpleImageContainer(
      {Key? key,
      required this.imageUrl,
      this.radius = 40,
      this.onClick,
      this.borderWidth = 2.0,
      this.borderColor = SolhColors.green,
      this.enableborder})
      : super(key: key);
  final String imageUrl;
  final double radius;
  final VoidCallback? onClick;
  final bool? enableborder;
  final double borderWidth;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
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
            return const CircularProgressIndicator(
              strokeWidth: 1,
            );
          },
          imageBuilder: (context, imageProvider) => Container(
            width: radius,
            height: radius,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
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
