import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/order_summary/data/model/order_list_model.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/repo/get_order_list_repo.dart';

class OrderListUsecase extends Usecase {
  final GetOrderListRepo getOrderListRepo;
  OrderListUsecase({required this.getOrderListRepo});
  @override
  Future<ProductDataState<OrderListModel>> call(params) async {
    return await getOrderListRepo.getOrderList(params);
  }
}
