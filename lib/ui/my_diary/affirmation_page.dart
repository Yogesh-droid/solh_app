import 'package:flutter/material.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class AffirmationPage extends StatelessWidget {
  AffirmationPage({Key? key}) : super(key: key);

  final List<String> SolhAffirmationList = [
    '“Instead of worrying about what you not...0',
    '“Be the reason someone smiles. Be the..',
    '“Be mindful. Be grateful. Be positive. Be true.Be kind.”'
  ];
  final List<String> AddedAffirmationList = [
    '“Instead of worrying about what you not...',
    '“Instead of worrying about what you not...',
    '“Instead of worrying about what you not...”'
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: TabBar(
                indicatorColor: SolhColors.primary_green,
                unselectedLabelColor: SolhColors.grey,
                labelColor: SolhColors.primary_green,
                tabs: [
                  Tab(
                    text: 'Solh',
                  ),
                  Tab(
                    text: 'Added',
                  ),
                ]),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: SolhAffirmationList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(SolhAffirmationList[index]),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: SolhColors.grey_2, size: 16),
                  );
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: AddedAffirmationList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(AddedAffirmationList[index]),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: SolhColors.grey_2, size: 16),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
