import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/product_category_entity.dart';
import 'package:solh/ui/screens/products/features/home/domain/repo/product_category_repo.dart';

class ProductsCategoryUsecase extends Usecase {
  final ProductCategoryRepo productCategoryRepo;

  ProductsCategoryUsecase({required this.productCategoryRepo});
  @override
  Future<ProductDataState<List<ProductCategoryEntity>>> call(params) async {
    return await productCategoryRepo.getProductCategory(params);
  }
}
