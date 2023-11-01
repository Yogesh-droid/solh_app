import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/entities/filter_entity.dart';
import 'package:solh/ui/screens/products/features/products_list/domain/repo/filter_repo.dart';

class FilterUsecase extends Usecase {
  final FilterRepo filterRepo;

  FilterUsecase({required this.filterRepo});
  @override
  Future<ProductDataState<List<FilterEntity>>> call(params) async {
    return await filterRepo.getFilters(params);
  }
}
