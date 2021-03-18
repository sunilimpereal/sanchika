// To parse this JSON data, do
//
//     final getSubMenu = getSubMenuFromJson(jsonString);

import 'dart:convert';

GetSubMenu getSubMenuFromJson(String str) => GetSubMenu.fromJson(json.decode(str));

String getSubMenuToJson(GetSubMenu data) => json.encode(data.toJson());

class GetSubMenu {
    GetSubMenu({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetSubMenu.fromJson(Map<String, dynamic> json) => GetSubMenu(
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
        this.subMenu,
    });

    List<SubMenu> subMenu;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        subMenu: List<SubMenu>.from(json["Sub menu "].map((x) => SubMenu.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Sub menu ": List<dynamic>.from(subMenu.map((x) => x.toJson())),
    };
}

class SubMenu {
    SubMenu({
        this.menuId,
        this.menuTitle,
    });

    int menuId;
    String menuTitle;

    factory SubMenu.fromJson(Map<String, dynamic> json) => SubMenu(
        menuId: json["menuId"],
        menuTitle: json["menuTitle"],
    );

    Map<String, dynamic> toJson() => {
        "menuId": menuId,
        "menuTitle": menuTitle,
    };
}
