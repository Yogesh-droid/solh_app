import 'package:get/get.dart';
import 'package:solh/constants/api.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/request_params/request_params.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/entities/filter_entity.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/usecases/filter_usecase.dart';

class FilterController extends GetxController {
  final FilterUsecase filterUsecase;
  var isFilterLoading = false.obs;
  var filters = <FilterEntity>[].obs;
  var error = ''.obs;

  FilterController({required this.filterUsecase});

  Future<void> getFilters({required String id}) async {
    isFilterLoading.value = true;
    try {
      final ProductDataState<List<FilterEntity>> dataState =
          await filterUsecase.call(RequestParams(
              url: "${APIConstants.api}/api/product/sub-category-by-main/$id",
              apiMethods: ApiMethods.get));

      if (dataState.data != null) {
        isFilterLoading.value = false;
        filters.value = dataState.data!;
      } else {
        isFilterLoading.value = false;
        error.value = dataState.exception.toString();
      }
    } on Exception catch (e) {
      isFilterLoading.value = false;
      error.value = e.toString();
    }
  }
}
