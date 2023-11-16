import 'package:solh/ui/screens/products/features/order_summary/domain/entity/user_order_list_entity.dart';

class OrderListModel {
  bool? success;
  String? message;
  List<UserOrderList>? userOrderList;

  OrderListModel({this.success, this.message, this.userOrderList});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['userOrderList'] != null) {
      userOrderList = <UserOrderList>[];
      json['userOrderList'].forEach((v) {
        userOrderList!.add(new UserOrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.userOrderList != null) {
      data['userOrderList'] =
          this.userOrderList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserOrderList {
  String? sId;
  String? orderId;
  OrderItems? orderItems;

  UserOrderList({this.sId, this.orderId, this.orderItems});

  UserOrderList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    orderId = json['orderId'];
    orderItems = json['orderItems'] != null
        ? new OrderItems.fromJson(json['orderItems'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['orderId'] = this.orderId;
    if (this.orderItems != null) {
      data['orderItems'] = this.orderItems!.toJson();
    }
    return data;
  }
}

class OrderItems {
  String? status;
  String? name;
  int? salePrice;
  int? originalPrice;
  int? quantity;
  String? image;
  String? expectedDeliveryDate;
  String? refId;

  OrderItems(
      {this.status,
      this.name,
      this.salePrice,
      this.originalPrice,
      this.quantity,
      this.image,
      this.expectedDeliveryDate,
      this.refId});

  OrderItems.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    name = json['name'];
    salePrice = json['salePrice'];
    originalPrice = json['originalPrice'];
    quantity = json['quantity'];
    image = json['image'];
    expectedDeliveryDate = json['expectedDeliveryDate'];
    refId = json['refId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['name'] = this.name;
    data['salePrice'] = this.salePrice;
    data['originalPrice'] = this.originalPrice;
    data['quantity'] = this.quantity;
    data['image'] = this.image;
    data['expectedDeliveryDate'] = this.expectedDeliveryDate;
    data['refId'] = this.refId;
    return data;
  }
}
