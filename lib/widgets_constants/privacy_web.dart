import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/controllers/profile/profile_controller.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyWeb extends StatefulWidget {
  const PrivacyWeb({Key? key, required this.url, required this.title})
      : super(key: key);
  final String url;
  final String title;

  @override
  State<PrivacyWeb> createState() => _PrivacyWebState();
}

class _PrivacyWebState extends State<PrivacyWeb> {
  int progress = 0;
  final profileController = Get.put(ProfileController());
  late WebViewController controller;

  void setProgress(progress) {
    setState(() {
      this.progress = progress.round();
    });
  }

  @override
  void initState() {
    super.initState();
    // Enable virtual display.

    controller = WebViewController()
      ..loadRequest(Uri.parse(widget.url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {
          setProgress(progress);
        },
      ));
    //if (Platform.isAndroid) WebViewPlatform.instance = SurfaceAndroidView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(
        title: Text(
          widget.title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        isLandingScreen: false,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
