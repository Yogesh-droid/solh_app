import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/reviews/data/models/get_review_model.dart';
import 'package:solh/ui/screens/products/features/reviews/domain/entities/get_review_entity.dart';
import 'package:solh/ui/screens/products/features/reviews/domain/repo/get_reviews_repo.dart';

class GetReviewsRepoImpl implements GetReviewsRepo {
  @override
  Future<ProductDataState<GetReviewEntity>> getReviews(
      RequestParams params) async {
    try {
      final Map<String, dynamic> map =
          await Network.makeGetRequestWithToken(params.url);

      if (map['success']) {
        final value = GetReviewModel.fromJson(map);
        return DataSuccess(data: value);
      } else {
        return DataError(
            exception: Exception(map['message'] ?? "something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
