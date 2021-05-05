// To parse this JSON data, do
//
//     final placedOrder = placedOrderFromJson(jsonString);

import 'dart:convert';

PlacedOrder placedOrderFromJson(String str) => PlacedOrder.fromJson(json.decode(str));

String placedOrderToJson(PlacedOrder data) => json.encode(data.toJson());

class PlacedOrder {
    PlacedOrder({
        this.status,
        this.statusMsg,
        this.errorCode,
        this.data,
    });

    String status;
    String statusMsg;
    dynamic errorCode;
    Data data;

    factory PlacedOrder.fromJson(Map<String, dynamic> json) => PlacedOrder(
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
        this.orderUserDetails,
    });

    Map<String, OrderUserDetails> orderUserDetails;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderUserDetails: Map.from(json["Order User  Details "]).map((k, v) => MapEntry<String, OrderUserDetails>(k, OrderUserDetails.fromJson(v))),
    );

    Map<String, dynamic> toJson() => {
        "Order User  Details ": Map.from(orderUserDetails).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    };
}

class OrderUserDetails {
    OrderUserDetails({
        this.orderHeader,
        this.orderHeaderDetail,
        this.orderShippingDetail,
    });

    OrderHeader orderHeader;
    List<dynamic> orderHeaderDetail;
    OrderShippingDetail orderShippingDetail;

    factory OrderUserDetails.fromJson(Map<String, dynamic> json) => OrderUserDetails(
        orderHeader: OrderHeader.fromJson(json["OrderHeader"]),
        orderHeaderDetail: List<dynamic>.from(json["OrderHeaderDetail"].map((x) => x)),
        orderShippingDetail: OrderShippingDetail.fromJson(json["OrderShippingDetail"]),
    );

    Map<String, dynamic> toJson() => {
        "OrderHeader": orderHeader.toJson(),
        "OrderHeaderDetail": List<dynamic>.from(orderHeaderDetail.map((x) => x)),
        "OrderShippingDetail": orderShippingDetail.toJson(),
    };
}

class OrderHeader {
    OrderHeader({
        this.wohId,
        this.wohCmyCd,
        this.wohStrCd,
        this.wohOrdNum,
        this.wohOrdDt,
        this.wohOrdTime,
        this.wohInvcNum,
        this.wohInvcDt,
        this.wohOrdMod,
        this.wohDvDt,
        this.wohUsrId,
        this.wohUsrNm,
        this.wohPhNum,
        this.wohEmlId,
        this.wohCstType,
        this.wohShpSt,
        this.wohAdmCmt,
        this.wohUsrCmt,
        this.wohTotQnt,
        this.wohTotItm,
        this.wohMrp,
        this.wohTotPrc,
        this.wohDisAmt,
        this.wohSubsAmt,
        this.wohTxAmt,
        this.wohGrndTot,
        this.wohShpChrg,
        this.wohNetAmt,
        this.wohPymTyp,
        this.wohPymMod,
        this.wohPymRecd,
        this.wohDelvryType,
        this.wohStatus,
        this.wohSycDtTm,
        this.wohCpnCd,
        this.wohCpnRedmd,
        this.wohTxId,
    });

    int wohId;
    String wohCmyCd;
    String wohStrCd;
    int wohOrdNum;
    DateTime wohOrdDt;
    String wohOrdTime;
    String wohInvcNum;
    DateTime wohInvcDt;
    String wohOrdMod;
    DateTime wohDvDt;
    int wohUsrId;
    String wohUsrNm;
    String wohPhNum;
    String wohEmlId;
    String wohCstType;
    String wohShpSt;
    String wohAdmCmt;
    String wohUsrCmt;
    String wohTotQnt;
    String wohTotItm;
    int wohMrp;
    int wohTotPrc;
    int wohDisAmt;
    int wohSubsAmt;
    int wohTxAmt;
    int wohGrndTot;
    int wohShpChrg;
    int wohNetAmt;
    String wohPymTyp;
    String wohPymMod;
    String wohPymRecd;
    String wohDelvryType;
    String wohStatus;
    dynamic wohSycDtTm;
    String wohCpnCd;
    String wohCpnRedmd;
    dynamic wohTxId;

