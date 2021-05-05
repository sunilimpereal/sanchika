import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sanchika/model/AllProducts.dart';
import 'package:sanchika/model/CtgAttribute.dart';
import 'package:sanchika/model/HomeCtgProducts.dart';
import 'package:sanchika/model/activeProduct_model.dart';
import 'package:sanchika/model/addRating.dart';
import 'package:sanchika/model/addToCart_model.dart';
import 'package:sanchika/model/cart_model.dart';
import 'package:sanchika/model/ctg_secondAttribute_model.dart';
import 'package:sanchika/model/getAllRatingReview_model.dart';
import 'package:sanchika/model/getCatg_model.dart';
import 'package:sanchika/model/getOfferByCustId.dart';
import 'package:sanchika/model/getProductAttribute_model.dart';
import 'package:sanchika/model/getProductDetail_model.dart';
import 'package:sanchika/model/getShippingDetail.dart';
import 'package:sanchika/model/killerOffer.dart';
import 'dart:convert';
import 'package:sanchika/model/login_model.dart';
import 'package:sanchika/model/multiitemSaveOrder.dart';
import 'package:sanchika/model/myInformation.dart';
import 'package:sanchika/model/myOrders.dart';
import 'package:sanchika/model/orderDetails.dart';
import 'package:sanchika/model/paymentUpdate.dart';
import 'package:sanchika/model/placedOrder.dart';
import 'package:sanchika/model/product.dart';
import 'package:sanchika/model/signUp_model.dart';
import 'package:sanchika/model/userOrderDetails.dart';
import 'package:sanchika/model/wishlist_model.dart';
import 'package:sanchika/model/getBanner_model.dart';
import 'package:sanchika/pages/ui/screens/404_page.dart';

