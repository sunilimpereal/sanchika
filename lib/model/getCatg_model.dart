// To parse this JSON data, do
//
//     final getCtg = getCtgFromJson(jsonString);

import 'dart:convert';

GetCtg getCtgFromJson(String str) => GetCtg.fromJson(json.decode(str));

String getCtgToJson(GetCtg data) => json.encode(data.toJson());

class GetCtg {
    GetCtg({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory GetCtg.fromJson(Map<String, dynamic> json) => GetCtg(
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
        this.ctgyNameAndIdList,
    });

    List<CtgyNameAndId> ctgyNameAndIdList;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        ctgyNameAndIdList: List<CtgyNameAndId>.from(json["ctgy name and id List"].map((x) => CtgyNameAndId.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ctgy name and id List": List<dynamic>.from(ctgyNameAndIdList.map((x) => x.toJson())),
    };
}

class CtgyNameAndId {
    CtgyNameAndId({
        this.mnId,
        this.ctgyNm,
    });

    String mnId;
    String ctgyNm;

    factory CtgyNameAndId.fromJson(Map<String, dynamic> json) => CtgyNameAndId(
        mnId: json["mnId"],
        ctgyNm: json["ctgyNm"],
    );

    Map<String, dynamic> toJson() => {
        "mnId": mnId,
        "ctgyNm": ctgyNm,
    };
}
