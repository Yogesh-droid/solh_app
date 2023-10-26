import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/entities/featuredProduct_list_entity.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/repo/feaured_product_list_repo.dart';

class FeaturedProductsListUsecase extends Usecase {
  final FeaturedProductListRepo featuredProductListRepo;

  FeaturedProductsListUsecase({required this.featuredProductListRepo});
  @override
  Future<ProductDataState<FeaturedProductListEntity>> call(params) async {
    return featuredProductListRepo.getFeaturedProducts(params);
  }
}