    factory OrderHeader.fromJson(Map<String, dynamic> json) => OrderHeader(
        wohId: json["woh_id"],
        wohCmyCd: json["woh_cmy_cd"],
        wohStrCd: json["woh_str_cd"],
        wohOrdNum: json["woh_ord_num"],
        wohOrdDt: DateTime.parse(json["woh_ord_dt"]),
        wohOrdTime: json["woh_ord_time"],
        wohInvcNum: json["woh_invc_num"],
        wohInvcDt: DateTime.parse(json["woh_invc_dt"]),
        wohOrdMod: json["woh_ord_mod"],
        wohDvDt: DateTime.parse(json["woh_dv_dt"]),
        wohUsrId: json["woh_usr_id"],
        wohUsrNm: json["woh_usr_nm"],
        wohPhNum: json["woh_ph_num"],
        wohEmlId: json["woh_eml_id"],
        wohCstType: json["woh_cst_type"],
        wohShpSt: json["woh_shp_st"],
        wohAdmCmt: json["woh_adm_cmt"],
        wohUsrCmt: json["woh_usr_cmt"],
        wohTotQnt: json["woh_tot_qnt"],
        wohTotItm: json["woh_tot_itm"],
        wohMrp: json["woh_mrp"],
        wohTotPrc: json["woh_tot_prc"],
        wohDisAmt: json["woh_dis_amt"],
        wohSubsAmt: json["woh_subs_amt"],
        wohTxAmt: json["woh_tx_amt"],
        wohGrndTot: json["woh_grnd_tot"],
        wohShpChrg: json["woh_shp_chrg"],
        wohNetAmt: json["woh_net_amt"],
        wohPymTyp: json["woh_pym_typ"],
        wohPymMod: json["woh_pym_mod"],
        wohPymRecd: json["woh_pym_recd"],
        wohDelvryType: json["woh_delvry_type"],
        wohStatus: json["woh_status"],
        wohSycDtTm: json["woh_syc_dt_tm"],
        wohCpnCd: json["woh_cpn_cd"],
        wohCpnRedmd: json["woh_cpn_redmd"],
        wohTxId: json["woh_tx_id"],
    );

    Map<String, dynamic> toJson() => {
        "woh_id": wohId,
        "woh_cmy_cd": wohCmyCd,
        "woh_str_cd": wohStrCd,
        "woh_ord_num": wohOrdNum,
        "woh_ord_dt": "${wohOrdDt.year.toString().padLeft(4, '0')}-${wohOrdDt.month.toString().padLeft(2, '0')}-${wohOrdDt.day.toString().padLeft(2, '0')}",
        "woh_ord_time": wohOrdTime,
        "woh_invc_num": wohInvcNum,
        "woh_invc_dt": "${wohInvcDt.year.toString().padLeft(4, '0')}-${wohInvcDt.month.toString().padLeft(2, '0')}-${wohInvcDt.day.toString().padLeft(2, '0')}",
        "woh_ord_mod": wohOrdMod,
        "woh_dv_dt": "${wohDvDt.year.toString().padLeft(4, '0')}-${wohDvDt.month.toString().padLeft(2, '0')}-${wohDvDt.day.toString().padLeft(2, '0')}",
        "woh_usr_id": wohUsrId,
        "woh_usr_nm": wohUsrNm,
        "woh_ph_num": wohPhNum,
        "woh_eml_id": wohEmlId,
        "woh_cst_type": wohCstType,
        "woh_shp_st": wohShpSt,
        "woh_adm_cmt": wohAdmCmt,
        "woh_usr_cmt": wohUsrCmt,
        "woh_tot_qnt": wohTotQnt,
        "woh_tot_itm": wohTotItm,
        "woh_mrp": wohMrp,
        "woh_tot_prc": wohTotPrc,
        "woh_dis_amt": wohDisAmt,
        "woh_subs_amt": wohSubsAmt,
        "woh_tx_amt": wohTxAmt,
        "woh_grnd_tot": wohGrndTot,
        "woh_shp_chrg": wohShpChrg,
        "woh_net_amt": wohNetAmt,
        "woh_pym_typ": wohPymTyp,
        "woh_pym_mod": wohPymMod,
        "woh_pym_recd": wohPymRecd,
        "woh_delvry_type": wohDelvryType,
        "woh_status": wohStatus,
        "woh_syc_dt_tm": wohSycDtTm,
        "woh_cpn_cd": wohCpnCd,
        "woh_cpn_redmd": wohCpnRedmd,
        "woh_tx_id": wohTxId,
    };
}

