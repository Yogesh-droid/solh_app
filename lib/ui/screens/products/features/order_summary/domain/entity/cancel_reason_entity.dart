import '../../data/model/cancel_reason_model.dart';

class CancelReasonEntity {
  bool? success;
  String? message;
  List<Reasons>? reasons;

  CancelReasonEntity({this.success, this.message, this.reasons});
}
