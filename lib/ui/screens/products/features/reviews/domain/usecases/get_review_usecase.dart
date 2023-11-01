import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/reviews/domain/entities/get_review_entity.dart';
import 'package:solh/ui/screens/products/features/reviews/domain/repo/get_reviews_repo.dart';

class GetReviewsUsecase extends Usecase {
  final GetReviewsRepo getReviewsRepo;

  GetReviewsUsecase({required this.getReviewsRepo});
  @override
  Future<ProductDataState<GetReviewEntity>> call(params) async {
    return await getReviewsRepo.getReviews(params);
  }
}
