import 'package:solh/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/reviews/domain/entities/get_review_entity.dart';

abstract class GetReviewsRepo {
  Future<ProductDataState<GetReviewEntity>> getReviews(RequestParams params);
}
