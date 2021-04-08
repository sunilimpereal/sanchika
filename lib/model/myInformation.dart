// To parse this JSON data, do
//
//     final myInformation = myInformationFromJson(jsonString);

import 'dart:convert';

MyInformation myInformationFromJson(String str) => MyInformation.fromJson(json.decode(str));

String myInformationToJson(MyInformation data) => json.encode(data.toJson());

class MyInformation {
    MyInformation({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory MyInformation.fromJson(Map<String, dynamic> json) => MyInformation(
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
        this.myInformation,
    });

    MyInformationClass myInformation;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        myInformation: MyInformationClass.fromJson(json["My Information "]),
    );

    Map<String, dynamic> toJson() => {
        "My Information ": myInformation.toJson(),
    };
}

class MyInformationClass {
    MyInformationClass({
        this.firstName,
        this.lastName,
        this.email,
        this.mobile,
        this.dob,
        this.gender,
    });

    String firstName;
    String lastName;
    String email;
    dynamic mobile;
    dynamic dob;
    dynamic gender;

    factory MyInformationClass.fromJson(Map<String, dynamic> json) => MyInformationClass(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        mobile: json["mobile"],
        dob: json["dob"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "mobile": mobile,
        "dob": dob,
        "gender": gender,
    };
}
