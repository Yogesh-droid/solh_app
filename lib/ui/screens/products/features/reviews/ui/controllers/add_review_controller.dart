import 'package:get/get.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/reviews/domain/usecases/add_review_usecase.dart';

import '../../../../../../../constants/api.dart';

class AddReviewController extends GetxController {
  final AddReviewUsecase addReviewUsecase;
  var msg = ''.obs;
  var isSubmittingReview = false.obs;
  var error = ''.obs;

  AddReviewController({required this.addReviewUsecase});

  Future<void> submitReview(
      {required String productId, String? review, required int rating}) async {
    try {
      isSubmittingReview.value = true;
      final ProductDataState<String> dataState = await addReviewUsecase.call(
          RequestParams(
              url: "${APIConstants.api}/api/product/submit-review",
              apiMethods: ApiMethods.post,
              body: {
            "productId": productId,
            "review": review,
            "rating": rating
          }));
      if (dataState.data != null) {
        msg.value = dataState.data!;
      } else {
        error.value = dataState.exception.toString();
      }
    } on Exception catch (e) {
      error.value = e.toString();
    }
  }
}
