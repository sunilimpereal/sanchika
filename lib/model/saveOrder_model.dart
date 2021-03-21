// To parse this JSON data, do
//
//     final saveOrder = saveOrderFromJson(jsonString);

import 'dart:convert';

SaveOrder saveOrderFromJson(String str) => SaveOrder.fromJson(json.decode(str));

String saveOrderToJson(SaveOrder data) => json.encode(data.toJson());

class SaveOrder {
    SaveOrder({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory SaveOrder.fromJson(Map<String, dynamic> json) => SaveOrder(
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
        this.bookedOrder,
    });

    BookedOrder bookedOrder;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        bookedOrder: BookedOrder.fromJson(json["Booked Order "]),
    );

    Map<String, dynamic> toJson() => {
        "Booked Order ": bookedOrder.toJson(),
    };
}

class BookedOrder {
    BookedOrder({
        this.companyCode,
        this.userName,
        this.customerName,
        this.userId,
        this.productName,
        this.productId,
        this.productCategory,
        this.itemWeight,
        this.orderItemTotalWeight,
        this.orderGrandTotal,
        this.orderUserComment,
        this.orderTotalQuantity,
        this.orderTotalPrice,
        this.orderTime,
        this.orderSubsAmount,
        this.sellingPrice,
        this.shippingState,
        this.orderShippingPinCode,
        this.orderShippingCity,
        this.orderShippingCharge,
        this.orderConfirmSnt,
        this.orderCreateDate,
        this.foodType,
        this.permanentAddress,
        this.orderShippingAddress1,
        this.orderCity,
        this.state,
        this.orderCountry,
        this.firstName,
        this.lastName,
        this.orderEmailAddress,
        this.orderLocaly,
        this.landMark,
        this.orderPaymentType,
        this.amounttPaidByNetbanking,
        this.amountPaidByCashOnDelivery,
        this.amountPaidByCardbank,
        this.orderPhoneNumber,
        this.orderProductDetails,
        this.orderPrice,
        this.orderNumber,
        this.orderDate,
        this.orderInvoiceNumber,
        this.orderFrom,
        this.deliveryDate,
        this.discountAmount,
        this.orderTaxAmount,
    });

    String companyCode;
    String userName;
    String customerName;
    int userId;
    String productName;
    String productId;
    String productCategory;
    String itemWeight;
    String orderItemTotalWeight;
    int orderGrandTotal;
    String orderUserComment;
    int orderTotalQuantity;
    int orderTotalPrice;
    String orderTime;
    int orderSubsAmount;
    int sellingPrice;
    String shippingState;
    String orderShippingPinCode;
    String orderShippingCity;
    int orderShippingCharge;
    String orderConfirmSnt;
    String orderCreateDate;
    String foodType;
    String permanentAddress;
    String orderShippingAddress1;
    String orderCity;
    String state;
    String orderCountry;
    String firstName;
    String lastName;
    String orderEmailAddress;
    String orderLocaly;
    String landMark;
    String orderPaymentType;
    int amounttPaidByNetbanking;
    int amountPaidByCashOnDelivery;
    int amountPaidByCardbank;
    String orderPhoneNumber;
    String orderProductDetails;
    int orderPrice;
    int orderNumber;
    String orderDate;
    int orderInvoiceNumber;
    String orderFrom;
    String deliveryDate;
    int discountAmount;
    int orderTaxAmount;

