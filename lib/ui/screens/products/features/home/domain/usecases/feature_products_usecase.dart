import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/feature_product_entity.dart';
import 'package:solh/ui/screens/products/features/home/domain/repo/feature_products_repo.dart';

class FeatureProductsUsecase extends Usecase {
  final FeatureProductsRepo featureProductsRepo;
  FeatureProductsUsecase({required this.featureProductsRepo});

  @override
  Future<ProductDataState<List<FeatureProductsEntity>>> call(params) async {
    return await featureProductsRepo.getFeatureProducts(params);
  }
}
