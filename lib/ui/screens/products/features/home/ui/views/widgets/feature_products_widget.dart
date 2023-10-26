import 'package:flutter/widgets.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';

class FeatureProductsWidget extends StatelessWidget {
  const FeatureProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetHelpCategory(
          title: "Featured Products",
          onPressed: () {},
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ProductsCard();
          },
        )
      ],
    );
  }
}

class ProductsCard extends StatelessWidget {
  const ProductsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network("https://picsum.photos/200"),
          Text("Ashwagandha || 500mg - 60 caps XXL Nutrition"),
          Text("The traditional Indian herb of Ayurveda"),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [Text("")],
              )
            ],
          )
        ],
      ),
    );
  }
}
