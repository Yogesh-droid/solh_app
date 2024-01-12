import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:solh/features/lms/display/my_course_details/ui/controllers/add_course_review_controller.dart';
import 'package:solh/services/utility.dart';
import 'package:solh/ui/screens/get-help/get-help.dart';
import 'package:solh/widgets_constants/appbars/app-bar.dart';
import 'package:solh/widgets_constants/buttons/custom_buttons.dart';
import 'package:solh/widgets_constants/constants/colors.dart';
import 'package:solh/widgets_constants/constants/textstyles.dart';
import 'package:solh/widgets_constants/loader/my-loader.dart';

class AddReviewPage extends StatelessWidget {
  const AddReviewPage({super.key, required this.args});
  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    final AddCourseReviewController addReviewController = Get.find();
    addReviewController.selectedRating.value = 0;
    final TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: SolhAppBar(
          title: const Text("Add Review", style: SolhTextStyles.QS_body_semi_1),
          isLandingScreen: false,
          isVideoCallScreen: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rate This Course',
                  style: SolhTextStyles.QS_body_1_bold.copyWith(
                      color: SolhColors.black),
                ),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              addReviewController.selectedRating(index + 1);
                            },
                            child: Obx(
                              () => index <
                                      addReviewController.selectedRating.value
                                  ? const Icon(
                                      Icons.star,
                                      color: SolhColors.primaryRed,
                                    )
                                  : const Icon(Icons.star_border_outlined),
                            ));
                      }),
                )
              ],
            ),
          ),
          const GetHelpDivider(),
          Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "Add Your Comment",
                style: SolhTextStyles.QS_body_1_bold.copyWith(
                    color: SolhColors.black),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4))),
              maxLength: 400,
              maxLines: 5,
              buildCounter: (context,
                  {required currentLength, required isFocused, maxLength}) {
                return Text(
                    "${maxLength! - currentLength} Character Remaining");
              },
              cursorColor: SolhColors.Grey_1,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SolhGreenButton(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Obx(() => addReviewController.isSubmittingReview.value
                  ? const SolhGradientLoader(
                      strokeWidth: 2,
                      radius: 15,
                    )
                  : Text("Submit",
                      style: SolhTextStyles.CTA.copyWith(color: Colors.white))),
              onPressed: () async {
                if (addReviewController.selectedRating.value == 0) {
                  Utility.showToast("Please choose star rating");
                } else {
                  await addReviewController.submitReview(
                      courseId: args["courseId"],
                      rating: addReviewController.selectedRating.value,
                      review: textEditingController.text);
                  if (addReviewController.error.value.isEmpty) {
                    Utility.showToast(addReviewController.error.value);
                  } else {
                    Utility.showToast(addReviewController.msg.value);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
