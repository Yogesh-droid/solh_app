import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/reviews/domain/entities/get_review_entity.dart';
import 'package:solh/ui/screens/products/features/reviews/domain/usecases/get_review_usecase.dart';

class GetReviewsController extends GetxController {
  final GetReviewsUsecase getReviewsUsecase;
  var reviewsLoading = false.obs;
  var reviewsEntity = GetReviewEntity().obs;
  var error = ''.obs;
  bool isListEnd = false;

  GetReviewsController({required this.getReviewsUsecase});

  Future<void> getAllReviews(
      {required String productId, required int page, int? limit = 10}) async {
    try {
      reviewsLoading.value = true;
      final ProductDataState<GetReviewEntity> dataState =
          await getReviewsUsecase.call(RequestParams(
              url:
                  "${APIConstants.api}/api/product/get-product-reviews?productId=$productId&page=$page&limit=$limit"));

      if (dataState.data != null) {
        reviewsEntity.value = dataState.data!;
        isListEnd = reviewsEntity.value.pages!.next == null;
        reviewsLoading.value = false;
      } else {
        reviewsLoading.value = false;
        error.value = dataState.exception.toString();
      }
    } on Exception catch (e) {
      reviewsLoading.value = false;
      error.value = e.toString();
    }
  }
}
