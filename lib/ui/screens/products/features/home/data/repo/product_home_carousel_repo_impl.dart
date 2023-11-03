import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/home/data/models/product_home_carousel_model.dart';
import 'package:solh/ui/screens/products/features/home/domain/entities/product_home_carousel_entity.dart';
import 'package:solh/ui/screens/products/features/home/domain/repo/product_home_carousel_repo.dart';

class ProductHomeCarouselRepoImpl extends ProductHomeCarouselRepo {
  @override
  Future<ProductDataState<List<ProductHomeCarouselEntity>>> getBanners(
      RequestParams params) async {
    try {
      final Map<String, dynamic> response =
          await Network.makeGetRequestWithToken(params.url);
      if (response['success']) {
        final value = HomeProductCarouselModel.fromJson(response);
        print(value);
        return DataSuccess(data: value.banners);
      } else {
        return DataError(
            exception:
                Exception(response['message'] ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: Exception(e.toString()));
    }
  }
}
