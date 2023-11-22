import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/entity/order_detail_entity.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/repo/order_detail_repo.dart';

class OrderDetailUsecase extends Usecase {
  final OrderDetailRepo orderDetailRepo;

  OrderDetailUsecase({required this.orderDetailRepo});
  @override
  Future<ProductDataState<OrderDetailEntity>> call(params) async {
    return await orderDetailRepo.getOrderDetail(params);
  }
}
