// To parse this JSON data, do
//
//     final getProductAttribute = getProductAttributeFromJson(jsonString);

import 'dart:convert';

import 'package:sanchika/model/product.dart';

GetProductAttribute getProductAttributeFromJson(String str) => GetProductAttribute.fromJson(json.decode(str));

String getProductAttributeToJson(GetProductAttribute data) => json.encode(data.toJson());

class GetProductAttribute {
    GetProductAttribute({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetProductAttribute.fromJson(Map<String, dynamic> json) => GetProductAttribute(
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



