// To parse this JSON data, do
//
//     final myOrder = myOrderFromJson(jsonString);

import 'dart:convert';

MyOrder myOrderFromJson(String str) => MyOrder.fromJson(json.decode(str));

String myOrderToJson(MyOrder data) => json.encode(data.toJson());

class MyOrder {
    MyOrder({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory MyOrder.fromJson(Map<String, dynamic> json) => MyOrder(
        status: json["status"],
        statusMsg: json["statusMsg"],
        errorCode: json["errorCode"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusMsg": statusMsg,
        "errorCode": errorCode,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.getOrderSummary,
    });

    List<OrderSummary> getOrderSummary;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        getOrderSummary: List<OrderSummary>.from(json["get-order-Summary "].map((x) => OrderSummary.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "get-order-Summary ": List<dynamic>.from(getOrderSummary.map((x) => x.toJson())),
    };
}

class OrderSummary {
    OrderSummary({
        this.orderId,
        this.orderDate,
        this.orderStatus,
        this.totalItem,
        this.totalAmount,
    });

    String orderId;
    String orderDate;
    String orderStatus;
    String totalItem;
    String totalAmount;

    factory OrderSummary.fromJson(Map<String, dynamic> json) => OrderSummary(
        orderId: json["orderId"],
        orderDate: json["orderDate"],
        orderStatus: json["orderStatus"],
        totalItem: json["totalItem"],
        totalAmount: json["totalAmount"],
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "orderDate": orderDate,
        "orderStatus": orderStatus,
        "totalItem": totalItem,
        "totalAmount": totalAmount,
    };
}
