import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/cart/domain/repo/edit_address_repo.dart';

class EditAddressUsecase extends Usecase {
  final EditAddressRepo editAddressRepo;

  EditAddressUsecase({required this.editAddressRepo});

  @override
  Future<ProductDataState<Map<String, dynamic>>> call(params) async {
    return await editAddressRepo.editAddress(params);
  }
}
