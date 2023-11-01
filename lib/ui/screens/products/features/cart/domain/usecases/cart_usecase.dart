import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/cart/domain/entities/cart_entity.dart';
import 'package:solh/ui/screens/products/features/cart/domain/repo/cart_repo.dart';

class CartUsecase extends Usecase {
  final CartRepo cartRepo;

  CartUsecase({required this.cartRepo});
  @override
  Future<ProductDataState<CartEntity>> call(params) async {
    return await cartRepo.getCart(params);
  }
}
