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
  String email;
  String password;
  String mobile;
  RegisterRequestModel({
    this.email,
    this.password,
    this.mobile,
  });
  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      RegisterRequestModel(
        email: "email",
        password: "password",
        mobile: "mobile",
      );
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email.trim(),
      "password": password,
      "mobile": mobile,
    };
    return map;
  }
}
