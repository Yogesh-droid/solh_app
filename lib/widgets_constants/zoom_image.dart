import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ZoomImage extends StatefulWidget {
  ZoomImage({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  State<ZoomImage> createState() => _ZoomImageState();
}

class _ZoomImageState extends State<ZoomImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            InteractiveViewer(
              scaleEnabled: true,
              minScale: 1.0,
              maxScale: 2.2,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: widget.image,
              ),
            ),
            Positioned(
              left: 10,
              top: 50,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    shape: BoxShape.circle),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  splashColor: Colors.transparent,
                  splashRadius: 1,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
