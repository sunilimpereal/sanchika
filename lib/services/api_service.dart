import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sanchika/model/login_model.dart';
import 'package:sanchika/model/signUp_model.dart';

class APIService {
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
    final response =
        await http.post(url, body: jsonEncode(register.toJson()), headers: {
      "Content-Type": "application/json",
      "Accept": "*/*",
      "Accept-Encoding": "gzip, deflate, br",
      "Connection": "keep-alive"
    });
    if (response.statusCode == 200) {
      print('signed up');
      return registerResponseModelFromJson(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
