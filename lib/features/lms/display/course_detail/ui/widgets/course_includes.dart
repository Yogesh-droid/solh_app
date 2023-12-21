import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:solh/widgets_constants/constants/colors.dart';

class CourseIncludes extends StatefulWidget {
  const CourseIncludes({super.key, required this.data});
  final String data;

  @override
  State<CourseIncludes> createState() => _CourseIncludesState();
}

class _CourseIncludesState extends State<CourseIncludes> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Html(data: widget.data, shrinkWrap: true, style: {
            "body": Style(
                padding: HtmlPaddings.zero,
                margin: Margins.zero,
                alignment: Alignment.topLeft,
                height: isExpanded ? null : Height(100)),
            "p": Style(
              fontSize: FontSize(12),
            )
          }),
          TextButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              child: Text(
                isExpanded ? "Show Less" : "Show More",
                style: const TextStyle(color: SolhColors.primary_green),
              ))
        ],
      ),
    );
  }
}
