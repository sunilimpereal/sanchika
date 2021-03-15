// To parse this JSON data, do
//
//     final getbanner = getbannerFromJson(jsonString);

import 'dart:convert';

Getbanner getbannerFromJson(String str) => Getbanner.fromJson(json.decode(str));

String getbannerToJson(Getbanner data) => json.encode(data.toJson());

class Getbanner {
    Getbanner({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory Getbanner.fromJson(Map<String, dynamic> json) => Getbanner(
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
        this.bannerMaster,
    });

    List<BannerMaster> bannerMaster;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        bannerMaster: List<BannerMaster>.from(json["BannerMaster"].map((x) => BannerMaster.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "BannerMaster": List<dynamic>.from(bannerMaster.map((x) => x.toJson())),
    };
}

class BannerMaster {
    BannerMaster({
        this.id,
        this.serialNumber,
        this.bannerTitleOne,
        this.bannerTitleTwo,
        this.textLine,
        this.bannerDescription,
        this.bannerActionButtonType,
        this.linkToImageUrl,
        this.enterVideoButtonType,
        this.startdate,
        this.endDate,
        this.webImageUrl,
        this.videourl,
        this.mobileImageUrl,
    });

    int id;
    dynamic serialNumber;
    String bannerTitleOne;
    String bannerTitleTwo;
    dynamic textLine;
    String bannerDescription;
    String bannerActionButtonType;
    bool linkToImageUrl;
    String enterVideoButtonType;
    String startdate;
    String endDate;
    String webImageUrl;
    String videourl;
    String mobileImageUrl;

    factory BannerMaster.fromJson(Map<String, dynamic> json) => BannerMaster(
        id: json["id"],
        serialNumber: json["serialNumber"],
        bannerTitleOne: json["bannerTitleOne"],
        bannerTitleTwo: json["bannerTitleTwo"],
        textLine: json["textLine"],
        bannerDescription: json["bannerDescription"],
        bannerActionButtonType: json["bannerActionButtonType"],
        linkToImageUrl: json["linkToImageUrl"],
        enterVideoButtonType: json["enterVideoButtonType"],
        startdate: json["startdate"],
        endDate: json["endDate"],
        webImageUrl: json["webImageUrl"],
        videourl: json["videourl"],
        mobileImageUrl: json["mobileImageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "serialNumber": serialNumber,
        "bannerTitleOne": bannerTitleOne,
        "bannerTitleTwo": bannerTitleTwo,
        "textLine": textLine,
        "bannerDescription": bannerDescription,
        "bannerActionButtonType": bannerActionButtonType,
        "linkToImageUrl": linkToImageUrl,
        "enterVideoButtonType": enterVideoButtonType,
        "startdate": startdate,
        "endDate": endDate,
        "webImageUrl": webImageUrl,
        "videourl": videourl,
        "mobileImageUrl": mobileImageUrl,
    };
}
