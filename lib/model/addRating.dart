// To parse this JSON data, do
//
//     final addRating = addRatingFromJson(jsonString);

import 'dart:convert';

AddRating addRatingFromJson(String str) => AddRating.fromJson(json.decode(str));

String addRatingToJson(AddRating data) => json.encode(data.toJson());

class AddRating {
  AddRating({
    this.status,
    this.statusMsg,
    this.errorCode,
    this.data,
  });

  String status;
  String statusMsg;
  dynamic errorCode;
  Data data;

  factory AddRating.fromJson(Map<String, dynamic> json) => AddRating(
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
    this.rattingAndView,
  });

  RattingAndReview rattingAndView;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        rattingAndView: RattingAndReview.fromJson(json["Ratting and View "]),
      );

  Map<String, dynamic> toJson() => {
        "Ratting and View ": rattingAndView.toJson(),
      };
}

class RattingAndReview {
  RattingAndReview({
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

  factory RattingAndReview.fromJson(Map<String, dynamic> json) =>
      RattingAndReview(
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
// To parse this JSON data, do
//
//     final ratingrRequestModel = ratingrRequestModelFromJson(jsonString);

RatingRequestModel ratingrRequestModelFromJson(String str) =>
    RatingRequestModel.fromJson(json.decode(str));

String ratingrRequestModelToJson(RatingRequestModel data) =>
    json.encode(data.toJson());

class RatingRequestModel {
  RatingRequestModel({
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

  factory RatingRequestModel.fromJson(Map<String, dynamic> json) =>
      RatingRequestModel(
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
