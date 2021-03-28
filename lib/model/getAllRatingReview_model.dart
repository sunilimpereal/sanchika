// To parse this JSON data, do
//
//     final getAllRatingAndReview = getAllRatingAndReviewFromJson(jsonString);

import 'dart:convert';

GetAllRatingAndReview getAllRatingAndReviewFromJson(String str) => GetAllRatingAndReview.fromJson(json.decode(str));

String getAllRatingAndReviewToJson(GetAllRatingAndReview data) => json.encode(data.toJson());

class GetAllRatingAndReview {
    GetAllRatingAndReview({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetAllRatingAndReview.fromJson(Map<String, dynamic> json) => GetAllRatingAndReview(
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
        this.rattingAndViewIsGetting,
    });

    List<RatingAndReview> rattingAndViewIsGetting;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        rattingAndViewIsGetting: List<RatingAndReview>.from(json["Ratting and View is getting "].map((x) => RatingAndReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Ratting and View is getting ": List<dynamic>.from(rattingAndViewIsGetting.map((x) => x.toJson())),
    };
}

class RatingAndReview {
    RatingAndReview({
        this.id,
        this.companyCode,
        this.description,
        this.disLike,
        this.like,
        this.name,
        this.productId,
        this.ratingDate,
        this.rating,
        this.review,
        this.status,
        this.userId,
        this.userName,
    });

    int id;
    String companyCode;
    String description;
    bool disLike;
    bool like;
    String name;
    String productId;
    String ratingDate;
    int rating;
    String review;
    bool status;
    int userId;
    String userName;

    factory RatingAndReview.fromJson(Map<String, dynamic> json) => RatingAndReview(
        id: json["id"],
        companyCode: json["companyCode"],
        description: json["description"],
        disLike: json["disLike"],
        like: json["like"],
        name: json["name"],
        productId: json["productId"],
        ratingDate: json["ratingDate"],
        rating: json["rating"],
        review: json["review"],
        status: json["status"],
        userId: json["userId"],
        userName: json["userName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "companyCode": companyCode,
        "description": description,
        "disLike": disLike,
        "like": like,
        "name": name,
        "productId": productId,
        "ratingDate": ratingDate,
        "rating": rating,
        "review": review,
        "status": status,
        "userId": userId,
        "userName": userName,
    };
}