    factory BookedOrder.fromJson(Map<String, dynamic> json) => BookedOrder(
        companyCode: json["companyCode"],
        userName: json["userName"],
        customerName: json["customerName"],
        userId: json["userId"],
        productName: json["productName"],
        productId: json["productId"],
        productCategory: json["productCategory"],
        itemWeight: json["itemWeight"],
        orderItemTotalWeight: json["orderItemTotalWeight"],
        orderGrandTotal: json["orderGrandTotal"],
        orderUserComment: json["orderUserComment"],
        orderTotalQuantity: json["orderTotalQuantity"],
        orderTotalPrice: json["orderTotalPrice"],
        orderTime: json["orderTime"],
        orderSubsAmount: json["orderSubsAmount"],
        sellingPrice: json["sellingPrice"],
        shippingState: json["shippingState"],
        orderShippingPinCode: json["orderShippingPinCode"],
        orderShippingCity: json["orderShippingCity"],
        orderShippingCharge: json["orderShippingCharge"],
        orderConfirmSnt: json["orderConfirmSnt"],
        orderCreateDate: json["orderCreateDate"],
        foodType: json["foodType"],
        permanentAddress: json["permanentAddress"],
        orderShippingAddress1: json["orderShippingAddress1"],
        orderCity: json["orderCity"],
        state: json["state"],
        orderCountry: json["orderCountry"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        orderEmailAddress: json["orderEmailAddress"],
        orderLocaly: json["orderLocaly"],
        landMark: json["landMark"],
        orderPaymentType: json["orderPaymentType"],
        amounttPaidByNetbanking: json["amounttPaidByNetbanking"],
        amountPaidByCashOnDelivery: json["amountPaidByCashOnDelivery"],
        amountPaidByCardbank: json["amountPaidByCardbank"],
        orderPhoneNumber: json["orderPhoneNumber"],
        orderProductDetails: json["orderProductDetails"],
        orderPrice: json["orderPrice"],
        orderNumber: json["orderNumber"],
        orderDate: json["orderDate"],
        orderInvoiceNumber: json["orderInvoiceNumber"],
        orderFrom: json["orderFrom"],
        deliveryDate: json["deliveryDate"],
        discountAmount: json["discountAmount"],
        orderTaxAmount: json["orderTaxAmount"],
    );

    Map<String, dynamic> toJson() => {
        "companyCode": companyCode,
        "userName": userName,
        "customerName": customerName,
        "userId": userId,
        "productName": productName,
        "productId": productId,
        "productCategory": productCategory,
        "itemWeight": itemWeight,
        "orderItemTotalWeight": orderItemTotalWeight,
        "orderGrandTotal": orderGrandTotal,
        "orderUserComment": orderUserComment,
        "orderTotalQuantity": orderTotalQuantity,
        "orderTotalPrice": orderTotalPrice,
        "orderTime": orderTime,
        "orderSubsAmount": orderSubsAmount,
        "sellingPrice": sellingPrice,
        "shippingState": shippingState,
        "orderShippingPinCode": orderShippingPinCode,
        "orderShippingCity": orderShippingCity,
        "orderShippingCharge": orderShippingCharge,
        "orderConfirmSnt": orderConfirmSnt,
        "orderCreateDate": orderCreateDate,
        "foodType": foodType,
        "permanentAddress": permanentAddress,
        "orderShippingAddress1": orderShippingAddress1,
        "orderCity": orderCity,
        "state": state,
        "orderCountry": orderCountry,
        "firstName": firstName,
        "lastName": lastName,
        "orderEmailAddress": orderEmailAddress,
        "orderLocaly": orderLocaly,
        "landMark": landMark,
        "orderPaymentType": orderPaymentType,
        "amounttPaidByNetbanking": amounttPaidByNetbanking,
        "amountPaidByCashOnDelivery": amountPaidByCashOnDelivery,
        "amountPaidByCardbank": amountPaidByCardbank,
        "orderPhoneNumber": orderPhoneNumber,
        "orderProductDetails": orderProductDetails,
        "orderPrice": orderPrice,
        "orderNumber": orderNumber,
        "orderDate": orderDate,
        "orderInvoiceNumber": orderInvoiceNumber,
        "orderFrom": orderFrom,
        "deliveryDate": deliveryDate,
        "discountAmount": discountAmount,
        "orderTaxAmount": orderTaxAmount,
    };
}
// To parse this JSON data, do
//
//     final orderRequestModel = orderRequestModelFromJson(jsonString);


OrderRequestModel orderRequestModelFromJson(String str) => OrderRequestModel.fromJson(json.decode(str));

String orderRequestModelToJson(OrderRequestModel data) => json.encode(data.toJson());

class OrderRequestModel {
    OrderRequestModel({
        this.companyCode,
        this.userName,
        this.customerName,
        this.userId,
        this.productName,
        this.productId,
        this.productCategory,
        this.itemWeight,
        this.orderUserComment,
        this.orderItemTotalWeight,
        this.orderGrandTotal,
        this.orderTotalQuantity,
        this.orderTotalPrice,
        this.orderTime,
        this.orderSubsAmount,
        this.sellingPrice,
        this.shippingState,
        this.orderShippingPinCode,
        this.orderShippingCity,
        this.orderShippingCharge,
        this.orderConfirmSnt,
        this.orderCreateDate,
        this.foodType,
        this.permanentAddress,
        this.orderShippingAddress1,
        this.orderCity,
        this.state,
        this.orderCountry,
        this.firstName,
        this.lastName,
        this.orderEmailAddress,
        this.orderLocaly,
        this.landMark,
        this.orderPaymentType,
        this.amounttPaidByNetbanking,
        this.amountPaidByCashOnDelivery,
        this.amountPaidByCardbank,
        this.orderPhoneNumber,
        this.orderProductDetails,
        this.orderPrice,
        this.orderNumber,
        this.orderDate,
        this.orderFrom,
        this.orderInvoiceNumber,
        this.deliveryDate,
        this.discountAmount,
        this.orderTaxAmount,
    });

