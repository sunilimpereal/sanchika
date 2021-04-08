// To parse this JSON data, do
//
//     final getCart = getCartFromJson(jsonString);

import 'dart:convert';

GetCart getCartFromJson(String str) => GetCart.fromJson(json.decode(str));

String getCartToJson(GetCart data) => json.encode(data.toJson());

class GetCart {
    GetCart({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetCart.fromJson(Map<String, dynamic> json) => GetCart(
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
        this.getCartList,
    });

    List<CartItem> getCartList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        getCartList: List<CartItem>.from(json["Cart User  Details "].map((x) => CartItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Cart User  Details ": List<dynamic>.from(getCartList.map((x) => x.toJson())),
    };
}

class CartItem {
    CartItem({
        this.productId,
        this.productName,
        this.mrp,
        this.productSellingPrice,
        this.totalAmount,
        this.quantity,
        this.productWeight,
        this.userId,
    });

    String productId;
    String productName;
    double mrp;
    double productSellingPrice;
    String totalAmount;
    int quantity;
    String productWeight;
    int userId;

    factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productId: json["productId"],
        productName: json["productName"],
        mrp: json["mrp"],
        productSellingPrice: json["productSellingPrice"],
        totalAmount: json["totalAmount"],
        quantity: json["quantity"],
        productWeight: json["productWeight"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "mrp": mrp,
        "productSellingPrice": productSellingPrice,
        "totalAmount": totalAmount,
        "quantity": quantity,
        "productWeight": productWeight,
        "userId": userId,
    };
}
