import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.statusMsg,
    this.errorCode,
    this.data,
  });

  String status;
  String statusMsg;
  dynamic errorCode;
  Data data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
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
    this.login,
  });

  Login login;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        login: Login.fromJson(json["Login "]),
      );

  Map<String, dynamic> toJson() => {
        "Login ": login.toJson(),
      };
}

class Login {
  String email;
  String name;
  Login({
    this.email,
    this.name,
  });
  factory Login.fromJson(Map<String, dynamic> json) => Login(
        email: json["email"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email,
      "password": name,
    };
    return map;
  }
}

class LoginRequestModel {
  LoginRequestModel({
    this.email,
    this.password,
  });

  String email;
  String password;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        email: json["email"],
        password: json["name"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email.trim(),
      "password": password,
    };
    return map;
  }
}
