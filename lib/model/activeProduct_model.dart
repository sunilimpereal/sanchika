// To parse this JSON data, do
//
//     final getActiveProduct = getActiveProductFromJson(jsonString);

import 'dart:convert';

import 'package:sanchika/model/product.dart';

GetActiveProduct getActiveProductFromJson(String str) => GetActiveProduct.fromJson(json.decode(str));

String getActiveProductToJson(GetActiveProduct data) => json.encode(data.toJson());

class GetActiveProduct {
    GetActiveProduct({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetActiveProduct.fromJson(Map<String, dynamic> json) => GetActiveProduct(
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
        this.activeProductDetailsList,
    });

    List<Product> activeProductDetailsList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        activeProductDetailsList: List<Product>.from(json[" Active Product Details List"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        " Active Product Details List": List<dynamic>.from(activeProductDetailsList.map((x) => x.toJson())),
    };
}