    String companyCode;
    String userName;
    String customerName;
    int userId;
    String productName;
    String productId;
    String productCategory;
    String itemWeight;
    String orderUserComment;
    String orderItemTotalWeight;
    String orderGrandTotal;
    int orderTotalQuantity;
    int orderTotalPrice;
    String orderTime;
    int orderSubsAmount;
    int sellingPrice;
    String shippingState;
    String orderShippingPinCode;
    String orderShippingCity;
    int orderShippingCharge;
    String orderConfirmSnt;
    String orderCreateDate;
    String foodType;
    String permanentAddress;
    String orderShippingAddress1;
    String orderCity;
    String state;
    String orderCountry;
    String firstName;
    String lastName;
    String orderEmailAddress;
    String orderLocaly;
    String landMark;
    String orderPaymentType;
    int amounttPaidByNetbanking;
    int amountPaidByCashOnDelivery;
    int amountPaidByCardbank;
    int orderPhoneNumber;
    String orderProductDetails;
    int orderPrice;
    int orderNumber;
    String orderDate;
    String orderFrom;
    int orderInvoiceNumber;
    String deliveryDate;
    int discountAmount;
    int orderTaxAmount;

    factory OrderRequestModel.fromJson(Map<String, dynamic> json) => OrderRequestModel(
        companyCode: json["companyCode"],
        userName: json["userName"],
        customerName: json["customerName"],
        userId: json["userId"],
        productName: json["productName"],
        productId: json["productId"],
        productCategory: json["productCategory"],
        itemWeight: json["itemWeight"],
        orderUserComment: json["orderUserComment"],
        orderItemTotalWeight: json["orderItemTotalWeight"],
        orderGrandTotal: json["orderGrandTotal"],
        orderTotalQuantity: json["orderTotalQuantity"],
        orderTotalPrice: json["orderTotalPrice"],
        orderTime: json["orderTime"],
        orderSubsAmount: json["orderSubsAmount"],
        sellingPrice: json["sellingPrice"],
        shippingState: json["shippingState"],
        orderShippingPinCode: json["orderShippingPinCode"],
        orderShippingCity: json["orderShippingCity"],
        orderShippingCharge: json["orderShippingCharge"],
        orderConfirmSnt: json["orderConfirmSnt"],
        orderCreateDate: json["orderCreateDate"],
        foodType: json["foodType"],
        permanentAddress: json["permanentAddress"],
        orderShippingAddress1: json["orderShippingAddress1"],
        orderCity: json["orderCity"],
        state: json["state"],
        orderCountry: json["orderCountry"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        orderEmailAddress: json["orderEmailAddress"],
        orderLocaly: json["orderLocaly"],
        landMark: json["landMark"],
        orderPaymentType: json["orderPaymentType"],
        amounttPaidByNetbanking: json["amounttPaidByNetbanking"],
        amountPaidByCashOnDelivery: json["amountPaidByCashOnDelivery"],
        amountPaidByCardbank: json["amountPaidByCardbank"],
        orderPhoneNumber: json["orderPhoneNumber"],
        orderProductDetails: json["orderProductDetails"],
        orderPrice: json["orderPrice"],
        orderNumber: json["orderNumber"],
        orderDate: json["orderDate"],
        orderFrom: json["orderFrom"],
        orderInvoiceNumber: json["orderInvoiceNumber"],
        deliveryDate: json["deliveryDate"],
        discountAmount: json["discountAmount"],
        orderTaxAmount: json["orderTaxAmount"],
    );

    Map<String, dynamic> toJson() => {
        "companyCode": companyCode,
        "userName": userName,
        "customerName": customerName,
        "userId": userId,
        "productName": productName,
        "productId": productId,
        "productCategory": productCategory,
        "itemWeight": itemWeight,
        "orderUserComment": orderUserComment,
        "orderItemTotalWeight": orderItemTotalWeight,
        "orderGrandTotal": orderGrandTotal,
        "orderTotalQuantity": orderTotalQuantity,
        "orderTotalPrice": orderTotalPrice,
        "orderTime": orderTime,
        "orderSubsAmount": orderSubsAmount,
        "sellingPrice": sellingPrice,
        "shippingState": shippingState,
        "orderShippingPinCode": orderShippingPinCode,
        "orderShippingCity": orderShippingCity,
        "orderShippingCharge": orderShippingCharge,
        "orderConfirmSnt": orderConfirmSnt,
        "orderCreateDate": orderCreateDate,
        "foodType": foodType,
        "permanentAddress": permanentAddress,
        "orderShippingAddress1": orderShippingAddress1,
        "orderCity": orderCity,
        "state": state,
        "orderCountry": orderCountry,
        "firstName": firstName,
        "lastName": lastName,
        "orderEmailAddress": orderEmailAddress,
        "orderLocaly": orderLocaly,
        "landMark": landMark,
        "orderPaymentType": orderPaymentType,
        "amounttPaidByNetbanking": amounttPaidByNetbanking,
        "amountPaidByCashOnDelivery": amountPaidByCashOnDelivery,
        "amountPaidByCardbank": amountPaidByCardbank,
        "orderPhoneNumber": orderPhoneNumber,
        "orderProductDetails": orderProductDetails,
        "orderPrice": orderPrice,
        "orderNumber": orderNumber,
        "orderDate": orderDate,
        "orderFrom": orderFrom,
        "orderInvoiceNumber": orderInvoiceNumber,
        "deliveryDate": deliveryDate,
        "discountAmount": discountAmount,
        "orderTaxAmount": orderTaxAmount,
    };
}
