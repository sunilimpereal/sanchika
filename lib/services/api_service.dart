import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sanchika/model/AllProducts.dart';
import 'package:sanchika/model/CtgAttribute.dart';
import 'package:sanchika/model/activeProduct_model.dart';
import 'package:sanchika/model/addToCart_model.dart';
import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/model/ctg_secondAttribute_model.dart';
import 'package:sanchika/model/getAddresss_model.dart';
import 'package:sanchika/model/getCatg_model.dart';
import 'package:sanchika/model/getProductAttribute_model.dart';
import 'package:sanchika/model/getProductDetail_model.dart';
import 'package:sanchika/model/killerOffer.dart';
import 'dart:convert';

import 'package:sanchika/model/login_model.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/model/cat_product_model.dart';
import 'package:sanchika/model/signUp_model.dart';
import 'package:sanchika/model/subMenu_model.dart';
import 'package:sanchika/model/topMenu_model.dart';
import 'package:sanchika/model/wishlist_model.dart';
import 'package:sanchika/model/getBanner_model.dart';
import 'package:sanchika/pages/ui/screens/404_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService {
  // config details
  String baseurl = "http://sanchika.in:8081/sanchikaapi//sanchika/user/";
  Map<String, String> headerList = {
    "Content-Type": "application/json",
    "Accept": "*/*",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive",
    "Keep-Alive": "timeout=0",

     
  };

  // Fect data api
  Future<LoginResponseModel> login(
      LoginRequestModel login, BuildContext context) async {
    String url =
        'http://sanchika.in:8081/sanchikaapi/sanchika/user/login/getEmailAndPassword';
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
     
    } else { Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
     
    }
  }

  Future<RegisterResponseModel> register(RegisterRequestModel register) async {
    String url = "http://sanchika.in:8081/sanchikaapi/sanchika/user/register";
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
  Future<List<WishlistItem>> getWishList({String userId}) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/wishList/getWishList?uid=$userId";
    final response = await http.get(url,);
    FlutterError.onError = (FlutterErrorDetails details) {
      // print('error');
      return null;
    };

    print('wishist response ${response.statusCode}');
    if (response.statusCode == 200) {
      print(getWishlistFromJson(response.body));
      GetWishlist getWishlistBody = getWishlistFromJson(response.body);
      List<WishlistItem> wishlistItems = getWishlistBody.data.wishListMaster;
      print(wishlistItems);
      return wishlistItems;
    } else {
      return null;
    }
  }
  //Add to wishlist
  Future<bool> addToWishlist(AddWishlistRequest addWishlistRequest)async{
    String url="http://sanchika.in:8081/sanchikaapi/sanchika/user/wishList/addToWishList";
    final response= await http.post(url,body: addWishlistRequestToJson(addWishlistRequest), headers: headerList);
    print('add to Wishlist response ${response.statusCode}');
    if(response.statusCode==200){
      return true;
    }
    else{
      return false;
    }

  }
  //Remove from Wishlist
  Future<bool> removeWishlistitem({String uid,String pid})async{
    String url ="http://sanchika.in:8081/sanchikaapi/sanchika/user/wishList/removeWishList?uid=$uid&pid=$pid";
    final response = await http.delete(url);
    print('remove wishlist Item response ${response.statusCode}');
    if(response.statusCode==200){
      return true;
    }
    else{
      return false;
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
  //Get all Products details
  Future<List<Product>> getAllProducts() async{
    String url = "http://sanchika.in:8081/sanchikaapi/sanchika/user/getAllProductDetails";
    final response = await http.get(url);
    print('Get all Products API ${response.statusCode}');
    if(response.statusCode == 200){
      GetAllProducts allProducts = getAllProductsFromJson(response.body);
      List<Product> productList = allProducts.data.productDetailsList;
      return productList;

    }else{
      print(response.statusCode);
      return null;
    }
  }
  //Get active products
  Future<List<Product>> getActiveProduct()async{
    String url ="http://sanchika.in:8081/sanchikaapi/sanchika/user/getAllProductDetails";
    final response = await http.get(url);
    print('response of active products ${response.statusCode}');
    if(response.statusCode==200){
      GetActiveProduct allActiveProduct = getActiveProductFromJson(response.body);
      List<Product> productList = allActiveProduct.data.activeProductDetailsList;
      return productList;
    }else{
      return [];
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
      // print('error');
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
  //Get Cart Items 
  Future<List<CartItem>> getCartItems (String userId) async {
    String url = "http://sanchika.in:8081/sanchikaapi/sanchika/user/cart/getCart?uid=$userId";
    print(userId);
    final response = await http.get(url,headers: headerList);
    //  FlutterError.onError = (FlutterErrorDetails details) {
    //   print('error');
    //   return null;
    // };
    print(response.statusCode);
    if(response.statusCode == 200){
      GetCart getCart = getCartFromJson(response.body);
      List<CartItem> cartItemlist = getCart.data.getCartList;
      print(cartItemlist);
      return cartItemlist;
     }else{
       print(response.statusCode);
       return [];
     }
  }
  // Add to cart
  Future<bool> addItemToCart({String productId,String userId,int quantity, String productName,double price,double slPrice, double grandTotal})async {
    AddtocartRequest addtocartRequest = new AddtocartRequest();
    addtocartRequest.productId=productId;
    addtocartRequest.price=price;
    addtocartRequest.productName=productName;
    addtocartRequest.totalWeght="PCS";
    addtocartRequest.userId=int.parse(userId);
    addtocartRequest.grandTotal = grandTotal.toString();
    addtocartRequest.productSellingPrice = slPrice;
    addtocartRequest.quantity= quantity??1;
    print(addtocartRequest.userId);
    print(addtocartRequest.productId);
    String url = "http://sanchika.in:8081/sanchikaapi/sanchika/user/cart/addToCart";
     final response = await http.post(url,
        body: jsonEncode(addtocartRequest.toJson()), headers: headerList);
    
   
    print('Addto cart response : ${response.statusCode}');
    if(response.statusCode==200){
      return true;
    }
    else{
      print(response.statusCode);
      return false;
    }
  }
  //Get cart langth
  Future<String> cartlength({String uid})async {
     String url = "http://sanchika.in:8081/sanchikaapi/sanchika/user/cart/getCart?uid=$uid";
    final response = await http.get(url,headers: headerList);
    print(response.statusCode);
    if(response.statusCode == 200){
      GetCart getCart = getCartFromJson(response.body);
      List<CartItem> cartItemlist = getCart.data.getCartList;
      print(cartItemlist);
      String length = cartItemlist.length.toString();
      return length;
     }else{
       print(response.statusCode);
       return null;
     }

  }

  //get each product detail
  Future<List<Product>> getProductDetail({String productId})async{
    String url = "http://sanchika.in:8081/sanchikaapi/sanchika/user/searchAPI?nameOrId=$productId";
    final response = await http.get(url,headers: headerList);
    print('ProductDetail response: ${response.statusCode}');
    if(response.statusCode==200){
      GetProductDetail getProductDetail = getProductDetailFromJson(response.body);
      List<Product> productDetailList = getProductDetail.data.productDetailsList;
      return productDetailList;
    }else{
      return [];
    }
  }
  //getbanners
  Future<List<BannerMaster>> getBanners()async{
    String url="http://sanchika.in:8081/sanchikaapi/sanchika/user/banner/getBanner";
    final response = await http.get(url,headers: headerList);
    print('Banner response ${response.statusCode}');
    if(response.statusCode==200){
      Getbanner getbanner = getbannerFromJson(response.body);
      List<BannerMaster> bannerList = getbanner.data.bannerMaster;
      print(bannerList);
      return bannerList;
    }else{return null;}
  }
  //get Top Menu
   Future<List<TopMenu>> getTopMenu()async{
     String url = "http://sanchika.in:8081/sanchikaapi/sanchika/user/menu/topmenu";
     final response = await http.get(url,headers: headerList);
     print('Top Menu response ${response.statusCode}');
     if(response.statusCode == 200){
       GetTopMenu topMenuItems = getTopMenuFromJson(response.body);
       List<TopMenu> topMenuList = topMenuItems.data.topMenu;
       print(topMenuList);
       return topMenuList;
     }else{
       return [];
     }
  }
  //get Sub menu
  Future<List<SubMenu>> getSubMenu(int menuId,String title) async {
    String url ="http://sanchika.in:8081/sanchikaapi/sanchika/user/menu/submenu?menuid=$menuId&title=$title";
    final response = await http.get(url,headers: headerList);
    print('SubMenu response ${response.statusCode}');
    if(response.statusCode==200){
      GetSubMenu subMenu = getSubMenuFromJson(response.body);
      List<SubMenu> subMenuList = subMenu.data.subMenu;
      print(subMenuList);
      return subMenuList;
    }else{
      return [];
    }
  }
  //get Address
  Future<Address> getAddress()async{
    String url="http://sanchika.in:8081/sanchikaapi/sanchika/user/addressInfo?userId=10004";
    final response = await http.get(url);
    print('get address response ${response.statusCode}');
    if(response.statusCode==200){
      GetAddress getAddress = getAddressFromJson(response.body);
      Address address = getAddress.data.createOnAcount;
      print(address.asd1);
      return address;
    }else{
      Address address;
      return address;
    }
  }
  //get Ctg Name
  Future<List<CtgyNameAndId>> getCatg()async{
    String url ="http://sanchika.in:8081/sanchikaapi/sanchika/user/getCtgyList";
    final response = await http.get(url);
    print("Get Category names response ${response.statusCode}");
    if(response.statusCode==200){
      GetCtg getCtg = getCtgFromJson(response.body);
      List<CtgyNameAndId> ctgList = getCtg.data.ctgyNameAndIdList;
      return ctgList;
    }else{
      return [];
    }
  }
  //Get Ctg Attribute
  Future<List<CategoryAttribute>> getCategoryAttribute(String ctgId)async{
    String url ="http://sanchika.in:8081/sanchikaapi/sanchika/user/getcategoryAttribute?catgyId=$ctgId";
    final response = await  http.get(url);
    print('Category attribute response : ${response.statusCode}');
    if(response.statusCode==200){
      GetCtgAttribute getCtgAttribute = getCtgAttributeFromJson(response.body);
      List<CategoryAttribute> catgAttributeList = getCtgAttribute.data.getCategoryAttributeList;
      return catgAttributeList;
    }else{
      return [];
    }
  }
  //Get category attribute by second order
  Future<List<CategoryAttribute>> getCategoryAttributeBySecondOrder(String ctgId)async{
  String url ="http://sanchika.in:8081/sanchikaapi/sanchika/user/getcategoryAttributeBySecondOrder?catgyId=$ctgId";
  final response = await http.get(url);
  print('Category Second order ${response.statusCode}');
  if(response.statusCode==200){
    GetCtgAttributeSecondOrder getCtgAttributeSecondOrder = getCtgAttributeSecondOrderFromJson(response.body);
    List<CategoryAttribute> ctgAtributeList = getCtgAttributeSecondOrder.data.getCategoryAttributeList;
    return ctgAtributeList;
  }else{
    return [];
  }
  }






  //get Product Attribute
  Future<List<Product>> getProductAttribute({String capId})async{
    String url ="http://sanchika.in:8081/sanchikaapi/sanchika/user/getProductAttribute?capId=$capId";
    final response = await http.get(url);
    print('getProduct Attribute :${response.statusCode}');
    if(response.statusCode==200){
    GetProductAttribute getProductAttribute = getProductAttributeFromJson(response.body);
    List<Product> productList = getProductAttribute.data.productDetailsList;
    return productList;
    }else{
      return [];
    }
  }

}
