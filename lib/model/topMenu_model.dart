// To parse this JSON data, do
//
//     final getTopMenu = getTopMenuFromJson(jsonString);

import 'dart:convert';

GetTopMenu getTopMenuFromJson(String str) => GetTopMenu.fromJson(json.decode(str));

String getTopMenuToJson(GetTopMenu data) => json.encode(data.toJson());

class GetTopMenu {
    GetTopMenu({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetTopMenu.fromJson(Map<String, dynamic> json) => GetTopMenu(
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
        this.topMenu,
    });

    List<TopMenu> topMenu;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        topMenu: List<TopMenu>.from(json["Top menu "].map((x) => TopMenu.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Top menu ": List<dynamic>.from(topMenu.map((x) => x.toJson())),
    };
}

class TopMenu {
    TopMenu({
        this.menuId,
        this.menuTitle,
    });

    int menuId;
    String menuTitle;

    factory TopMenu.fromJson(Map<String, dynamic> json) => TopMenu(
        menuId: json["menuId"],
        menuTitle: json["menuTitle"],
    );

    Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "menuTitle": menuTitle,
    };
}
