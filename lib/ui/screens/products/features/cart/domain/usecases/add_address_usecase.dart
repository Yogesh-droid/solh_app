import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/cart/domain/repo/add_address_repo.dart';

class AddAddressUsecase extends Usecase {
  final AddAddressRepo addAddressRepo;

  AddAddressUsecase({required this.addAddressRepo});
  @override
  Future<ProductDataState<Map<String, dynamic>>> call(params) async {
    return await addAddressRepo.addAddress(params);
  }
}
