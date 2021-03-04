import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sanchika/model/login_model.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/model/signUp_model.dart';
import 'package:sanchika/pages/ui/widget/product_card.dart';

class APIService {
  Map<String, String> headerList = {
    "Content-Type": "application/json",
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive"
  };
  Future<LoginResponseModel> login(LoginRequestModel login) async {
    String url =
        'http://sanchika.in//sanchikaapi/sanchika/user/login/getEmailAndPassword';
    final response = await http.get(
      url + '?email=${login.email}&password=${login.password}',
    );
    FlutterError.onError = (FlutterErrorDetails details) {
      return null;
    };
    if (response.statusCode == 200) {
      print('login');
      return loginResponseModelFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<RegisterResponseModel> register(RegisterRequestModel register) async {
    String url = "http://sanchika.in//sanchikaapi/sanchika/user/register";
    final response = await http.post(url,
        body: jsonEncode(register.toJson()), headers: headerList);
    FlutterError.onError = (FlutterErrorDetails details) {
      return null;
    };
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

  //get products
  List<Product> getProducts() {
    List<Product> products = [];
    products.add(Product(
        name: 'Lays Classic',
        type: '200g',
        typeList: ['100g', '200g', '300g'],
        description:
            'Lay\'s is a brand of potato chip varieties, as well as the name of the company that founded the chip brand in the United States. It has also been called Frito-Lay with Fritos. Lay\'s has been owned by PepsiCo through Frito-Lay since 1965.',
        price: 120,
        price1: 125,
        discount: 5,
        ingredients:
            'Paneer or cottage cheese is prepared by curing and draining blanched milk. It is an excellent source of nutrients like protein and calcium. The Premium Fresh paneer from the stable of Milky Mist is free of preservatives and packed with freshness. It is prepared in hygienic industrial set ups where high standards of production are followed.',
        images: [
          'assets/images/lays.png',
          'assets/images/lays2.jpg',
        ],
        relatedproducts: []));
    products.add(Product(
        name: 'Milky Mist Paneer',
        typeList: ['100g', '200g', '300g'],
        description:
            'Milky Mist is a brand that is known for its various dairy products. The pure and protein rich products are renowned for their high quality goodness. Paneer is a product which is also known as cottage cheese. This is a healthy dairy product that is produced and marketed by Milky Mist.',
        price: 599,
        ingredients:
            'Paneer or cottage cheese is prepared by curing and draining blanched milk. It is an excellent source of nutrients like protein and calcium. The Premium Fresh paneer from the stable of Milky Mist is free of preservatives and packed with freshness. It is prepared in hygienic industrial set ups where high standards of production are followed.',
        images: [
          'assets/images/milkymist1.png',
          'assets/images/milkymist2.png'
        ]));
    products.add(Product(
        name: 'Philips Electronic Induction Stove',
        description:
            'Milky Mist is a brand that is known for its various dairy products. The pure and protein rich products are renowned for their high quality goodness. Paneer is a product which is also known as cottage cheese. This is a healthy dairy product that is produced and marketed by Milky Mist.',
        price: 1200,
        price1: 1500,
        discount: 30,
        ingredients: 'Paneer or cottage cheese is prepared by curing and draining blanched milk. It is an excellent source of nutrients like protein and calcium. The Premium Fresh paneer from the stable of Milky Mist is free of preservatives and packed with freshness. It is prepared in hygienic industrial set ups where high standards of production are followed.',
        images: ['assets/images/pan1.png', 'assets/images/pan2.jpeg']));
    products.add(Product(
        name: 'Country Sweets',
        description:
            'Made from all natural ingredients, it\'s the perfect mix of sweet and tangy with just the right kick to bring any food to life. Not a traditional barbecue sauce, Country Sweet is the all-purpose flavor enhancer that has no boundaries. Add a delicious zest to chicken, pork, beef, seafood and even pizza.',
        price: 50,
        ingredients: 'First developed in a home kitchen in Rochester, New York, this sauce is unlike anything you’ve ever tried. Made from all natural ingredients, it’s the perfect mix of sweet and tangy with just the right kick to bring any food to life.',
        images: [
          'assets/images/countrysweet.png',
          'assets/images/countrysweet.png'
        ]));
    products.add(Product(
        name: 'RICE',
        type: '1Kg',
        typeList: ['1Kg', '3Kg', '5Kg'],
        description:
            'Naturally aged for 12 months \nAffordable Authentic Basmati Rice Basmati for regular use \nGluten freeIdeal for dishes like Pulao, Jeera Rice, khichdi & steam rice\nCountry of Origin: India',
        price: 30,
        price1: 38,
        discount: 15,
        ingredients:
            'First developed in a home kitchen in Rochester, New York, this sauce is unlike anything you’ve ever tried. Made from all natural ingredients, it’s the perfect mix of sweet and tangy with just the right kick to bring any food to life.',
        images: ['assets/images/rice.png', 'assets/images/countrysweet.png']));
    products.add(Product(
        name: 'Gold Winner',
        type: '1 L',
        typeList: ['1L', '2L', '3L'],
        description:
            'BLRs \nLight and healthy that is easy to digest \nRich in vitamins, which keeps skin healthy\nGood for the heart\nCountry of Origin: India\nGood for the heart',
        price: 30,
        price1: 38,
        discount: 15,
        ingredients:
            'First developed in a home kitchen in Rochester, New York, this sauce is unlike anything you’ve ever tried. Made from all natural ingredients, it’s the perfect mix of sweet and tangy with just the right kick to bring any food to life.',
        images: [
          'assets/images/goldwinner.png',
          'assets/images/countrysweet.png'
        ]));
    return products;
  }

  // for now use this later remove it
  Future<List<Product>> getProductList(List<Product> productList) =>
      Future<List<Product>>.delayed(
        Duration(seconds: 3),
        () => productList,
      );

  // get wishlist for the user
}
