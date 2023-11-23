import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/entities/product_sub_cat_entity.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/repo/product_sub_cat_repo.dart';

class ProductSubCatUsecase extends Usecase {
  final ProductSubCatRepo productSubCatRepo;

  ProductSubCatUsecase({required this.productSubCatRepo});
  @override
  Future<ProductDataState<ProductSubCatEntity>> call(params) async {
    return await productSubCatRepo.getProductSubCat(params);
  }
}
