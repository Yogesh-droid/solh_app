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
        userOrderList!.add(UserOrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (userOrderList != null) {
      data['userOrderList'] = userOrderList!.map((v) => v.toJson()).toList();
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
        ? OrderItems.fromJson(json['orderItems'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['orderId'] = orderId;
    if (orderItems != null) {
      data['orderItems'] = orderItems!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['name'] = name;
    data['salePrice'] = salePrice;
    data['originalPrice'] = originalPrice;
    data['quantity'] = quantity;
    data['image'] = image;
    data['expectedDeliveryDate'] = expectedDeliveryDate;
    data['refId'] = refId;
    return data;
  }
}
