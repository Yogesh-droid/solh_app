import '../../domain/entity/cancel_reason_entity.dart';

class CancelReasonModel extends CancelReasonEntity {
  CancelReasonModel({super.success, super.message, super.reasons});

  factory CancelReasonModel.fromJson(Map<String, dynamic> json) {
    return CancelReasonModel(
        success: json["success"],
        message: json["message"],
        reasons: json["reasons"] == null
            ? null
            : (json["reasons"] as List)
                .map((e) => Reasons.fromJson(e))
                .toList());
  }
}

class Reasons {
  String? id;
  String? reason;

  Reasons({this.id, this.reason});

  Reasons.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    reason = json["reason"];
  }
}
