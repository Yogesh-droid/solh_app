import 'package:solh/ui/screens/products/features/order_summary/domain/entity/order_detail_entity.dart';

class OrderDetailModel extends OrderDetailEntity {
  OrderDetailModel(
      {super.success, super.message, super.userOrderDetails, super.otherItems});

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
        success: json["success"],
        message: json["message"],
        userOrderDetails: json["userOrderDetails"] == null
            ? null
            : UserOrderDetails.fromJson(json["userOrderDetails"]),
        otherItems: json["otherItems"] == null
            ? null
            : (json["otherItems"] as List)
                .map((e) => OtherItems.fromJson(e))
                .toList());
  }
}

class OtherItems {
  String? refId;
  String? status;
  String? name;
  String? productId;
  int? salePrice;
  int? originalPrice;
  int? quantity;
  String? image;
  String? expectedDeliveryDate;
  dynamic tracker;
  String? id;

  OtherItems(
      {this.refId,
      this.status,
      this.name,
      this.productId,
      this.salePrice,
      this.originalPrice,
      this.quantity,
      this.image,
      this.expectedDeliveryDate,
      this.tracker,
      this.id});

  OtherItems.fromJson(Map<String, dynamic> json) {
    refId = json["refId"];
    status = json["status"];
    name = json["name"];
    productId = json["product_id"];
    salePrice = json["salePrice"];
    originalPrice = json["originalPrice"];
    quantity = json["quantity"];
    image = json["image"];
    expectedDeliveryDate = json["expectedDeliveryDate"];
    tracker = json["tracker"];
    id = json["_id"];
  }
}

class UserOrderDetails {
  String? id;
  String? transactionId;
  String? user;
  int? shippingCharges;
  int? totalItems;
  int? totalBill;
  String? orderId;
  String? source;
  OrderItems? orderItems;
  ShippingAddress? shippingAddress;
  BillingAddress? billingAddress;
  String? paymentGateway;
  String? currency;
  String? paymentStatus;
  String? createdAt;
  String? updatedAt;
  int? v;

  UserOrderDetails(
      {this.id,
      this.transactionId,
      this.user,
      this.shippingCharges,
      this.totalItems,
      this.totalBill,
      this.orderId,
      this.source,
      this.orderItems,
      this.shippingAddress,
      this.billingAddress,
      this.paymentGateway,
      this.currency,
      this.paymentStatus,
      this.createdAt,
      this.updatedAt,
      this.v});

  UserOrderDetails.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    transactionId = json["transactionId"];
    user = json["user"];
    shippingCharges = json["shippingCharges"];
    totalItems = json["totalItems"];
    totalBill = json["totalBill"];
    orderId = json["orderId"];
    source = json["source"];
    orderItems = json["orderItems"] == null
        ? null
        : OrderItems.fromJson(json["orderItems"]);
    shippingAddress = json["shippingAddress"] == null
        ? null
        : ShippingAddress.fromJson(json["shippingAddress"]);
    billingAddress = json["billingAddress"] == null
        ? null
        : BillingAddress.fromJson(json["billingAddress"]);
    paymentGateway = json["paymentGateway"];
    currency = json["currency"];
    paymentStatus = json["paymentStatus"];
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
    v = json["__v"];
  }
}

class BillingAddress {
  String? fullName;
  String? phoneNumber;
  String? buildingName;
  String? street;
  String? city;
  String? state;
  String? postalCode;
  String? landmark;
  String? country;

  BillingAddress(
      {this.fullName,
      this.phoneNumber,
      this.buildingName,
      this.street,
      this.city,
      this.state,
      this.postalCode,
      this.landmark,
      this.country});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    fullName = json["fullName"];
    phoneNumber = json["phoneNumber"];
    buildingName = json["buildingName"];
    street = json["street"];
    city = json["city"];
    state = json["state"];
    postalCode = json["postalCode"];
    landmark = json["landmark"];
    country = json["country"];
  }
}

class ShippingAddress {
  String? fullName;
  String? phoneNumber;
  String? buildingName;
  String? street;
  String? city;
  String? state;
  String? postalCode;
  String? landmark;
  String? country;

  ShippingAddress(
      {this.fullName,
      this.phoneNumber,
      this.buildingName,
      this.street,
      this.city,
      this.state,
      this.postalCode,
      this.landmark,
      this.country});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    fullName = json["fullName"];
    phoneNumber = json["phoneNumber"];
    buildingName = json["buildingName"];
    street = json["street"];
    city = json["city"];
    state = json["state"];
    postalCode = json["postalCode"];
    landmark = json["landmark"];
    country = json["country"];
  }
}

class OrderItems {
  String? refId;
  String? status;
  String? name;
  String? productId;
  int? salePrice;
  int? originalPrice;
  int? quantity;
  String? image;
  String? expectedDeliveryDate;
  List<Tracker>? tracker;
  String? id;

  OrderItems(
      {this.refId,
      this.status,
      this.name,
      this.productId,
      this.salePrice,
      this.originalPrice,
      this.quantity,
      this.image,
      this.expectedDeliveryDate,
      this.tracker,
      this.id});

  OrderItems.fromJson(Map<String, dynamic> json) {
    refId = json["refId"];
    status = json["status"];
    name = json["name"];
    productId = json["product_id"];
    salePrice = json["salePrice"];
    originalPrice = json["originalPrice"];
    quantity = json["quantity"];
    image = json["image"];
    expectedDeliveryDate = json["expectedDeliveryDate"];
    tracker = json["tracker"] == null
        ? null
        : (json["tracker"] as List).map((e) => Tracker.fromJson(e)).toList();
    id = json["_id"];
  }
}

class Tracker {
  dynamic reason;
  String? createdBy;
  String? createdType;
  String? status;
  bool? isShow;
  String? createdAt;
  String? id;

  Tracker(
      {this.reason,
      this.createdBy,
      this.createdType,
      this.status,
      this.isShow,
      this.createdAt,
      this.id});

  Tracker.fromJson(Map<String, dynamic> json) {
    reason = json["reason"];
    createdBy = json["createdBy"];
    createdType = json["createdType"];
    status = json["status"];
    isShow = json["isShow"];
    createdAt = json["createdAt"];
    id = json["_id"];
  }
}
