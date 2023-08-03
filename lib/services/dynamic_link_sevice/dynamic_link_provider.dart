import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkProvider {
  DynamicLinkProvider._();

  static final instance = DynamicLinkProvider._();

  final String _uriPrefix = "https://solh.page.link";

  final String _packageName = "com.solh.app";

  Future<String> createLinkForProvider({String providerId = "123456"}) async {
    final String url = "https://solh.com/prvider?provider=12345";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        link: Uri.parse(url),
        uriPrefix: _uriPrefix,
        androidParameters:
            AndroidParameters(packageName: _packageName, minimumVersion: 7),
        iosParameters: IOSParameters(bundleId: _packageName));

    final FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;

    final reflink = await link.buildShortLink(parameters);

    return reflink.shortUrl.toString();
  }

  Future<void> initDynamicLink() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();

    if (instanceLink != null) {
      final Uri reflink = instanceLink.link;

      log("${reflink.queryParameters}", name: "dynamic queryprams");
      log("${reflink.path}", name: "dynamic path");
    }
  }
}
