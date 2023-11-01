import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';

abstract class AddReviewRepo {
  Future<ProductDataState<String>> addReview(RequestParams params);
}
