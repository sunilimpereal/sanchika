import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sanchika/model/login_model.dart';
import 'package:sanchika/model/signUp_model.dart';

class APIService {
  Map<String, String> headerList = {
    "Content-Type": "application/json",
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive"
  };
  Future<LoginResponseModel> login(LoginRequestModel login) async {
    String url =
        'http://justerp.in:9191/sanchika/user/login/getEmailAndPassword';
    final response = await http.get(
      url + '?email=${login.email}&password=${login.password}',
    );
    if (response.statusCode == 200) {
      return loginResponseModelFromJson(response.body);
      print('got');
    }
  }

  Future<RegisterResponseModel> register(RegisterRequestModel register) async {
    String url = "http://justerp.in:9191/sanchika/user/register";
    final response = await http.post(url,
        body: jsonEncode(register.toJson()), headers: headerList);
    if (response.statusCode == 200) {
      print('signed up');
      return registerResponseModelFromJson(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future<String> getotp(String mobileNumber) async {
    String url = "http://justerp.in:9191/sanchika/user/genrateotp";
    final response = await http.post(url,
        headers: headerList,
        body: jsonEncode(<String, String>{"mobileNumber": "$mobileNumber"}));
    if (response.statusCode == 200) {
      print("otp Sent");
      print(response.body);
      return response.body;
    } else {
      print('otp error');
      print(response.statusCode);
    }
  }
}
