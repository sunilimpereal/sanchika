import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sanchika/model/login_model.dart';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel login) async {
    String url =
        'http://justerp.in:9191/sanchika/user/login/getEmailAndPassword?email=user@user.com&password=123456';
    final response = await http.get(
      url,
    );
    if (response.statusCode == 200) {
      return loginResponseModelFromJson(response.body);
      print('got');
    }
  }
}
