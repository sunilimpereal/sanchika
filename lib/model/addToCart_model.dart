// To parse this JSON data, do
//
//     final addToCart = addToCartFromJson(jsonString);

import 'dart:convert';

AddToCart addToCartFromJson(String str) => AddToCart.fromJson(json.decode(str));

String addToCartToJson(AddToCart data) => json.encode(data.toJson());

class AddToCart {
    AddToCart({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory AddToCart.fromJson(Map<String, dynamic> json) => AddToCart(
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
        this.addToCart,
    });

    AddToCartClass addToCart;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        addToCart: AddToCartClass.fromJson(json["AddToCart "]),
    );

    Map<String, dynamic> toJson() => {
        "AddToCart ": addToCart.toJson(),
    };
}

class AddToCartClass {
    AddToCartClass({
        this.id,
        this.grandTotal,
        this.totalWeght,
        this.paket,
        this.subsAmount,
        this.subscode,
        this.subsRedeemd,
        this.taxAmount,
        this.taxPre,
        this.uom,
        this.chst,
        this.companyCode,
        this.categoryId,
        this.foodType,
        this.gnd,
        this.gid,
        this.image,
        this.language,
        this.price,
        this.productId,
        this.productName,
        this.productSellingPrice,
        this.quantity,
        this.scheduleClass,
        this.selectedDate,
        this.sellingId,
        this.shldr,
        this.size,
        this.userId,
    });

    int id;
    dynamic grandTotal;
    String totalWeght;
    dynamic paket;
    dynamic subsAmount;
    dynamic subscode;
    dynamic subsRedeemd;
    dynamic taxAmount;
    dynamic taxPre;
    dynamic uom;
    dynamic chst;
    String companyCode;
    String categoryId;
    dynamic foodType;
    dynamic gnd;
    dynamic gid;
    String image;
    dynamic language;
    int price;
    String productId;
    String productName;
    int productSellingPrice;
    int quantity;
    dynamic scheduleClass;
    String selectedDate;
    dynamic sellingId;
    dynamic shldr;
    dynamic size;
    int userId;

    factory AddToCartClass.fromJson(Map<String, dynamic> json) => AddToCartClass(
        id: json["id"],
        grandTotal: json["grandTotal"],
        totalWeght: json["totalWeght"],
        paket: json["paket"],
        subsAmount: json["subsAmount"],
        subscode: json["subscode"],
        subsRedeemd: json["subsRedeemd"],
        taxAmount: json["taxAmount"],
        taxPre: json["taxPre"],
        uom: json["uom"],
        chst: json["chst"],
        companyCode: json["companyCode"],
        categoryId: json["categoryId"],
        foodType: json["foodType"],
        gnd: json["gnd"],
        gid: json["gid"],
        image: json["image"],
        language: json["language"],
        price: json["price"],
        productId: json["productId"],
        productName: json["productName"],
        productSellingPrice: json["productSellingPrice"],
        quantity: json["quantity"],
        scheduleClass: json["scheduleClass"],
        selectedDate: json["selectedDate"],
        sellingId: json["sellingId"],
        shldr: json["shldr"],
        size: json["size"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "grandTotal": grandTotal,
        "totalWeght": totalWeght,
        "paket": paket,
        "subsAmount": subsAmount,
        "subscode": subscode,
        "subsRedeemd": subsRedeemd,
        "taxAmount": taxAmount,
        "taxPre": taxPre,
        "uom": uom,
        "chst": chst,
        "companyCode": companyCode,
        "categoryId": categoryId,
        "foodType": foodType,
        "gnd": gnd,
        "gid": gid,
        "image": image,
        "language": language,
        "price": price,
        "productId": productId,
        "productName": productName,
        "productSellingPrice": productSellingPrice,
        "quantity": quantity,
        "scheduleClass": scheduleClass,
        "selectedDate": selectedDate,
        "sellingId": sellingId,
        "shldr": shldr,
        "size": size,
        "userId": userId,
    };
}
