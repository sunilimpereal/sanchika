// To parse this JSON data, do
//
//     final addtocartRequest = addtocartRequestFromJson(jsonString);

import 'dart:convert';

AddtocartRequest addtocartRequestFromJson(String str) => AddtocartRequest.fromJson(json.decode(str));

String addtocartRequestToJson(AddtocartRequest data) => json.encode(data.toJson());

class AddtocartRequest {
    AddtocartRequest({
        this.productId,
        this.productName,
        this.price,
        this.productSellingPrice,
        this.grandTotal,
        this.totalWeght,
        this.userId,
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
        this.gid,
        this.image,
        this.quantity,
        this.selectedDate,
        this.sellingId,
        this.size,
    });

    String productId;
    String productName;
    double price;
    double productSellingPrice;
    String grandTotal;
    String totalWeght;
    int userId;
    String paket;
    double subsAmount;
    int subscode;
    int subsRedeemd;
    double taxAmount;
    String taxPre;
    String uom;
    int chst;
    String companyCode;
    String categoryId;
    String foodType;
    int gid;
    String image;
    int quantity;
    String selectedDate;
    String sellingId;
    String size;

    factory AddtocartRequest.fromJson(Map<String, dynamic> json) => AddtocartRequest(
        productId: json["productId"],
        productName: json["productName"],
        price: json["price"],
        productSellingPrice: json["productSellingPrice"],
        grandTotal: json["grandTotal"],
        totalWeght: json["totalWeght"],
        userId: json["userId"],
        paket: json["paket"],
        subsAmount: json["subsAmount"],
        subscode: json["subscode"],
        subsRedeemd: json["subsRedeemd"],
        taxAmount: json["taxAmount"].toDouble(),
        taxPre: json["taxPre"],
        uom: json["uom"],
        chst: json["chst"],
        companyCode: json["companyCode"],
        categoryId: json["categoryId"],
        foodType: json["foodType"],
        gid: json["gid"],
        image: json["image"],
        quantity: json["quantity"],
        selectedDate: json["selectedDate"],
        sellingId: json["sellingId"],
        size: json["size"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "productName": productName,
        "price": price,
        "productSellingPrice": productSellingPrice,
        "grandTotal": grandTotal,
        "totalWeght": totalWeght,
        "userId": userId,
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
        "gid": gid,
        "image": image,
        "quantity": quantity,
        "selectedDate": selectedDate,
        "sellingId": sellingId,
        "size": size,
    };
}
