import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solh/ui/screens/get-help/view-all/allied_consultants.dart';
import 'package:solh/ui/screens/get-help/view-all/consultants.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';

class ConsultantAlliedParent extends StatefulWidget {
  ConsultantAlliedParent({Key? key, Map<dynamic, dynamic>? args})
      : type = args!['type'],
        slug = args['slug'],
        id = args["id"],
        enableAppbar = args['enableAppbar'],
        super(key: key);

  final String slug;
  final String? type;
  final String? id;
  final bool? enableAppbar;

  @override
  State<ConsultantAlliedParent> createState() => _ConsultantAlliedParentState();
}

class _ConsultantAlliedParentState extends State<ConsultantAlliedParent>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SolhAppBar(title: Text(''), isLandingScreen: false),
      body: Column(mainAxisSize: MainAxisSize.min, children: [
        TabBar(
            indicatorColor: SolhColors.primary_green,
            controller: _tabController,
            tabs: [
              Tab(
                child: Text(
                  'Clinician'.tr,
                  style: SolhTextStyles.CTA,
                ),
              ),
              Tab(
                child: Text(
                  'Allied Therapy'.tr,
                  style: SolhTextStyles.CTA,
                ),
              )
            ]),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            ConsultantsScreen(
              args: {
                "type": widget.type,
                "slug": widget.slug,
                "enableAppbar": widget.enableAppbar,
              },
            ),
            AlliedConsultant(
              args: {
                "type": widget.type,
                "id": widget.id,
                "enableAppbar": widget.enableAppbar,
              },
            )
          ]),
        )
      ]),
    );
  }
}
