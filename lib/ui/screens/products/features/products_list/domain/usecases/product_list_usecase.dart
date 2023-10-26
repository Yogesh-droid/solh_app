import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/entities/product_list_entity.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/repo/product_list_repo.dart';

class ProductListUsecase extends Usecase {
  final ProductListRepo productListRepo;

  ProductListUsecase({required this.productListRepo});
  @override
  Future<ProductDataState<ProductListEntity>> call(params) async {
    return await productListRepo.getProductList(params);
  }
}
