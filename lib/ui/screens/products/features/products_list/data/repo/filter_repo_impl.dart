import 'package:solh/services/network/network.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/products_list/data/models/filter_model.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/entities/filter_entity.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/repo/filter_repo.dart';

class FilterRepoImpl implements FilterRepo {
  @override
  Future<ProductDataState<List<FilterEntity>>> getFilters(
      RequestParams params) async {
    try {
      final Map<String, dynamic> map =
          await Network.makeGetRequestWithToken(params.url);
      if (map['success']) {
        final value = FilterModel.fromJson(map);
        return DataSuccess(data: value.subCategory);
      } else {
        return DataError(
            exception: Exception(map['message'] ?? "Something wen wrong"));
      }
    } on Exception catch (e) {
      return DataError(exception: e);
    }
  }
}