class APIService {
  // config details
  String baseurl = "http://sanchika.in:8081/sanchikaapi//sanchika/user/";
  Map<String, String> headerList = {
    "Content-Type": "application/json",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
    "Accept-Encoding": "gzip, deflate, br",
    "Connection": "keep-alive",
    "Keep-Alive": "timeout=20",
    "Accept-Language": "en-US,en;q=0.9",
    "Transfer-Encoding":"chunked",
    
    
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
      LoginResponseModel loginResponseModel =
          loginResponseModelFromJson(response.body);
      if (loginResponseModel.status == '0') {
        print("status login ${loginResponseModel.status}");
        return loginResponseModelFromJson(response.body);
      }else{
        showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Incorrect Details'),
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
    } else if (response.statusCode == 500) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Incorrect Details'),
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
    } else {
      Navigator.push(
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
    String url = "http://sanchika.in:8081/sanchikaapi/sanchika/user/genrateotp";
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
    final response = await http.get(
      url,
    );
    // FlutterError.onError = (FlutterErrorDetails details) {
    //   print('error');
    //   return [];
    // };

    print('wishist response ${response.statusCode}');
    if (response.statusCode == 200) {
      print(getWishlistFromJson(response.body));
      GetWishlist getWishlistBody = getWishlistFromJson(response.body);
      List<WishlistItem> wishlistItems = getWishlistBody.data.wishListMaster;
      print(wishlistItems);
      return wishlistItems;
    } else {
      return [];
    }
  }

  //Add to wishlist
  Future<bool> addToWishlist(AddWishlistRequest addWishlistRequest) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/wishList/addToWishList";
    final response = await http.post(url,
        body: addWishlistRequestToJson(addWishlistRequest),
        headers: headerList);
    print('add to Wishlist response ${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> countWishlist(String userId) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/wishList/countWishList?uid=$userId";
    final response = await http.get(url);
    print('count wishlist Item response ${response.statusCode}');
    if (response.statusCode == 200) {
      CountWishlistItem countWishlistItem =
          countWishlistItemFromJson(response.body);
      String count = countWishlistItem.data.countWishList;
      return count;
    } else {
      return "";
    }
  }

  //Remove from Wishlist
  Future<bool> removeWishlistitem({String uid, String pid}) async {
    print("uid $uid  pid $pid");
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/wishList/removeWishList?uid=$uid&pid=$pid";
    final response = await http.delete(url);
    print('remove wishlist Item response ${response.statusCode}');
    print('body ${response.body}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //Get killer offer products
  Future<List<Product>> getKillerOffeers() async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/killerOffersProductDetails";
    final response = await http.get(url);
    print('KillerOffer api call ${response.statusCode}');
    print(response.body);

    if (response.statusCode == 200) {
      Getkilleroffers getKilleroffers = getkilleroffersFromJson(response.body);
      print(getKilleroffers);
      List<Product> products =
          getKilleroffers.data.killerOffersProductDetailsList;
      print(products);
      return products;
    } else {
      return [];
    }
  }

  //Get all Products details
  Future<List<Product>> getAllProducts() async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/getAllProductDetails";
    final response = await http.get(url);
    print('Get all Products API ${response.statusCode}');
    if (response.statusCode == 200) {
      GetAllProducts allProducts = getAllProductsFromJson(response.body);
      List<Product> productList = allProducts.data.productDetailsList;
      return productList;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  //Get active products
  Future<List<Product>> getActiveProduct() async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/getAllProductDetails";
    final response = await http.get(url);
    print('response of active products ${response.statusCode}');
    if (response.statusCode == 200) {
      GetActiveProduct allActiveProduct =
          getActiveProductFromJson(response.body);
      List<Product> productList =
          allActiveProduct.data.activeProductDetailsList;
      return productList;
    } else {
      return [];
    }
  }

  //get prdocut from each category
  // Future<List<CtgyProductDetailsList>> getCtegoryProducts() async {
  //   String url =
  //       "http://sanchika.in:8081/sanchikaapi/sanchika/user/getCtgyProductDetails?ctgyId=1285";
  //   print('url');
  //   var response = await http.get(url, headers: headerList);
  //   print(response.body);
  //   print(response.statusCode);
  //   FlutterError.onError = (FlutterErrorDetails details) {
  //     // print('error');
  //     return null;
  //   };
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     GetProduct getProduct = getProductFromJson(response.body);
  //     List<CtgyProductDetailsList> productList =
  //         getProduct.data.ctgyProductDetailsList;
  //     print(productList);
  //     return productList;
  //   } else {
  //     return null;
  //   }
  // }

  //Get Cart Items
  Future<List<CartItem>> getCartItems(String userId) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/cart/getCart?uid=$userId";
    print(userId);
    final response = await http.get(url, headers: headerList);
    //  FlutterError.onError = (FlutterErrorDetails details) {
    //   print('error');
    //   return null;
    // };
    print(response.statusCode);
    if (response.statusCode == 200) {
      GetCart getCart = getCartFromJson(response.body);
      List<CartItem> cartItemlist = getCart.data.getCartList;
      print(cartItemlist);
      return cartItemlist;
    } else {
      print(response.statusCode);
      return [];
    }
  }

  // Add to cart
  Future<bool> addItemToCart(
      {String productId,
      String userId,
      int quantity,
      String productName,
      double price,
      double slPrice,
      double grandTotal}) async {
    AddtocartRequest addtocartRequest = new AddtocartRequest();
    addtocartRequest.productId = productId;
    addtocartRequest.price = price;
    addtocartRequest.productName = productName;
    addtocartRequest.totalWeght = "PCS";
    addtocartRequest.userId = int.parse(userId);
    addtocartRequest.grandTotal = grandTotal.toString();
    addtocartRequest.productSellingPrice = slPrice;
    addtocartRequest.quantity = quantity ?? 1;
    print(addtocartRequest.userId);
    print(addtocartRequest.productId);
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/cart/addToCart";
    final response = await http.post(url,
        body: jsonEncode(addtocartRequest.toJson()), headers: headerList);

    print('Addto cart response : ${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }

  //Delete from cart
  Future<bool> removeCartItem({String userId, String pid}) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/cart/delete-cart-list?uid=$userId&pid=$pid";

    final response = await http.delete(url, headers: headerList);

    print('delete CartItem : ${response.statusCode} ${userId} ${pid}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //Clear cart
    Future<bool> clearCartItem({String userId}) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/cart/clear-cart?uid=$userId";

    final response = await http.get(url, headers: headerList);

    print('clear CartItem : ${response.statusCode} ${userId}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  //Get cart langth
  Future<String> cartlength({String uid}) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/cart/getCart?uid=$uid";
    final response = await http.get(url, headers: headerList);
    print(response.statusCode);
    if (response.statusCode == 200) {
      GetCart getCart = getCartFromJson(response.body);
      List<CartItem> cartItemlist = getCart.data.getCartList;
      print(cartItemlist);
      String length = cartItemlist.length.toString();
      return length;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  //get each product detail
  Future<List<Product>> getProductDetail({String productId}) async {
    print('productId $productId');
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/searchAPI?nameOrId=$productId";
    final response = await http.get(url, headers: headerList);
     print('ProductDetail response: ${productId}');
    print('ProductDetail response: ${response.body}');
    if (response.statusCode == 200) {
      GetProductDetail getProductDetail =
          getProductDetailFromJson(response.body);
      List<Product> productDetailList =
          getProductDetail.data.productDetailsList;
      return productDetailList;
    } else {
      return [];
    }
  }

  //getbanners
  Future<List<BannerMaster>> getBanners() async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/banner/getBanner";
    final response = await http.get(url, headers: headerList);
    print('Banner response ${response.statusCode}');
    if (response.statusCode == 200) {
      Getbanner getbanner = getbannerFromJson(response.body);
      List<BannerMaster> bannerList = getbanner.data.bannerMaster;
      print(bannerList);
      return bannerList;
    } else {
      return null;
    }
  }

  // //get Address
  // Future<ShippingAddress> getAddress(String userId) async {
  //   String url =
  //       "http://sanchika.in:8081/sanchikaapi/sanchika/user/getShippingAddress?userId=$userId";
  //   final response = await http.get(url);
  //   print('get address response ${response.statusCode}');
  //   if (response.statusCode == 200) {
  //     GetAddress getAddress = getAddressFromJson(response.body);
  //     ShippingAddress address = getAddress.data.shippingAddress;
  //     print(address.asd1);
  //     return address;
  //   } else {
  //     ShippingAddress address;
  //     return address;
  //   }
  // }

  //get Ctg Name
  Future<List<CtgyNameAndId>> getCatg() async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/getCtgyList";
    final response = await http.get(url);
    print("Get Category names response ${response.statusCode}");
    if (response.statusCode == 200) {
      GetCtg getCtg = getCtgFromJson(response.body);
      List<CtgyNameAndId> ctgList = getCtg.data.ctgyNameAndIdList;
      return ctgList;
    } else {
      return [];
    }
  }

  //Get Ctg Attribute
  Future<List<CategoryAttribute>> getCategoryAttribute(String ctgId) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/getcategoryAttribute?catgyId=$ctgId";
    final response = await http.get(url);
    print('Category attribute response : ${response.statusCode}');
    if (response.statusCode == 200) {
      GetCtgAttribute getCtgAttribute = getCtgAttributeFromJson(response.body);
      List<CategoryAttribute> catgAttributeList =
          getCtgAttribute.data.getCategoryAttributeList;
      return catgAttributeList;
    } else {
      return [];
    }
  }

  //Get category attribute by second order
  Future<List<CategoryAttribute>> getCategoryAttributeBySecondOrder(
      String ctgId) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/getcategoryAttributeBySecondOrder?catgyId=$ctgId";
    final response = await http.get(url);
    print('Category Second order ${response.statusCode}');
    if (response.statusCode == 200) {
      GetCtgAttributeSecondOrder getCtgAttributeSecondOrder =
          getCtgAttributeSecondOrderFromJson(response.body);
      List<CategoryAttribute> ctgAtributeList =
          getCtgAttributeSecondOrder.data.getCategoryAttributeList;
      return ctgAtributeList;
    } else {
      return [];
    }
  }

  //get Home Products
  Future<List<Product>> getHomeProducts(String ctgId) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user//home-screan?catgyId=$ctgId";
    final response = await http.get(url);
    print("response of ${response.statusCode}");
    if (response.statusCode == 200) {
      GetHomeCatgProducts getHomeCatgProducts =
          getHomeCatgProductsFromJson(response.body);
      List<Product> product = getHomeCatgProducts.data.getProductList;
      return product;
    } else {
      return [];
    }
  }

  //get Product Attribute
  Future<List<Product>> getProductAttribute({String capId}) async {
    print('cap Id :$capId');
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/getProductAttribute?capId=$capId";
    final response = await http.get(url,headers: headerList);
    print('getProduct Attribute :${response.body}');
    if (response.statusCode == 200) {
      GetProductAttribute getProductAttribute =
          getProductAttributeFromJson(response.body);
      List<Product> productList = getProductAttribute.data.productDetailsList;
      return productList;
    } else {
      return [];
    }
  }

  //get rating and review
  Future<List<RatingAndReview>> getRatingAndReview(String productId) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi//sanchika/user/getAllRatingAndReview";
    final response = await http.get(url);
    print('getRating status :${response.statusCode}');
    if (response.statusCode == 200) {
      GetAllRatingAndReview allRatingAndReview =
          getAllRatingAndReviewFromJson(response.body);
      List<RatingAndReview> productRating = allRatingAndReview
          .data.rattingAndViewIsGetting
          .where((e) => e?.productId == productId)
          .toList();
      return productRating;
    } else {
      return null;
    }
  }

