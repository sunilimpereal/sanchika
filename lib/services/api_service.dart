import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sanchika/model/killerOffer.dart';
import 'dart:convert';

import 'package:sanchika/model/login_model.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/model/product_model.dart';
import 'package:sanchika/model/signUp_model.dart';
import 'package:sanchika/model/wishlist.dart';
import 'package:sanchika/pages/ui/screens/404_page.dart';

class APIService {
  // config details
  String baseurl = "http://sanchika.in:8081/sanchikaapi//sanchika/user/";
  Map<String, String> headerList = {
    "Content-Type": "application/json",
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive",
    "Transfer-Encoding": "chunked"
     
  };

  // Fect data api
  Future<LoginResponseModel> login(
      LoginRequestModel login, BuildContext context) async {
    String url =
        'http://sanchika.in:8081/sanchikaa/sanchika/user/login/getEmailAndPassword';
    final response = await http.get(
      url + '?email=${login.email}&password=${login.password}',
    );
    FlutterError.onError = (FlutterErrorDetails details) {
      return null;
    };
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('login');
      return loginResponseModelFromJson(response.body);
    } else if (response.statusCode == 500) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Icorrect Details'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Email Or Password is wrong'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<RegisterResponseModel> register(RegisterRequestModel register) async {
    String url = "http://sanchika.in//sanchikaapi/sanchika/user/register";
    final response = await http.post(url,
        body: jsonEncode(register.toJson()), headers: headerList);
    FlutterError.onError = (FlutterErrorDetails details) {
      return null;
    };
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('signed up');
      return registerResponseModelFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<String> getotp(String mobileNumber) async {
    String url = "http://sanchika.in//sanchikaapi/sanchika/user/genrateotp";
    final response = await http.post(url,
        headers: headerList,
        body: jsonEncode(<String, String>{"mobileNumber": "$mobileNumber"}));
    FlutterError.onError = (FlutterErrorDetails details) {
      return null;
    };
    if (response.statusCode == 200) {
      print("otp Sent");
      print(response.body);
      return response.body;
    } else {
      print('otp error');
      print(response.statusCode);
      return null;
    }
  }

 
  // get wishlist for the user
  Future<List<WishListItem>> getWishList() async {
    String url =
        "http://sanchika.in//sanchikaapi/sanchika/user/wishList/getWishList?ctgyId=1285";
    final response = await http.get(url,);
    FlutterError.onError = (FlutterErrorDetails details) {
      print('error');
      return null;
    };
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(getWishlistFromJson(response.body));
      GetWishlist getWishlistBody = getWishlistFromJson(response.body);
      List<WishListItem> wishlistItems = getWishlistBody.data.wishListMaster;
      print(wishlistItems);
      return wishlistItems;
    } else {
      return null;
    }
  }

  //Get killer offer products
  Future<List<Product>> getKillerOffeers() async {
    String url = "http://sanchika.in:8081/sanchikaapi/sanchika/user/killerOffersProductDetails";
    final response = await http.get(url);
    print('KillerOffer api call ${response.statusCode}');
    print(response.body);
    
    if(response.statusCode == 200){
      Getkilleroffers getKilleroffers = getkilleroffersFromJson(response.body);
      print(getKilleroffers);
      List<Product> products = getKilleroffers.data.killerOffersProductDetailsList;
      print(products);
      return products;
    }else{
      return null;
    }

  }

  //get prdocut from each category
  Future<List<CtgyProductDetailsList>> getCtegoryProducts() async {
    String url = "http://sanchika.in:8081/sanchikaapi/sanchika/user/getCtgyProductDetails?ctgyId=1285";
    print('url');
    var response = await http.get(url,headers: headerList);
    print(response.body);
     print(response.statusCode);
    FlutterError.onError = (FlutterErrorDetails details) {
      print('error');
      return null;
    };
    print(response.statusCode);
    if(response.statusCode==200){
    GetProduct getProduct = getProductFromJson(response.body);
    List<CtgyProductDetailsList> productList = getProduct.data.ctgyProductDetailsList;
    print(productList);
    return productList;
    }else{
      return null;
    }
  }
}