class OrderShippingDetail {
    OrderShippingDetail({
        this.wosdId,
        this.wosdOrdNum,
        this.wosdCmyCd,
        this.wosdOrdDt,
        this.wosdCty,
        this.wosdCy,
        this.wosdEmlAds,
        this.wosdFsNm,
        this.wosdGnd,
        this.wosdIsDltd,
        this.wosdLcly,
        this.wosdLndMrk,
        this.wosdLsNm,
        this.wosdPhNum,
        this.wosdPin,
        this.wosdPrnAds,
        this.wosdShipAds1,
        this.wosdShipAds2,
        this.wosdSt,
        this.wosdSts,
        this.wosdUpdtDt,
        this.wosdUsrId,
        this.wosdUsrNm,
        this.wosdAddType,
        this.wosdSycDtTm,
        this.wosdTxId,
    });

    int wosdId;
    int wosdOrdNum;
    String wosdCmyCd;
    DateTime wosdOrdDt;
    String wosdCty;
    String wosdCy;
    String wosdEmlAds;
    String wosdFsNm;
    String wosdGnd;
    bool wosdIsDltd;
    String wosdLcly;
    String wosdLndMrk;
    String wosdLsNm;
    String wosdPhNum;
    String wosdPin;
    String wosdPrnAds;
    String wosdShipAds1;
    String wosdShipAds2;
    String wosdSt;
    String wosdSts;
    String wosdUpdtDt;
    int wosdUsrId;
    String wosdUsrNm;
    String wosdAddType;
    String wosdSycDtTm;
    dynamic wosdTxId;

    factory OrderShippingDetail.fromJson(Map<String, dynamic> json) => OrderShippingDetail(
        wosdId: json["wosd_id"],
        wosdOrdNum: json["wosd_ord_num"],
        wosdCmyCd: json["wosd_cmy_cd"],
        wosdOrdDt: DateTime.parse(json["wosd_ord_dt"]),
        wosdCty: json["wosd_cty"],
        wosdCy: json["wosd_cy"],
        wosdEmlAds: json["wosd_eml_ads"],
        wosdFsNm: json["wosd_fs_nm"],
        wosdGnd: json["wosd_gnd"],
        wosdIsDltd: json["wosd_is_dltd"],
        wosdLcly: json["wosd_lcly"],
        wosdLndMrk: json["wosd_lnd_mrk"],
        wosdLsNm: json["wosd_ls_nm"],
        wosdPhNum: json["wosd_ph_num"],
        wosdPin: json["wosd_pin"],
        wosdPrnAds: json["wosd_prn_ads"],
        wosdShipAds1: json["wosd_ship_ads1"],
        wosdShipAds2: json["wosd_ship_ads2"],
        wosdSt: json["wosd_st"],
        wosdSts: json["wosd_sts"],
        wosdUpdtDt: json["wosd_updt_dt"],
        wosdUsrId: json["wosd_usr_id"],
        wosdUsrNm: json["wosd_usr_nm"],
        wosdAddType: json["wosd_add_type"],
        wosdSycDtTm: json["wosd_syc_dt_tm"],
        wosdTxId: json["wosd_tx_id"],
    );

    Map<String, dynamic> toJson() => {
        "wosd_id": wosdId,
        "wosd_ord_num": wosdOrdNum,
        "wosd_cmy_cd": wosdCmyCd,
        "wosd_ord_dt": "${wosdOrdDt.year.toString().padLeft(4, '0')}-${wosdOrdDt.month.toString().padLeft(2, '0')}-${wosdOrdDt.day.toString().padLeft(2, '0')}",
        "wosd_cty": wosdCty,
        "wosd_cy": wosdCy,
        "wosd_eml_ads": wosdEmlAds,
        "wosd_fs_nm": wosdFsNm,
        "wosd_gnd": wosdGnd,
        "wosd_is_dltd": wosdIsDltd,
        "wosd_lcly": wosdLcly,
        "wosd_lnd_mrk": wosdLndMrk,
        "wosd_ls_nm": wosdLsNm,
        "wosd_ph_num": wosdPhNum,
        "wosd_pin": wosdPin,
        "wosd_prn_ads": wosdPrnAds,
        "wosd_ship_ads1": wosdShipAds1,
        "wosd_ship_ads2": wosdShipAds2,
        "wosd_st": wosdSt,
        "wosd_sts": wosdSts,
        "wosd_updt_dt": wosdUpdtDt,
        "wosd_usr_id": wosdUsrId,
        "wosd_usr_nm": wosdUsrNm,
        "wosd_add_type": wosdAddType,
        "wosd_syc_dt_tm": wosdSycDtTm,
        "wosd_tx_id": wosdTxId,
    };
}
