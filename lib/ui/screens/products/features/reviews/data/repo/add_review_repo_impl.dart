import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/reviews/domain/repo/add_review_repo.dart';

class AddReviewRepoImpl implements AddReviewRepo {
  @override
  Future<ProductDataState<String>> addReview(RequestParams params) async {
    try {
      final Map<String, dynamic> map = await Network.makePostRequestWithToken(
          url: params.url, body: params.body!);
      if (map['success']) {
        return DataSuccess(data: map['message']);
      } else {
        return DataError(exception: map['message'] ?? "Something went wrong");
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
