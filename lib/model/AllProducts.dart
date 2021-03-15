// To parse this JSON data, do
//
//     final getAllProducts = getAllProductsFromJson(jsonString);

import 'dart:convert';

import 'package:sanchika/model/product.dart';

GetAllProducts getAllProductsFromJson(String str) => GetAllProducts.fromJson(json.decode(str));

String getAllProductsToJson(GetAllProducts data) => json.encode(data.toJson());

class GetAllProducts {
    GetAllProducts({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetAllProducts.fromJson(Map<String, dynamic> json) => GetAllProducts(
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
        this.productDetailsList,
    });

    List<Product> productDetailsList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        productDetailsList: List<Product>.from(json["Product Details List"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Product Details List": List<dynamic>.from(productDetailsList.map((x) => x.toJson())),
    };
}