  //add rating and review
  Future<bool> addReview(RatingRequestModel ratingRequestModel) async {
    String url = "";
    final response = await http.post(url,
        body: jsonEncode(ratingRequestModel.toJson()), headers: headerList);
    print('Response of addReview ${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Save User Order Details save
  Future<bool> saveUserorderDetailsSave(
      OrderuserDetailsRequestModel orderuserDetailsRequestModel) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/order/order-user-details";
    final response = await http.post(url,
        body: orderuserDetailsRequestModelToJson(orderuserDetailsRequestModel));
    print('Order User details save : ${response.statusCode}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<MyInformationClass> getuserInformation(String userId) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/myInformation?uid=$userId";
    final response = await http.get(url);
    print('Get User Details ;${response.statusCode}');
    if (response.statusCode == 200) {
      MyInformation myInformation = myInformationFromJson(response.body);
      MyInformationClass myInformationClass = myInformation.data.myInformation;
      return myInformationClass;
    } else {
      return null;
    }
  }

  //get My Orders
  Future<List<OrderSummary>> getMyOrders({String userId}) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/order/get-order-user-wise?uid=$userId";
    final response = await http.get(url);
    print("get MyOrders response = ${response.statusCode}");
    if (response.statusCode == 200) {
      MyOrder myOrder = myOrderFromJson(response.body);
      List<OrderSummary> orders = myOrder.data.getOrderSummary;
      return orders;
    } else {
      return [];
    }
  }

  //orderDetail
  Future<List<OderCheckOut>> orderDetail({String ordnum}) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/order/after-order-summary?ordnum=$ordnum";
    final response = await http.get(url);
    print("orderDetail response = ${response.statusCode}");
    if (response.statusCode == 200) {
      OrderDetail orderDetail = orderDetailFromJson(response.body);
      List<OderCheckOut> ords = orderDetail.data.oderCheckOut;
      return ords;
    } else {
      return [];
    }
  }

