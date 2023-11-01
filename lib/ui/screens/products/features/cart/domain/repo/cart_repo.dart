import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/cart/domain/entities/cart_entity.dart';

abstract class CartRepo {
  Future<ProductDataState<CartEntity>> getCart(RequestParams params);
}
