// To parse this JSON data, do
//
//     final getShippingDetail = getShippingDetailFromJson(jsonString);

import 'dart:convert';

GetShippingDetail getShippingDetailFromJson(String str) => GetShippingDetail.fromJson(json.decode(str));

String getShippingDetailToJson(GetShippingDetail data) => json.encode(data.toJson());

class GetShippingDetail {
    GetShippingDetail({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetShippingDetail.fromJson(Map<String, dynamic> json) => GetShippingDetail(
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
        this.shippingAddress,
    });

    ShippingAddress shippingAddress;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        shippingAddress: ShippingAddress.fromJson(json["Shipping Address"]),
    );

    Map<String, dynamic> toJson() => {
        "Shipping Address": shippingAddress.toJson(),
    };
}

class ShippingAddress {
    ShippingAddress({
        this.firstName,
        this.lastName,
        this.email,
        this.mobile,
        this.dob,
        this.gender,
        this.asd1,
        this.asd2,
        this.pin1,
        this.pin2,
        this.city1,
        this.city2,
        this.state1,
        this.state2,
        this.qualification,
        this.occupation,
        this.updateDate,
        this.userEmail,
        this.companyName,
        this.companyCode,
        this.customerCode,
        this.customerId,
        this.storeCode,
        this.userId,
        this.usrCtGrp,
    });

    String firstName;
    String lastName;
    String email;
    String mobile;
    String dob;
    String gender;
    String asd1;
    String asd2;
    String pin1;
    String pin2;
    String city1;
    String city2;
    String state1;
    String state2;
    String qualification;
    String occupation;
    String updateDate;
    String userEmail;
    String companyName;
    String companyCode;
    String customerCode;
    String customerId;
    String storeCode;
    int userId;
    String usrCtGrp;

    factory ShippingAddress.fromJson(Map<String, dynamic> json) => ShippingAddress(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        mobile: json["mobile"],
        dob: json["dob"],
        gender: json["gender"],
        asd1: json["asd1"],
        asd2: json["asd2"],
        pin1: json["pin1"],
        pin2: json["pin2"],
        city1: json["city1"],
        city2: json["city2"],
        state1: json["state1"],
        state2: json["state2"],
        qualification: json["qualification"],
        occupation: json["occupation"],
        updateDate: json["updateDate"],
        userEmail: json["userEmail"],
        companyName: json["companyName"],
        companyCode: json["companyCode"],
        customerCode: json["customerCode"],
        customerId: json["customerId"],
        storeCode: json["storeCode"],
        userId: json["userId"],
        usrCtGrp: json["usrCtGrp"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "mobile": mobile,
        "dob": dob,
        "gender": gender,
        "asd1": asd1,
        "asd2": asd2,
        "pin1": pin1,
        "pin2": pin2,
        "city1": city1,
        "city2": city2,
        "state1": state1,
        "state2": state2,
        "qualification": qualification,
        "occupation": occupation,
        "updateDate": updateDate,
        "userEmail": userEmail,
        "companyName": companyName,
        "companyCode": companyCode,
        "customerCode": customerCode,
        "customerId": customerId,
        "storeCode": storeCode,
        "userId": userId,
        "usrCtGrp": usrCtGrp,
    };
}
