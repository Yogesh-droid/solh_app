import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/product_mainCat_entity.dart';
import 'package:solh/ui/screens/products/features/home/domain/repo/product_mainCat_repo.dart';

class ProductMainCatUsecase extends Usecase {
  final ProductMainCatRepo productMainCatRepo;

  ProductMainCatUsecase({required this.productMainCatRepo});
  @override
  Future<ProductDataState<List<ProductMainCatEntity>>> call(params) async {
    return await productMainCatRepo.getProductMainCat(params);
  }
}
