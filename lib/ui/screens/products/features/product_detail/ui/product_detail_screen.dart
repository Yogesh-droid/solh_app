import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GetProductDeatilAppBar(),
      body: ListView(
        children: [GetProductStatsAndImage()],
      ),
    );
  }
}

class GetProductStatsAndImage extends StatelessWidget {
  const GetProductStatsAndImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network("https://picsum.photos/200"),
      ],
    );
  }
}

class GetProductDeatilAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const GetProductDeatilAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          size: 30,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      backgroundColor: SolhColors.white,
      iconTheme: IconThemeData(color: SolhColors.black),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Icon(
            CupertinoIcons.heart_fill,
            color: SolhColors.Grey_1,
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0, 50);
}
