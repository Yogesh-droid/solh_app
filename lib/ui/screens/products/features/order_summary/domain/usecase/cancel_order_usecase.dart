import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/repo/cancel_order_repo.dart';

class CancelOrderUsecase extends Usecase {
  final CancelOrderRepo cancelOrderRepo;

  CancelOrderUsecase({required this.cancelOrderRepo});
  @override
  Future<ProductDataState<String>> call(params) async {
    return await cancelOrderRepo.cancelOrder(params);
  }
}
