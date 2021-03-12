// To parse this JSON data, do
//
//final registerResponseModel = registerResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterResponseModel registerResponseModelFromJson(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

String registerResponseModelToJson(RegisterResponseModel data) =>
    json.encode(data.toJson());

class RegisterResponseModel {
  RegisterResponseModel({
    this.status,
    this.statusMsg,
    this.errorCode,
    this.data,
  });

  String status;
  String statusMsg;
  dynamic errorCode;
  Data data;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
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
    this.registration,
  });

  String registration;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        registration: json["Registration"],
      );

  Map<String, dynamic> toJson() => {
        "Registration": registration,
      };
}

class RegisterRequestModel {
  String firstName;
  String lastname;
  String email;
  String password;
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
  String description;

  RegisterRequestModel({
    this.firstName,
    this.lastname,
    this.email,
    this.password,
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
    this.description,
  });
  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      RegisterRequestModel(
        email: "email",
        password: "password",
        mobile: "mobile",
      );
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "firstName": firstName,
    "lastName": lastname,
    "email": email,
    "password": password,
    "mobile": mobile,
    "dob": dob,
    "gender": gender,
    "asd1":asd1,
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
    "userEmail": email,
    "companyName": companyName,
    "companyCode":companyCode,
   "customerCode": customerCode,
    "customerId": "",
    "storeCode": "1001",
    "description": "ok"
    };
    return map;
  }
}