  // save multi Item Order
  Future<List<OrderUserDetails>> multiItemOrder({List<OrderItem> data}) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/order/save-multi-item-order";
    final response =
        await http.post(url, body: orderItemToJson(data), headers: headerList);
    print("save multiItem Order = ${response.statusCode}");
    print("save multiItem Order body = ${response.body}");
    if (response.statusCode == 200) {
      PlacedOrder placedOrder = placedOrderFromJson(response.body);
      List<OrderUserDetails> orderUserDetailList = [];
      placedOrder.data.orderUserDetails.forEach((key, value) {
        print('value : $value');
        orderUserDetailList.add(value);
      });
      return orderUserDetailList;
    } else {
      return null;
    }
  }

  //Get Shipping Details
  Future<ShippingAddress> getShippingDetail(String userId) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/getShippingAddress?userId=$userId";
    final response = await http.get(
      url,
    );
    print("Get Shipping  address = ${response.statusCode}");
    if (response.statusCode == 200) {
      GetShippingDetail getShippingDetail =
          getShippingDetailFromJson(response.body);
      ShippingAddress shippingAddress = getShippingDetail.data.shippingAddress;
      return shippingAddress;
    } else {
      return null;
    }
  }

  //Post Payment Update
  Future<bool> postpaymentupdate(
      String ordernum, PaymentUpdate paymentUpdate) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/order/update-payment?orderNumber=$ordernum";
    final response = await http.post(url,
        body: paymentUpdateToJson(paymentUpdate), headers: headerList);
    print("Post payment  update = ${response.statusCode}");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  //Get Offer By CustomerID
    Future<List<OfferItem>> getOffersBycustId(String custmId) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/offer/get-offer-by-cust-id?custCatgyId=$custmId";
    final response = await http.get( 
      url,
    );
    print("Get Offer By CustId= ${response.body}");
    if (response.statusCode == 200) {
      GetOffersByCustCtg getOffersByCustCtg =getOffersByCustCtgFromJson(response.body);
      List<OfferItem> offerItemList = getOffersByCustCtg.data.getOffer;
      return offerItemList;
    } else {
      return [];
    
    }
  }
      Future<int> updateCartItem(String custmId) async {
    String url =
        "http://sanchika.in:8081/sanchikaapi/sanchika/user/cart/updateCartProductQuantity";
    final response = await http.get( 
      url,
    );
    print("Update cart item Qty= ${response.body}");
    if (response.statusCode == 200) {

    } else {
      return 0;
    
    }
  }
}
