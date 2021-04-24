// To parse this JSON data, do
//
//     final getHomeCatgProducts = getHomeCatgProductsFromJson(jsonString);

import 'dart:convert';

import 'package:sanchika/model/product.dart';

GetHomeCatgProducts getHomeCatgProductsFromJson(String str) => GetHomeCatgProducts.fromJson(json.decode(str));

String getHomeCatgProductsToJson(GetHomeCatgProducts data) => json.encode(data.toJson());

class GetHomeCatgProducts {
    GetHomeCatgProducts({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetHomeCatgProducts.fromJson(Map<String, dynamic> json) => GetHomeCatgProducts(
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
        this.getProductList,
    });

    List<Product> getProductList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        getProductList: List<Product>.from(json["get product List"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "get product List": List<dynamic>.from(getProductList.map((x) => x.toJson())),
    };
}
