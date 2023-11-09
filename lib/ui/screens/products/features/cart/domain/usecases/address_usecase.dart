import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/cart/domain/entities/address_entity.dart';
import 'package:solh/ui/screens/products/features/cart/domain/repo/address_repo.dart';

class AddressUsecase extends Usecase {
  final AddressRepo addressRepo;

  AddressUsecase({required this.addressRepo});
  @override
  Future<ProductDataState<AddressEntity>> call(params) async {
    return await addressRepo.getAddressList(params);
  }
}
