import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/features/product_detail/data/model/product_details_model.dart';
import 'package:solh/ui/screens/products/features/product_detail/domain/entities/product_detail_entity.dart';
import 'package:solh/ui/screens/products/features/product_detail/domain/repo/product_detail_repo.dart';

class ProductDetailUsecase extends Usecase {
  final ProductDetailRepo productDetailRepo;

  ProductDetailUsecase({required this.productDetailRepo});
  @override
  Future<ProductDataState<ProductDetailsModel>> call(params) async {
    return await productDetailRepo.getProductDetail(params);
  }
}
