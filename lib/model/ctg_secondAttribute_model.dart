// To parse this JSON data, do
//
//     final getCtgAttributeSecondOrder = getCtgAttributeSecondOrderFromJson(jsonString);

import 'dart:convert';

import 'package:sanchika/model/CtgAttribute.dart';

GetCtgAttributeSecondOrder getCtgAttributeSecondOrderFromJson(String str) => GetCtgAttributeSecondOrder.fromJson(json.decode(str));

String getCtgAttributeSecondOrderToJson(GetCtgAttributeSecondOrder data) => json.encode(data.toJson());

class GetCtgAttributeSecondOrder {
    GetCtgAttributeSecondOrder({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetCtgAttributeSecondOrder.fromJson(Map<String, dynamic> json) => GetCtgAttributeSecondOrder(
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
        this.getCategoryAttributeList,
    });

    List<CategoryAttribute> getCategoryAttributeList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        getCategoryAttributeList: List<CategoryAttribute>.from(json["get category Attribute List"].map((x) => CategoryAttribute.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "get category Attribute List": List<dynamic>.from(getCategoryAttributeList.map((x) => x.toJson())),
    };
}


