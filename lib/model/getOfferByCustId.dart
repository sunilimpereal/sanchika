// To parse this JSON data, do
//
//     final getOffersByCustCtg = getOffersByCustCtgFromJson(jsonString);

import 'dart:convert';

GetOffersByCustCtg getOffersByCustCtgFromJson(String str) => GetOffersByCustCtg.fromJson(json.decode(str));

String getOffersByCustCtgToJson(GetOffersByCustCtg data) => json.encode(data.toJson());

class GetOffersByCustCtg {
    GetOffersByCustCtg({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetOffersByCustCtg.fromJson(Map<String, dynamic> json) => GetOffersByCustCtg(
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
        this.getOffer,
    });

    List<OfferItem> getOffer;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        getOffer: List<OfferItem>.from(json["get offer "].map((x) => OfferItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "get offer ": List<dynamic>.from(getOffer.map((x) => x.toJson())),
    };
}

class OfferItem {
    OfferItem({
        this.id,
        this.companyCode,
        this.customerCategoryId,
        this.endDate,
        this.productId,
        this.price,
        this.priority,
        this.productQuantity,
        this.startDate,
        this.status,
        this.startTime,
        this.endTime,
        this.offerType,
        this.offerValue,
        this.salesQuantity,
        this.freeQuantity,
        this.synvDateTime,
    });

    int id;
    String companyCode;
    String customerCategoryId;
    String endDate;
    String productId;
    String price;
    dynamic priority;
    String productQuantity;
    String startDate;
    bool status;
    dynamic startTime;
    dynamic endTime;
    String offerType;
    int offerValue;
    String salesQuantity;
    String freeQuantity;
    DateTime synvDateTime;

    factory OfferItem.fromJson(Map<String, dynamic> json) => OfferItem(
        id: json["id"],
        companyCode: json["companyCode"],
        customerCategoryId: json["customerCategoryId"],
        endDate: json["endDate"],
        productId: json["productId"],
        price: json["price"] == null ? null : json["price"],
        priority: json["priority"],
        productQuantity: json["productQuantity"] == null ? null : json["productQuantity"],
        startDate: json["startDate"],
        status: json["status"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        offerType: json["offerType"] == null ? null : json["offerType"],
        offerValue: json["offerValue"] == null ? null : json["offerValue"],
        salesQuantity: json["salesQuantity"] == null ? null : json["salesQuantity"],
        freeQuantity: json["freeQuantity"] == null ? null : json["freeQuantity"],
        synvDateTime: DateTime.parse(json["synvDateTime"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "companyCode": companyCode,
        "customerCategoryId": customerCategoryId,
        "endDate": endDate,
        "productId": productId,
        "price": price == null ? null : price,
        "priority": priority,
        "productQuantity": productQuantity == null ? null : productQuantity,
        "startDate": startDate,
        "status": status,
        "startTime": startTime,
        "endTime": endTime,
        "offerType": offerType == null ? null : offerType,
        "offerValue": offerValue == null ? null : offerValue,
        "salesQuantity": salesQuantity == null ? null : salesQuantity,
        "freeQuantity": freeQuantity == null ? null : freeQuantity,
        "synvDateTime": synvDateTime.toIso8601String(),
    };
}
