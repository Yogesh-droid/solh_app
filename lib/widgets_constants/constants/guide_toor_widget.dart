import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';

class GuideToorWidget extends StatelessWidget {
  const GuideToorWidget(
      {super.key,
      required this.child,
      required this.id,
      required this.icon,
      required this.title,
      required this.description,
      this.contentLocation});
  final Widget child;
  final String id;
  final Widget icon;
  final String title;
  final String description;
  final ContentLocation? contentLocation;

  @override
  Widget build(BuildContext context) {
    return DescribedFeatureOverlay(
      featureId: id,
      tapTarget: SizedBox(
        height: 50,
        width: 50,
        child: icon,
      ),
      backgroundDismissible: false,
      allowShowingDuplicate: false,
      barrierDismissible: false,
      contentLocation: contentLocation ?? ContentLocation.trivial,
      overflowMode: OverflowMode.wrapBackground,
      title: Text(title),
      description: Column(
        children: [
          Text(description),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    FeatureDiscovery.completeCurrentStep(context);
                  },
                  child: Text('Next',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))),
              SizedBox(width: 50),
              TextButton(
                  onPressed: () {
                    FeatureDiscovery.dismissAll(context);
                  },
                  child: Text('Skip',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)))
            ],
          ),
        ],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      targetColor: Colors.white,
      textColor: Colors.white,
      child: child,
    );
  }
}
