// To parse this JSON data, do
//
//     final getCtgAttribute = getCtgAttributeFromJson(jsonString);

import 'dart:convert';

GetCtgAttribute getCtgAttributeFromJson(String str) => GetCtgAttribute.fromJson(json.decode(str));

String getCtgAttributeToJson(GetCtgAttribute data) => json.encode(data.toJson());

class GetCtgAttribute {
    GetCtgAttribute({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetCtgAttribute.fromJson(Map<String, dynamic> json) => GetCtgAttribute(
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

class CategoryAttribute {
    CategoryAttribute({
        this.categoryId,
        this.categoryValue,
    });

    String categoryId;
    String categoryValue;

    factory CategoryAttribute.fromJson(Map<String, dynamic> json) => CategoryAttribute(
        categoryId: json["categoryId"],
        categoryValue: json["categoryValue"],
    );

    Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "categoryValue": categoryValue,
    };
}
