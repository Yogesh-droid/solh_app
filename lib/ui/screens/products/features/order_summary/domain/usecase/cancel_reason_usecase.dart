import 'package:solh/core/usecase/usecase.dart';
import 'package:solh/ui/screens/products/core/data_state/product_data_state.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/entity/cancel_reason_entity.dart';
import 'package:solh/ui/screens/products/features/order_summary/domain/repo/cancel_reason_repo.dart';

class CancelReasonUsecase extends Usecase {
  final CancelReasonRepo cancelReasonRepo;

  CancelReasonUsecase({required this.cancelReasonRepo});
  @override
  Future<ProductDataState<CancelReasonEntity>> call(params) async {
    return await cancelReasonRepo.getCancelReasons(params);
  }
}
