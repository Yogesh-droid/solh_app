import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/product_category_entity.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/product_home_carousel_entity.dart';
import 'package:solh/ui/screens/products/features/home/domain/repo/product_home_carousel_repo.dart';

class ProductsHomeCarouselUsecase extends Usecase {
  final ProductHomeCarouselRepo productHomeCarouselRepo;

  ProductsHomeCarouselUsecase({required this.productHomeCarouselRepo});
  @override
  Future<ProductDataState<List<ProductHomeCarouselEntity>>> call(params) async {
    return await productHomeCarouselRepo.getBanners(params);
  }
}
