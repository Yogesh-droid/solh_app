import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/cart/domain/repo/add_to_cart_repo.dart';

class AddToCartUsecase extends Usecase {
  final AddToCartRepo addToCartRepo;

  AddToCartUsecase({required this.addToCartRepo});
  @override
  Future<ProductDataState<String>> call(params) async {
    return await addToCartRepo.addToCart(params);
  }
}
