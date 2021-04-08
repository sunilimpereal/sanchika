// To parse this JSON data, do
//
//     final orderDetail = orderDetailFromJson(jsonString);

import 'dart:convert';

OrderDetail orderDetailFromJson(String str) => OrderDetail.fromJson(json.decode(str));

String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
    OrderDetail({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
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
        this.oderCheckOut,
    });

    List<OderCheckOut> oderCheckOut;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        oderCheckOut: List<OderCheckOut>.from(json["OderCheckOut "].map((x) => OderCheckOut.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "OderCheckOut ": List<dynamic>.from(oderCheckOut.map((x) => x.toJson())),
    };
}

class OderCheckOut {
    OderCheckOut({
        this.productName,
        this.productImage,
        this.price,
        this.quantity,
        this.totalAmount,
        this.totalTaxAmount,
        this.discount,
        this.grandTotalAmount,
    });

    String productName;
    dynamic productImage;
    int price;
    String quantity;
    int totalAmount;
    double totalTaxAmount;
    int discount;
    int grandTotalAmount;

    factory OderCheckOut.fromJson(Map<String, dynamic> json) => OderCheckOut(
        productName: json["productName"],
        productImage: json["productImage"],
        price: json["price"],
        quantity: json["quantity"],
        totalAmount: json["totalAmount"],
        totalTaxAmount: json["totalTaxAmount"].toDouble(),
        discount: json["discount"],
        grandTotalAmount: json["grandTotalAmount"],
    );

    Map<String, dynamic> toJson() => {
        "productName": productName,
        "productImage": productImage,
        "price": price,
        "quantity": quantity,
        "totalAmount": totalAmount,
        "totalTaxAmount": totalTaxAmount,
        "discount": discount,
        "grandTotalAmount": grandTotalAmount,
    };
}
