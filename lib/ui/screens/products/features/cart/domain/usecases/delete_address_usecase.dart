import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/cart/domain/repo/delete_address_repo.dart';

class DeleteAddressUsecase extends Usecase {
  final DeleteAddressRepo deleteAddressRepo;

  DeleteAddressUsecase({required this.deleteAddressRepo});
  @override
  Future<ProductDataState<Map<String, dynamic>>> call(params) async {
    return await deleteAddressRepo.deleteAddress(params);
  }
}
