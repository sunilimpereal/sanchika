import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sanchika/config.dart';
import 'package:sanchika/model/customer.dart';

class APIService {
  //Create Customer(User)
  Future<bool> createCustomer(CustomerModel model) async {
    var authtoken = base64.encode(
      utf8.encode(Config.key + ":" + Config.seceret),
    );
    bool ret = false;
    try {
      var response = await Dio().post(Config.url + Config.customerURL,
          data: model.toJson(),
          options: new Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authtoken',
            HttpHeaders.contentTypeHeader: 'application/json',
          }));
      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }
    return ret;
  }
}

//login customer

// Future<LoginModel> loginCustomer(String username, String password) async {
//   LoginModel model;
//   try{
//     var response = await Dio().post(
//       Config.tokenURL,
//       data: {
//         "username": username,
//         "password": password,
//       },
//       options: new Options(
//         headers:{
//           HttpHeaders.contentTypeHeader: "application/x-www-form- urlencoded",
//         }
//       )
//     );
//   }
// }
