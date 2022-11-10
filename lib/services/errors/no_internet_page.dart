import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({Key? key, required this.onRetry}) : super(key: key);
  final Function() onRetry;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Text('No Internet'),
        SolhGreenButton(
          child: Text('Retry'),
          onPressed: onRetry,
        )
      ],
    ));
  }
}
