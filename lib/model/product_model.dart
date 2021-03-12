// To parse this JSON data, do
//
//     final getProduct = getProductFromJson(jsonString);

import 'dart:convert';

GetProduct getProductFromJson(String str) => GetProduct.fromJson(json.decode(str));

String getProductToJson(GetProduct data) => json.encode(data.toJson());

class GetProduct {
    GetProduct({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetProduct.fromJson(Map<String, dynamic> json) => GetProduct(
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
        this.ctgyProductDetailsList,
    });

    List<CtgyProductDetailsList> ctgyProductDetailsList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        ctgyProductDetailsList: List<CtgyProductDetailsList>.from(json["ctgy Product Details List"].map((x) => CtgyProductDetailsList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ctgy Product Details List": List<dynamic>.from(ctgyProductDetailsList.map((x) => x.toJson())),
    };
}

class CtgyProductDetailsList {
    CtgyProductDetailsList({
        this.id,
        this.productId,
        this.productStatus,
        this.productQuantity,
        this.productWeight,
        this.brandId,
        this.status,
        this.productName,
        this.productImage,
        this.productCategoryId,
        this.productCategoryNm,
        this.productDescription,
        this.slPrice,
        this.mrpPrice,
    });

    String id;
    String productId;
    String productStatus;
    String productQuantity;
    ProductWeight productWeight;
    String brandId;
    String status;
    String productName;
    String productImage;
    String productCategoryId;
    ProductCategoryNm productCategoryNm;
    String productDescription;
    String slPrice;
    String mrpPrice;

    factory CtgyProductDetailsList.fromJson(Map<String, dynamic> json) => CtgyProductDetailsList(
        id: json["id"],
        productId: json["productId"],
        productStatus: json["productStatus"],
        productQuantity: json["productQuantity"],
        productWeight: productWeightValues.map[json["productWeight"]],
        brandId: json["brandId"],
        status: json["status"],
        productName: json["productName"],
        productImage: json["productImage"],
        productCategoryId: json["productCategoryId"],
        productCategoryNm: productCategoryNmValues.map[json["productCategoryNM"]],
        productDescription: json["productDescription"],
        slPrice: json["slPrice"],
        mrpPrice: json["mrpPrice"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "productStatus": productStatus,
        "productQuantity": productQuantity,
        "productWeight": productWeightValues.reverse[productWeight],
        "brandId": brandId,
        "status": status,
        "productName": productName,
        "productImage": productImage,
        "productCategoryId": productCategoryId,
        "productCategoryNM": productCategoryNmValues.reverse[productCategoryNm],
        "productDescription": productDescription,
        "slPrice": slPrice,
        "mrpPrice": mrpPrice,
    };
}

enum ProductCategoryNm { DAIRY_FROZEN }

final productCategoryNmValues = EnumValues({
    "DAIRY  FROZEN": ProductCategoryNm.DAIRY_FROZEN
});

enum ProductWeight { PCS }

final productWeightValues = EnumValues({
    "PCS": ProductWeight.PCS
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
