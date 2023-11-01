import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/reviews/domain/repo/add_review_repo.dart';

class AddReviewUsecase extends Usecase {
  final AddReviewRepo addReviewRepo;

  AddReviewUsecase({required this.addReviewRepo});
  @override
  Future<ProductDataState<String>> call(params) async {
    return addReviewRepo.addReview(params);
  }
}
