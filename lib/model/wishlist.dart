import 'dart:convert';

class Wishlist {}

class WishlistItem {
  String productId;
  String userId;
  int quantity;
  int gid;
  WishlistItem({this.productId, this.userId, this.quantity, this.gid});
}
// To parse this JSON data, do
//
//     final getWishlist = getWishlistFromJson(jsonString);

GetWishlist getWishlistFromJson(String str) =>
    GetWishlist.fromJson(json.decode(str));

String getWishlistToJson(GetWishlist data) => json.encode(data.toJson());

class GetWishlist {
  GetWishlist({
    this.status,
    this.statusMsg,
    this.errorCode,
    this.data,
  });

  String status;
  String statusMsg;
  dynamic errorCode;
  Data data;

  factory GetWishlist.fromJson(Map<String, dynamic> json) => GetWishlist(
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
    this.wishListMaster,
  });

  List<WishListMaster> wishListMaster;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wishListMaster: List<WishListMaster>.from(
            json["WishListMaster"].map((x) => WishListMaster.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "WishListMaster":
            List<dynamic>.from(wishListMaster.map((x) => x.toJson())),
      };
}

class WishListMaster {
  WishListMaster({
    this.wishListId,
    this.productId,
    this.userId,
    this.quantity,
    this.gid,
  });

  int wishListId;
  String productId;
  int userId;
  int quantity;
  dynamic gid;

  factory WishListMaster.fromJson(Map<String, dynamic> json) => WishListMaster(
        wishListId: json["wishListId"],
        productId: json["productId"],
        userId: json["userId"],
        quantity: json["quantity"],
        gid: json["gid"],
      );

  Map<String, dynamic> toJson() => {
        "wishListId": wishListId,
        "productId": productId,
        "userId": userId,
        "quantity": quantity,
        "gid": gid,
      };
}
