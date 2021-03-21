// To parse this JSON data, do
//
//     final getAddress = getAddressFromJson(jsonString);

import 'dart:convert';

GetAddress getAddressFromJson(String str) => GetAddress.fromJson(json.decode(str));

String getAddressToJson(GetAddress data) => json.encode(data.toJson());

class GetAddress {
    GetAddress({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetAddress.fromJson(Map<String, dynamic> json) => GetAddress(
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
        this.createOnAcount,
    });

    Address createOnAcount;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        createOnAcount: Address.fromJson(json["Create on acount"]),
    );

    Map<String, dynamic> toJson() => {
        "Create on acount": createOnAcount.toJson(),
    };
}

class Address {
    Address({
        this.asd1,
        this.pin1,
        this.city1,
        this.state1,
    });

    String asd1;
    String pin1;
    String city1;
    String state1;

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        asd1: json["asd1"],
        pin1: json["pin1"],
        city1: json["city1"],
        state1: json["state1"],
    );

    Map<String, dynamic> toJson() => {
        "asd1": asd1,
        "pin1": pin1,
        "city1": city1,
        "state1": state1,
    };
}
