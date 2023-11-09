import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/cart/domain/entities/address_entity.dart';

abstract class AddressRepo {
  Future<ProductDataState<AddressEntity>> getAddressList(RequestParams params);
}
