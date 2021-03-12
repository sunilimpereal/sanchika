// To parse this JSON data, do
//
//     final getkilleroffers = getkilleroffersFromJson(jsonString);

import 'dart:convert';

import 'package:sanchika/model/product.dart';

Getkilleroffers getkilleroffersFromJson(String str) => Getkilleroffers.fromJson(json.decode(str));

String getkilleroffersToJson(Getkilleroffers data) => json.encode(data.toJson());

class Getkilleroffers {
    Getkilleroffers({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory Getkilleroffers.fromJson(Map<String, dynamic> json) => Getkilleroffers(
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
        this.killerOffersProductDetailsList,
    });

    List<Product> killerOffersProductDetailsList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        killerOffersProductDetailsList: List<Product>.from(json[" KillerOffers Product Details List"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        " KillerOffers Product Details List": List<dynamic>.from(killerOffersProductDetailsList.map((x) => x.toJson())),
    };
}

